/* Copyright (c) 2014 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package it.geosolutions.security.cache;

import junit.framework.TestCase;

import org.geoserver.security.auth.AuthenticationCache;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;

/**
 * Unit tests for Guava based AuthenticationCache
 * implementation.
 */
public class GuavaAuthenticationCacheTest 
    extends TestCase
{
    private static final int TIME_LIVE = 2;
    private static final int TIME_IDLE = 1;
    private static final int TIME_CLEANUP = 5;
    private static final int MAX_ENTRIES = 1000;
    private static final String SAMPLE_CACHE_KEY = "SAMPLE_CACHE_KEY";
    private static final String SAMPLE_FILTER = "SAMPLE_FILTER";
    private static final String OTHER_CACHE_KEY = "WRONG_CACHE_KEY";
    GuavaAuthenticationCache cache;

    @Override
    public void setUp() {
        cache = new GuavaAuthenticationCache(MAX_ENTRIES,TIME_IDLE,TIME_LIVE, TIME_CLEANUP);
                //new LRUAuthenticationCacheImpl(TIME_IDLE, TIME_LIVE, MAX_ENTRIES);
    }
    
    
    public void testWriteAndRead()
    {
        Authentication auth = putAuthenticationInCache();
        Authentication authenticationFromCache = cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY);
        assertNotNull(authenticationFromCache);
        assertEquals(auth, authenticationFromCache);
    }


    
    public void testExpireByAccess() throws InterruptedException {
        putAuthenticationInCache();
        Thread.sleep((TIME_IDLE) * 1000 / 2);
        assertNotNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
        Thread.sleep((TIME_IDLE + 1) * 1000);
        assertNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
    }
    
    public void testExpireByCreation() throws InterruptedException {
        putAuthenticationInCache();
        Thread.sleep((TIME_IDLE) * 1000 / 2);
        assertNotNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
        Thread.sleep((TIME_IDLE) * 1000 / 2);
        assertNotNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
        Thread.sleep((TIME_IDLE) * 1000 / 2);
        assertNotNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
        Thread.sleep((TIME_LIVE) * 1000);
        assertNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
    }
    
    public void testRemoveAuthentication() {
        putAuthenticationInCache();
        cache.remove(SAMPLE_FILTER, SAMPLE_CACHE_KEY);
        assertNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
    }
    
    public void testRemoveUnexistingAuthentication() {
        cache.remove(SAMPLE_FILTER, OTHER_CACHE_KEY);
        assertNull(cache.get(SAMPLE_FILTER, OTHER_CACHE_KEY));
    }
    
    public void testRemoveAll() {
        putAuthenticationInCache();
        putOtherAuthenticationInCache();
        assertNotNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
        assertNotNull(cache.get(SAMPLE_FILTER, OTHER_CACHE_KEY));
        cache.removeAll();
        assertNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
        assertNull(cache.get(SAMPLE_FILTER, OTHER_CACHE_KEY));
    }
    
    public void testRemoveAllByFilter() {
        putAuthenticationInCache();
        putOtherAuthenticationInCache();
        assertNotNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
        assertNotNull(cache.get(SAMPLE_FILTER, OTHER_CACHE_KEY));
        cache.removeAll(SAMPLE_FILTER);
        assertNull(cache.get(SAMPLE_FILTER, SAMPLE_CACHE_KEY));
        assertNull(cache.get(SAMPLE_FILTER, OTHER_CACHE_KEY));
    }
    
    public void testCleanUp() throws InterruptedException {
        putAuthenticationInCache();
        Thread.sleep((TIME_CLEANUP + 1) * 1000);
        assertTrue(cache.isEmpty());
    }
    
    private Authentication putAuthenticationInCache() {
        Authentication auth = new UsernamePasswordAuthenticationToken("user", "password");
        cache.put(SAMPLE_FILTER, SAMPLE_CACHE_KEY, auth);
        return auth;
    }
    
    private Authentication putOtherAuthenticationInCache() {
        Authentication auth = new UsernamePasswordAuthenticationToken("user", "password");
        cache.put(SAMPLE_FILTER, OTHER_CACHE_KEY, auth);
        return auth;
    }
    
}
