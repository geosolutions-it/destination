/*
 *    GeoTools - The Open Source Java GIS Toolkit
 *    http://geotools.org
 *
 *    (C) 2002-2011, Open Source Geospatial Foundation (OSGeo)
 *
 *    This library is free software; you can redistribute it and/or
 *    modify it under the terms of the GNU Lesser General Public
 *    License as published by the Free Software Foundation;
 *    version 2.1 of the License.
 *
 *    This library is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *    Lesser General Public License for more details.
 */
package it.geosolutions.geobatch.destination.common;

import it.geosolutions.geobatch.destination.common.utils.DbUtils;
import it.geosolutions.geobatch.destination.common.utils.FeatureLoaderUtils;
import it.geosolutions.geobatch.destination.common.utils.SequenceManager;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.ingestion.TargetIngestionProcess;

import java.io.IOException;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.geotools.data.DataStore;
import org.geotools.data.FeatureStore;
import org.geotools.data.Query;
import org.geotools.data.Transaction;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.feature.FeatureCollection;
import org.geotools.feature.FeatureIterator;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.referencing.CRS;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.filter.Filter;
import org.opengis.filter.FilterFactory2;
import org.opengis.filter.expression.Function;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.expression.AccessException;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.PropertyAccessor;
import org.springframework.expression.TypedValue;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;

import com.thoughtworks.xstream.XStream;
import it.geosolutions.geobatch.flow.event.ProgressListener;

/**
 * Base object for the ingestion processes model.
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public abstract class InputObject {
	
	private static final XStream xstream = new XStream();
	
	public static Properties partners = new Properties();
	
	public static SpelExpressionParser expressionParser = new SpelExpressionParser();
	
	public static StandardEvaluationContext evaluationContext = new StandardEvaluationContext();
	
	private final static Logger LOGGER = LoggerFactory.getLogger(InputObject.class);
	
	private static CoordinateReferenceSystem defaultCrs = null;
	
	public static FilterFactory2 filterFactory = CommonFactoryFinder.getFilterFactory2();
	
	public static final int NO_TARGET = -1;
	
	private String SEQUENCE_SUFFIX = "_seq";
	
	private SequenceManager sequenceManager;
	
	//
	private String inputTypeName = "";
	private ProgressListener listenerForwarder=null;
	
	private boolean valid = false;
	
	FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = null;
	Query inputQuery = null;	
	FeatureIterator<SimpleFeature> inputIterator = null;
	int inputCount = 0;
	int readCount = 0;
	
	protected MetadataIngestionHandler metadataHandler;
	protected DataStore dataStore;
	
	/**
	 * Initializes an IngestionObject handler for the given input feature.
	 * 
	 * @param inputTypeName
	 */
	public InputObject(String inputTypeName,
			ProgressListener listener,
			MetadataIngestionHandler metadataHandler,
			DataStore dataStore) {
		super();
		this.inputTypeName = inputTypeName;
		this.listenerForwarder = listener;
		this.dataStore = dataStore;
		this.metadataHandler = metadataHandler;
		this.valid = this.parseTypeName(inputTypeName);
	}
	
	/**
	 * Parses type name to extract information about the to be ingested object.
	 * 
	 */
	protected abstract boolean parseTypeName(String typeName);

	static {	
		// load mappings from resources
		try {
			partners.load(InputObject.class.getResourceAsStream("/partners.properties"));
			
			evaluationContext.addPropertyAccessor(new PropertyAccessor() {
				
				@Override
				public void write(EvaluationContext ctx, Object target, String name,
						Object value) throws AccessException {					
					
				}
				
				@Override
				public TypedValue read(EvaluationContext ctx, Object target, String name)
						throws AccessException {
					if(target instanceof SimpleFeature) {
						SimpleFeature feature = (SimpleFeature) target;
						return new TypedValue(feature.getAttribute(name));
					}
					return null;
				}
				
				@Override
				public Class[] getSpecificTargetClasses() {					
					return new Class[] {SimpleFeature.class};
				}
				
				@Override
				public boolean canWrite(EvaluationContext ctx, Object target, String name)
						throws AccessException {					
					return false;
				}
				
				@Override
				public boolean canRead(EvaluationContext ctx, Object target, String name)
						throws AccessException {
					return target instanceof SimpleFeature;
				}
			});
		} catch (IOException e) {
			LOGGER.error("Unable to load configuration: "+e.getMessage(), e);
		}
	}
	
	protected void reset() {
		inputReader = null;
		inputQuery = null;	
		inputIterator = null;
		inputCount = 0;
		readCount = 0;
	}
	
	protected void resetInputCounter(){
	    inputCount = 0;
	}
	
	/**
	 * Checks for typeName validity.
	 * 
	 * @throws IOException if the typeName is not valid for this type
	 * of IngestionObject. 
	 * 
	 */
	protected boolean isValid() throws IOException {
		if(!valid) {
			throw new IOException("typeName has an incorrect name format: "+inputTypeName);
		}
		return true;
	}
	
	/**
	 * Checks and fills the given crs with default value if needed.
	 * 
	 * @param crs
	 * @return
	 */
	protected CoordinateReferenceSystem checkCrs(CoordinateReferenceSystem crs) {
		if(crs == null) {
			if(defaultCrs == null) {
				try {
					defaultCrs = CRS.decode("EPSG:32632");
				} catch (Exception e) {
					LOGGER.error("Error decoding EPSG: " + e.getMessage(), e);
				}
			}
			crs = defaultCrs;
		}
		return crs;
	}
	
	/**
	 * Connects to the given DataStore.
	 * 
	 * @param datastoreParams
	 * @return
	 * @throws IOException
	 
	protected JDBCDataStore connectToDataStore(
			Map<String, Serializable> datastoreParams) throws IOException {
		JDBCDataStore dataStore;
		dataStore = (JDBCDataStore)DataStoreFinder.getDataStore(datastoreParams);
		
		if(dataStore == null) {
			throw new IOException("Cannot connect to database for: "+inputTypeName);
		}
		//metadataHandler = new MetadataIngestionHandler(dataStore);
		return dataStore;
	}*/
	
	protected void dispose() {
		/*if(metadataHandler != null) {
			metadataHandler.dispose();
		}*/
	}
	
	/**
	 * Creates a new Ingestion process in the logging tables, on the given database
	 * connection.
	 * 
	 * @param dataStore
	 * @return
	 * @throws IOException 
	 */
	protected int createProcess() throws IOException {
		if(metadataHandler != null){
		return metadataHandler.createProcess();
	}
		return 0;
	}
	
	/**
	 * Get the input feature Ingestion process in the logging tables, on the given database
	 * connection.
	 * 
	 * @param dataStore
	 * @return
	 * @throws IOException 
	 */
	protected MetadataIngestionHandler.Process getProcessData() throws IOException {
		if(metadataHandler != null){
		return metadataHandler.getProcessData(inputTypeName);
	}
		return null;
	}
			
	protected Set<Number> getAggregationValues(String aggregateAttribute) throws IOException {		
		// get unique aggregation values
		Function unique = filterFactory.function("Collection_Unique",
				filterFactory.property(aggregateAttribute));
		FeatureCollection<SimpleFeatureType, SimpleFeature> features = inputReader
				.getFeatures(inputQuery);		

		return (Set<Number>) unique.evaluate(inputReader
				.getFeatures(new Query(inputTypeName, Filter.INCLUDE)));				
	}
	
    protected Set<BigDecimal> getAggregationBigValues(String aggregateAttribute) throws IOException {
        // get unique aggregation values
        Function unique = filterFactory.function("Collection_Unique",
                filterFactory.property(aggregateAttribute));
        FeatureCollection<SimpleFeatureType, SimpleFeature> features = inputReader
                .getFeatures(inputQuery);

        Set<BigDecimal> set = (Set<BigDecimal>)unique.evaluate(features);
        if(set == null){
            set = new HashSet<BigDecimal>(); 
        }
        return set;
    }
	
	
	/**
	 * Create a new entry in the trace log for the given input file / feature.
	 * The trace is bound to the given process.
	 * 
	 * @param dataStore
	 * @param processo
	 * @param bersaglio
	 * @param partner
	 * @param codicePartner
	 * @param date
	 * @param update
	 * @return
	 * @throws IOException
	 */
	protected int logFile(int processo, int bersaglio, int partner, String codicePartner, String date, boolean update) throws IOException {
		if(metadataHandler != null){
		return metadataHandler.logFile(processo, -1,
				partner, codicePartner, inputTypeName, date, false);
	}
		return 0;
	}
	
	/**
	 * Creates a FeatureSource for the input feature.
	 * 
	 * @param dataStore
	 * @param transaction
	 * @return
	 * @throws IOException
	 */
	protected FeatureStore<SimpleFeatureType, SimpleFeature> createInputReader(
			DataStore dataStore, Transaction transaction, String featureName)
			throws IOException {
		if(featureName == null) {
			featureName = inputTypeName;
		}
		inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, transaction,
				featureName);		
		inputQuery = new Query(featureName);
	        if(sequenceManager == null){
		    sequenceManager = new SequenceManager(dataStore, this.getClass().getSimpleName()+SEQUENCE_SUFFIX);
	        }
		return inputReader;
	}
	
	/**
	 * 
	 */
	protected void closeInputReader() {
		if(inputIterator != null) {
			inputIterator.close();
			inputIterator = null;
		}
		if(inputIterator != null) {
		    sequenceManager.disposeManager();
		    sequenceManager = null;
		}
	}
	
	protected String getInputGeometryName(DataStore dataStore) throws IOException {
		return getInputGeometryName(dataStore,inputTypeName);
	}
	
	protected String getInputGeometryName(DataStore dataStore, String featureTypeName) throws IOException {
		return dataStore.getSchema(featureTypeName).getGeometryDescriptor().getLocalName();
	}
	
	/**
	 * Creates a FeatureSource for the given typeName on the given DataStore.
	 * Optionally the source is bound to a transaction, if not null.
	 * 
	 * @param dataStore
	 * @param transaction
	 * @param typeName
	 * @return
	 * @throws IOException
	 */
	protected FeatureStore<SimpleFeatureType, SimpleFeature> createFeatureSource(
			JDBCDataStore dataStore, Transaction transaction, String typeName)
			throws IOException {
		return FeatureLoaderUtils.createFeatureSource(dataStore, transaction, typeName);
	}
	
	/**
	 * Remove old records from the given output objects, using a specific filter.
	 *  
	 * @param outputObjects
	 * @param removeFilter
	 * @throws IOException 
	 */
	protected void removeObjects(OutputObject[] objects, Filter filter) throws IOException {
		for(OutputObject obj : objects) {
			obj.getSource().removeFeatures(filter);			
		}
	}
	
	/**
	 * @param e
	 * @return
	 */
	protected String getError(Exception e) {		
		// TODO: human readble error
		Throwable t = e;
		while(t.getCause() != null) {
			t=t.getCause();
		}
		
		return t.getMessage().substring(0,Math.min(t.getMessage().length(), 1000));
	}
	
	/**
	 * Gets the total number of objects to import from the input feature.
	 * 
	 * @return
	 * @throws IOException 
	 */
	protected int getImportCount() throws IOException {
		return inputReader.getCount(inputQuery);
	}
	
	/**
	 * @return
	 * @throws IOException 
	 */
	protected Number getOutputId(OutputObject obj) throws IOException {
		// calculate max current value for geo output id, to append new data
		Function max = filterFactory.function("Collection_Max", filterFactory.property(obj.getId()));			
									
		Number id = (BigDecimal)max.evaluate( obj.getSource().getFeatures());
		if(id == null) {
			id = new BigDecimal(0);
		}
		return id;
	}
	
	protected Number getAverageOnInput(String attributeName, Number defaultValue) throws IOException {
		Function avg = filterFactory.function("Collection_Average", filterFactory.property(attributeName));
		
		Number value = (Double)avg.evaluate( inputReader.getFeatures(inputQuery));
		if(value == null) {
			value = defaultValue;
		}
		return value;
	}
	
	protected Number getSumOnInput(String attributeName, Number defaultValue) throws IOException {
		Function avg = filterFactory.function("Collection_Sum", filterFactory.property(attributeName));
		
		Number value = (Number)avg.evaluate( inputReader.getFeatures(inputQuery));
		if(value == null) {
			value = defaultValue;
		}
		return value;
	}
	
	/**
	 * Reads the next available input feature.
	 * 
	 * @return
	 * @throws IOException 
	 */
	protected SimpleFeature readInput() throws IOException {
		if(inputIterator == null) {
			inputIterator = inputReader.getFeatures(inputQuery).features();
		}
		if(inputIterator != null) {
			SimpleFeature result = readInput(inputIterator);
			if(result != null) {
				inputCount++;
			}
			return result;
		}
		return null;
	}
	
	/**
	 * Reads the next available input feature.
	 * 
	 * @return
	 * @throws IOException 
	 */
	protected SimpleFeature readInput(FeatureIterator<SimpleFeature> iterator) throws IOException {
		if(iterator == null) {
			return readInput();
		}
		if(iterator.hasNext()) {			
			return iterator.next();
		}
		return null;
	}
	
	/**
         * Returns the size of the features founded by the inputReader  
         * 
         * @return size the number of input features
         * @throws IOException 
         */
        protected int inputSize() throws IOException{ 
                if(inputQuery !=null && inputReader != null){
                    int count= inputReader.getCount(inputQuery);
                    if(count==-1){
                        return inputReader.getFeatures(inputQuery).size();
                    }
                    return count;            
                }            
                return 0;                                  
        }
	
	
	/**
	 * Returns the next value to use for the output feature id.
	 * 
	 * @param id
	 * @return
	 * @throws IOException 
	 */
	protected int nextId() throws IOException {
	    return (int)sequenceManager.retrieveValue();
		//return id.intValue() + (++readCount);
	}
	
		
	/**
	 * Returns the main id of the imported object.
	 * 
	 * @param inputFeature
	 * @param attributeMappings2
	 * @return
	 * @throws IOException 
	 * @throws NumberFormatException 
	 */
	protected int getIdTematico(SimpleFeature inputFeature, Map mappings) throws NumberFormatException, IOException {
		return (int)Double.parseDouble(getMapping(inputFeature, mappings, "id_tematico_shape").toString());
	}
	
	/**
	 * @param alternativeGeo
	 * @return
	 */
	protected String getAlternativeTypeName(String alternativeGeo) {		
		return inputTypeName.substring(0, inputTypeName.lastIndexOf('_'))+"_"+alternativeGeo;
	}
	
	/**
	 * Returns the mapped value of a given attribute for the current input feature.
	 * 
	 * @param inputFeature
	 * @param string
	 * @return
	 * @throws IOException 
	 */
	protected Object getMapping(SimpleFeature inputFeature, Map<String,String> mappings, String attribute) throws IOException {
		String expression = mappings.get(attribute);
		// TODO: introduce some form of expression evaluation
		if(expression.trim().startsWith("#{") && expression.trim().endsWith("}")) {
			expression = expression.trim().substring(2,expression.length()-1);
			org.springframework.expression.Expression spelExpression = expressionParser
					.parseExpression(expression);
			
			return spelExpression
					.getValue(evaluationContext, inputFeature);
		} else {
			return inputFeature.getAttribute(expression);
		}
	}
	
	/**
	 * @param outputObjects
	 */
	protected void setTransaction(OutputObject[] outputObjects, Transaction transaction) {
		for(OutputObject obj : outputObjects) {
		        if(obj != null){
		            obj.getWriter().setTransaction(transaction);
		        }
		}
	}
	
	/**
	 * Updates the import progress ( progress / total )
	 * for the listeners.
	 * 
	 * @param total
	 * @param message
	 */
	protected void updateImportProgress(int total, int errors, String message) {
		if (inputCount % 100 == 0) {
			listenerForwarder.setProgress((float) inputCount);
			listenerForwarder.setTask(message);
			if(LOGGER.isInfoEnabled()) {
				LOGGER.info(message + ": "+(inputCount - errors) + "/" + total);
			}
		}
	}
	
	/**
	 * Updates the import progress ( progress / total )
	 * for the listeners.
	 * 
	 * @param total
	 * @param message
	 */
	protected void importFinished(int total, int errors, String message) {		
        listenerForwarder.setProgress((float)total);
        listenerForwarder.setTask(message);
		if(LOGGER.isInfoEnabled()) {
			LOGGER.info(message + ": "+(inputCount - errors)+ "/" + total);
			if(errors > 0) {
				LOGGER.info("Skipped: " + errors);
			}
		}		
	}
	
	
	       /**
         * Updates the import progress ( progress / total )
         * for the listeners.
         * 
         * @param total
         * @param loopCounter
         * @param message
         */
        protected void importFinishedModified(int total,int loopCounter, int errors, String message) {          
        listenerForwarder.setProgress((float)total);
        listenerForwarder.setTask(message);
                if(LOGGER.isInfoEnabled()) {
                        LOGGER.info(message + ": "+(loopCounter - errors)+ "/" + total);
                        if(errors > 0) {
                                LOGGER.info("Skipped: " + errors);
                        }
                }               
        }
	
	/**
	 * 
	 * @param filter
	 */
	protected void setInputFilter(Filter filter) {
		if(inputQuery != null) {
			if(inputIterator != null) {
				inputIterator.close();
				inputIterator = null;
			}
			inputQuery.setFilter(filter);			
		}
	}
	
	/**
	 * Drops the input feature.
	 * 
	 * @param datastoreParams
	 * @throws IOException
	 */
	protected void dropInputFeature(Map<String, Serializable> datastoreParams) throws IOException {
		listenerForwarder.setTask("Dropping table "+inputTypeName);
		if(LOGGER.isInfoEnabled()) {
			LOGGER.info("Dropping table "+inputTypeName);
		}
		
		try {
			DbUtils.dropFeatureType(datastoreParams, inputTypeName);
			listenerForwarder.setTask("Table dropped");
			if(LOGGER.isInfoEnabled()) {
				LOGGER.info("Table dropped");
			}
		} catch (SQLException e) {
			LOGGER.error("Error dropping table "+inputTypeName+": "+e.getMessage());
		}
	}
	
	/**
	 * Drops the input feature.
	 * 
	 * @param datastoreParams
	 * @throws IOException
	 */
	protected void dropInputFeature(DataStore dataStore) throws IOException {
		listenerForwarder.setTask("Dropping table "+inputTypeName);
		if(LOGGER.isInfoEnabled()) {
			LOGGER.info("Dropping table "+inputTypeName);
		}
		
		try {
			DbUtils.dropFeatureType(dataStore, inputTypeName);
			listenerForwarder.setTask("Table dropped");
			if(LOGGER.isInfoEnabled()) {
				LOGGER.info("Table dropped");
			}
		} catch (SQLException e) {
			LOGGER.error("Error dropping table "+inputTypeName+": "+e.getMessage());
		}
	}
	
	public static Object readResourceFromXML(String resourceName) {
		return xstream.fromXML(TargetIngestionProcess.class.getResourceAsStream(resourceName));
	}
	
//	private createSequenceForInputType(){
//	    this.inputTypeName
//	}
}
