package it.geosolutions.process.gs;

import it.geosolutions.jaiext.algebra.AlgebraDescriptor.Operator;

import java.io.File;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.util.Locale;
import java.util.Map;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.impl.CatalogImpl;
import org.geoserver.config.DefaultGeoServerLoader;
import org.geoserver.config.GeoServerDataDirectory;
import org.geoserver.platform.GeoServerExtensions;
import org.geoserver.platform.GeoServerResourceLoader;
import org.geoserver.wps.raster.algebra.AlgebricProcess;
import org.geotools.feature.SchemaException;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.referencing.CRS;
import org.geotools.util.NullProgressListener;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.MessageSourceResolvable;
import org.springframework.context.NoSuchMessageException;
import org.springframework.core.env.Environment;
import org.springframework.core.io.Resource;

import com.vividsolutions.jts.geom.Envelope;

public class AlgebricProcessTest {
    
    Catalog catalog;
    AlgebricProcess process;
    
    @Before
    public void setUp() throws IOException, SchemaException {
            String dataDirPath = System.getProperty("GS_TEST_DATA_DIR");
            
            if(dataDirPath != null) {
                    catalog = new CatalogImpl();
                    
                    final GeoServerResourceLoader resourceLoader = new GeoServerResourceLoader(
                                    new File(dataDirPath));
                    
                    final GeoServerDataDirectory dataDirectory = new GeoServerDataDirectory(resourceLoader);
                    DefaultGeoServerLoader loader = new DefaultGeoServerLoader(resourceLoader);
                    catalog = (Catalog)loader.postProcessBeforeInitialization(catalog, "catalog");
                    if(catalog != null) {
                            process = new AlgebricProcess(catalog);   
                            
                            
                            (new GeoServerExtensions()).setApplicationContext(new ApplicationContext() {

                                    @Override
                                    public Environment getEnvironment() {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public boolean containsBeanDefinition(String beanName) {
                                            // TODO Auto-generated method stub
                                            return false;
                                    }

                                    @Override
                                    public int getBeanDefinitionCount() {
                                            // TODO Auto-generated method stub
                                            return 0;
                                    }

                                    @Override
                                    public String[] getBeanDefinitionNames() {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public String[] getBeanNamesForType(Class<?> type) {
                                            if(type.isAssignableFrom(GeoServerResourceLoader.class))
                                                    return new String[] {"resourceLoader"};
                                            return new String[] {};
                                    }

                                    @Override
                                    public String[] getBeanNamesForType(Class<?> type,
                                                    boolean includeNonSingletons, boolean allowEagerInit) {
                                            return getBeanNamesForType(type);
                                    }

                                    @Override
                                    public <T> Map<String, T> getBeansOfType(Class<T> type)
                                                    throws BeansException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public <T> Map<String, T> getBeansOfType(Class<T> type,
                                                    boolean includeNonSingletons, boolean allowEagerInit)
                                                    throws BeansException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public Map<String, Object> getBeansWithAnnotation(
                                                    Class<? extends Annotation> annotationType)
                                                    throws BeansException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public <A extends Annotation> A findAnnotationOnBean(
                                                    String beanName, Class<A> annotationType) {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public Object getBean(String name) throws BeansException {
                                            if(name.equals("resourceLoader"))
                                                    return resourceLoader;
                                            return null;
                                    }

                                    @Override
                                    public <T> T getBean(String name, Class<T> requiredType)
                                                    throws BeansException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public <T> T getBean(Class<T> requiredType)
                                                    throws BeansException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public Object getBean(String name, Object... args)
                                                    throws BeansException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public boolean containsBean(String name) {
                                            // TODO Auto-generated method stub
                                            return false;
                                    }

                                    @Override
                                    public boolean isSingleton(String name)
                                                    throws NoSuchBeanDefinitionException {
                                            // TODO Auto-generated method stub
                                            return false;
                                    }

                                    @Override
                                    public boolean isPrototype(String name)
                                                    throws NoSuchBeanDefinitionException {
                                            // TODO Auto-generated method stub
                                            return false;
                                    }

                                    @Override
                                    public boolean isTypeMatch(String name, Class<?> targetType)
                                                    throws NoSuchBeanDefinitionException {
                                            // TODO Auto-generated method stub
                                            return false;
                                    }

                                    @Override
                                    public Class<?> getType(String name)
                                                    throws NoSuchBeanDefinitionException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public String[] getAliases(String name) {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public BeanFactory getParentBeanFactory() {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public boolean containsLocalBean(String name) {
                                            // TODO Auto-generated method stub
                                            return false;
                                    }

                                    @Override
                                    public String getMessage(String code, Object[] args,
                                                    String defaultMessage, Locale locale) {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public String getMessage(String code, Object[] args,
                                                    Locale locale) throws NoSuchMessageException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public String getMessage(
                                                    MessageSourceResolvable resolvable, Locale locale)
                                                    throws NoSuchMessageException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public void publishEvent(ApplicationEvent event) {
                                            // TODO Auto-generated method stub
                                            
                                    }

                                    @Override
                                    public Resource[] getResources(String locationPattern)
                                                    throws IOException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public Resource getResource(String location) {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public ClassLoader getClassLoader() {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public String getId() {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public String getDisplayName() {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public long getStartupDate() {
                                            // TODO Auto-generated method stub
                                            return 0;
                                    }

                                    @Override
                                    public ApplicationContext getParent() {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }

                                    @Override
                                    public AutowireCapableBeanFactory getAutowireCapableBeanFactory()
                                                    throws IllegalStateException {
                                            // TODO Auto-generated method stub
                                            return null;
                                    }
                                    
                            });
                    }
                    
                    
            }
    }
    
    @Test
    public void testAlgebric() throws Exception {
        if(process != null) {
            ReferencedEnvelope env = new ReferencedEnvelope(new Envelope(314502.04349926114, 765826.5590057758, 4879335.999999467, 5219819.357880223), CRS.decode("EPSG:32632", true));
            process.execute(null, "aree_agricole_mosaic,aree_protette_mosaic", Operator.SUM, 0.0, 0.0, 0.0, env, 100, 100, new NullProgressListener());
        }
    }
}
