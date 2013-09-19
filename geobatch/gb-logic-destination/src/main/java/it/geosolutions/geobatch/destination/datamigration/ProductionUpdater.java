package it.geosolutions.geobatch.destination.datamigration;

import it.geosolutions.filesystemmonitor.monitor.FileSystemEvent;
import it.geosolutions.filesystemmonitor.monitor.FileSystemEventType;
import it.geosolutions.geobatch.actions.ds2ds.Ds2dsAction;
import it.geosolutions.geobatch.actions.ds2ds.Ds2dsConfiguration;
import it.geosolutions.geobatch.catalog.Identifiable;
import it.geosolutions.geobatch.destination.common.InputObject;
import it.geosolutions.geobatch.destination.datamigration.UpdaterFeatures.UpdaterFeature;
import it.geosolutions.geobatch.destination.datamigration.configuration.ProductionUpdaterConfiguration;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.ingestion.TargetIngestionProcess;
import it.geosolutions.geobatch.flow.event.IProgressListener;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.EventObject;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Queue;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.geotools.data.DataStore;
import org.geotools.data.DataStoreFinder;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.FeatureReader;
import org.geotools.data.Query;
import org.geotools.data.Transaction;
import org.geotools.data.simple.SimpleFeatureStore;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.filter.text.cql2.CQL;
import org.geotools.jdbc.JDBCDataStore;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.filter.Filter;
import org.opengis.filter.FilterFactory;
import org.opengis.filter.Id;
import org.opengis.filter.identity.FeatureId;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProductionUpdater extends InputObject{

	private final static Logger LOGGER = LoggerFactory.getLogger(ProductionUpdater.class);

	private static Pattern TYPE_NAME_PARTS = Pattern.compile("^([A-Z]{2})_([A-Z]{1})_([A-Za-z]+)_([0-9]{8})$");
	private static Properties targetTypes = new Properties();

	private Ds2dsConfiguration ds2dsConfiguration;
	private String codicePartner;
	private int partner;
	private int targetType;

	static {	
		// load mappings from resources
		try {			
			targetTypes.load(TargetIngestionProcess.class.getResourceAsStream("/targets.properties"));						
		} catch (IOException e) {
			LOGGER.error("Unable to load configuration: "+e.getMessage(), e);
		}
	}

	public ProductionUpdater(String inputTypeName,
			ProgressListenerForwarder listenerForwarder,
			MetadataIngestionHandler metadataHandler, JDBCDataStore dataStore) {
		super(inputTypeName, listenerForwarder, metadataHandler, dataStore);
		// TODO Auto-generated constructor stub
	}

	@Override
	protected boolean parseTypeName(String typeName) {
		Matcher m = TYPE_NAME_PARTS.matcher(typeName);
		if(m.matches()) {
			// partner alphanumerical abbreviation (from siig_t_partner)
			codicePartner = m.group(1);
			// partner numerical id (from siig_t_partner)
			partner = Integer.parseInt(partners.get(codicePartner).toString());			
			targetType = Integer.parseInt(targetTypes.get(m.group(3)).toString());
			return true;
		}
		return false;
	}

	private List<String> receivedEvents = new ArrayList<String>();

	private IProgressListener listener = new IProgressListener() {

		@Override
		public void terminated() {
			receivedEvents.add("terminated");				
		}

		@Override
		public void started() {
			receivedEvents.add("started");				
		}

		@Override
		public void setTask(String currentTask) {

		}

		@Override
		public void setProgress(float progress) {

		}

		@Override
		public void resumed() {
			receivedEvents.add("resumed");			
		}

		@Override
		public void progressing() {
			receivedEvents.add("progressing");		
		}

		@Override
		public void paused() {
			receivedEvents.add("paused");			
		}

		@Override
		public String getTask() {				
			return null;
		}

		@Override
		public float getProgress() {
			return 0;
		}

		@Override
		public Identifiable getOwner() {				
			return null;
		}

		@Override
		public void failed(Throwable exception) {
			receivedEvents.add("failed");			
		}

		@Override
		public void completed() {
			receivedEvents.add("completed");			
		}
	};

	private Queue<EventObject> getEvents() throws URISyntaxException {
		Queue<EventObject> events = new LinkedList<EventObject>();
		FileSystemEvent event = new FileSystemEvent(new File("run.run") , FileSystemEventType.FILE_ADDED);
		events.add(event);
		return events;
	}

	public void execute() throws Exception {
		UpdaterFeatures updaterFeatures  = UpdaterFeatures.fromXML(this.getClass().getClassLoader().getResourceAsStream("datamigration.xml"));
		UpdaterFeatures targetFeature = new UpdaterFeatures();
		UpdaterFeatures arcFeature = new UpdaterFeatures();
		for(UpdaterFeature f : updaterFeatures.getFeatures()){
			if(f.getTarget()!=null && f.getTarget()){
				targetFeature.getFeatures().add(f);
			}else{
				arcFeature.getFeatures().add(f);
			}
		}
		executeTarget(targetFeature);
		executeArc(arcFeature);

	}

	public void executeTarget(UpdaterFeatures targetFeature) throws Exception {

		Map<String, Serializable> destinationDataStoreConfig = this.ds2dsConfiguration.getOutputFeature().getDataStore();
		DataStore destinationDataStore = DataStoreFinder.getDataStore(destinationDataStoreConfig);
		this.ds2dsConfiguration.setEcqlFilter("id_partner = " + partner + " AND id_bersaglio = " + targetType);

		/*
		 * Delete all features
		 */
		for(UpdaterFeature f : targetFeature.getFeatures()){

			String fn = f.getFeatureName();
			String pr = f.getFeatureParentRelation();

			Filter filter = CQL.toFilter(this.ds2dsConfiguration.getEcqlFilter());
			// Feature hasn't id_partner, join with the parent relation is needed to delete entry 
			if(pr != null){

				Connection connection = DriverManager.getConnection("jdbc:postgresql://"+destinationDataStoreConfig.get("host")+":"+destinationDataStoreConfig.get("port")+"/"+destinationDataStoreConfig.get("database"),destinationDataStoreConfig.get("user").toString(), destinationDataStoreConfig.get("passwd").toString());

				DatabaseMetaData metaData = connection.getMetaData();

				ResultSet foreignKeys = metaData.getImportedKeys(connection.getCatalog(), null, pr);

				boolean fkFound = false;
				String fkTableName = "";
				String fkColumnName = "";
				String pkTableName = "";
				String pkColumnName = "";

				//Retrieve information about FK
				while (foreignKeys.next()) {
					fkTableName = foreignKeys.getString("FKTABLE_NAME");
					fkColumnName = foreignKeys.getString("FKCOLUMN_NAME");
					pkTableName = foreignKeys.getString("PKTABLE_NAME");
					pkColumnName = foreignKeys.getString("PKCOLUMN_NAME");
					if(pkTableName.equals(fn) && fkTableName.equals(pr)){
						fkFound = true;
						break;

					}
				}
				connection.close();

				if(fkFound){

					//Retrieve IDs of primary feature to delete related to those extracted by EcqlFilter on related feature
					FilterFactory ff = CommonFactoryFinder.getFilterFactory(null);

					Query query = new Query(fkTableName,filter);
					FeatureReader<SimpleFeatureType, SimpleFeature> reader = destinationDataStore.getFeatureReader(query, Transaction.AUTO_COMMIT);
					Set<FeatureId> featureIds = new HashSet<FeatureId>();
					while (reader.hasNext()) {
						SimpleFeature feature = reader.next();
						String  fk = feature.getAttribute(fkColumnName).toString();
						featureIds.add(ff.featureId(pkTableName + "." + fk));
					}
					reader.close();
					Id fids = ff.id(featureIds);

					//Delete features by IDs
					SimpleFeatureStore store = (SimpleFeatureStore) destinationDataStore.getFeatureSource(pkTableName);
					store.setTransaction(Transaction.AUTO_COMMIT);					
					store.removeFeatures(fids);
				}
			}

			//Delete parent records
			else{
				SimpleFeatureStore store = (SimpleFeatureStore) destinationDataStore.getFeatureSource(fn);
				store.setTransaction(Transaction.AUTO_COMMIT);					
				store.removeFeatures(filter);
			}
		}

		/*
		 * Populate all features (first the ones constraint relation)
		 */
		for(UpdaterFeature f : targetFeature.getFeatures()){
			String fn = f.getFeatureName();
			String pr = f.getFeatureParentRelation();
			if(pr != null){
				runDs2Ds(fn);
			}			
		}

		for(UpdaterFeature f : targetFeature.getFeatures()){
			String fn = f.getFeatureName();
			String pr = f.getFeatureParentRelation();
			if(pr == null){					
				runDs2Ds(fn);
			}			
		}

	}

	public void executeArc(UpdaterFeatures arcFeature) throws Exception {

		Map<String, Serializable> destinationDataStoreConfig = this.ds2dsConfiguration.getOutputFeature().getDataStore();
		DataStore destinationDataStore = DataStoreFinder.getDataStore(destinationDataStoreConfig);

		/*
		 * Delete all features
		 */
		for(UpdaterFeature f : arcFeature.getFeatures()){

			String fn = f.getFeatureName();
			String pr = f.getFeatureParentRelation();
			this.ds2dsConfiguration.setEcqlFilter("fk_partner = " + partner);
			//Delete all using cascade on FK
			if(pr == null){
				Transaction transaction = new DefaultTransaction("removeFeature");
				SimpleFeatureStore store = (SimpleFeatureStore) destinationDataStore.getFeatureSource(fn);
				Filter filter = CQL.toFilter(this.ds2dsConfiguration.getEcqlFilter());
				store.setTransaction(transaction);					
				try {
					store.removeFeatures(filter);
					transaction.commit();
				} catch (Exception eek) {
					LOGGER.error(eek.getMessage(),eek);
					transaction.rollback();
				}finally{
					transaction.close();
				}
			}
		}

		/*
		 * Populate all features (first the ones without constraint relation)
		 */
		for(UpdaterFeature f : arcFeature.getFeatures()){
			String fn = f.getFeatureName();
			String pr = f.getFeatureParentRelation();
			if(pr == null){
				runDs2Ds(fn);
			}
		}
		for(UpdaterFeature f : arcFeature.getFeatures()){
			String fn = f.getFeatureName();
			String pr = f.getFeatureParentRelation();
			if(pr != null){
				runDs2Ds(fn);
			}
		}

	}


	private void runDs2Ds(String featureName) throws Exception{
		LOGGER.debug("Execute Ds2Ds on " + featureName + " feature");
		this.ds2dsConfiguration.getSourceFeature().setTypeName(featureName);
		//Force purge to false
		this.ds2dsConfiguration.setPurgeData(false);
		this.ds2dsConfiguration.setFailIgnored(true);
		Ds2dsAction action = new Ds2dsAction(this.ds2dsConfiguration);		
		action.setTempDir(new File(System.getProperty("java.io.tmpdir")));
		action.setFailIgnored(true);
		action.addListener(listener);
		action.execute(getEvents());
	}

	public void setDs2DsConfiguration(ProductionUpdaterConfiguration productionUpdaterConfiguration) {
		this.ds2dsConfiguration = productionUpdaterConfiguration;		
	}

}
