/* Copyright (c) 2014 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package it.geosolutions.security.cache;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.geoserver.security.auth.AuthenticationCache;
import org.geoserver.security.auth.AuthenticationCacheEntry;
import org.geoserver.security.auth.AuthenticationCacheKey;
import org.geotools.util.logging.Logging;
import org.springframework.security.core.Authentication;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;

/**
 * Implementation of GeoServer AuthenticationCache
 * based on Guava Cache
 *
 */
public class GuavaAuthenticationCache implements AuthenticationCache
{

    public static final int DEFAULT_CLEANUP_TIME = DEFAULT_IDLE_TIME * 2;

    private int timeToIdleSeconds,timeToLiveSeconds;
    
    private final ScheduledExecutorService scheduler = 
            Executors.newScheduledThreadPool(1);
    
    private  Cache<AuthenticationCacheKey, AuthenticationCacheEntry> cache;
    
    static Logger LOGGER = Logging.getLogger("org.geoserver.security");
    
    private Runnable evictionTask = new Runnable() {
        @Override
        public void run() {
            if(LOGGER.isLoggable(Level.FINE)) {
                LOGGER.fine("AuthenticationCache Eviction task running");
                LOGGER.fine("Cache entries #: " + cache.size());
            }
            cache.cleanUp();
            if(LOGGER.isLoggable(Level.FINE)) {
                LOGGER.fine("AuthenticationCache Eviction task completed");
                LOGGER.fine("Cache entries #: " + cache.size());
            }
        }
    };

    public GuavaAuthenticationCache(int maxEntries) {
        this(maxEntries, DEFAULT_IDLE_TIME, DEFAULT_LIVE_TIME, DEFAULT_CLEANUP_TIME);
    }
    
    public GuavaAuthenticationCache(int maxEntries, int timeToIdleSeconds,
            int timeToLiveSeconds, int cleanUpSeconds) {
        this.timeToIdleSeconds = timeToIdleSeconds;
        this.timeToLiveSeconds = timeToLiveSeconds;
        
        cache = CacheBuilder.newBuilder()
                .maximumSize(maxEntries)
                .expireAfterAccess(timeToIdleSeconds, TimeUnit.SECONDS)
                .expireAfterWrite(timeToLiveSeconds, TimeUnit.SECONDS)
                //.concurrencyLevel(concurrencyLevel) optimizes internal
                // sizes for the given number of concurrent writing threads
                .build();
        if(LOGGER.isLoggable(Level.INFO)) {
            LOGGER.info("AuthenticationCache Initialized with " + maxEntries
                    + " Max Entries, " + timeToIdleSeconds + " seconds idle time and "
                    + timeToLiveSeconds + " seconds time to live");
        }
        
        scheduler.scheduleAtFixedRate(evictionTask, cleanUpSeconds,
                cleanUpSeconds, TimeUnit.SECONDS); 
        if(LOGGER.isLoggable(Level.INFO)) {
            LOGGER.info("AuthenticationCache Eviction Task created to run every " + cleanUpSeconds
                    + " seconds");
        }
    }
    
    @Override
    public void removeAll() {
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache removing all entries");
            LOGGER.fine("Cache entries #: " + cache.size());
        }
        cache.invalidateAll();
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache removed all entries");
            LOGGER.fine("Cache entries #: " + cache.size());
        }
    }

    @Override
    public void removeAll(String filterName) {
        if (filterName==null) return;
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache removing all entries for " + filterName);
            LOGGER.fine("Cache entries #: " + cache.size());
        }
        Set<AuthenticationCacheKey> toBeRemoved = new HashSet<AuthenticationCacheKey>();
        for (AuthenticationCacheKey key: cache.asMap().keySet()) {
            if(filterName.equals(key.getFilterName()))
                toBeRemoved.add(key);
        }

        cache.invalidateAll(toBeRemoved);
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache removed " + toBeRemoved.size() + " entries for " + filterName);
            LOGGER.fine("Cache entries #: " + cache.size());
        }
    }

    @Override
    public void remove(String filterName, String cacheKey) {
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache removing " + filterName + ", " + cacheKey + " entry");
            LOGGER.fine("Cache entries #: " + cache.size());
        }
        cache.invalidate(new AuthenticationCacheKey(filterName, cacheKey));
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache removed " + filterName + ", " + cacheKey + " entry");
            LOGGER.fine("Cache entries #: " + cache.size());
        }
    }

    @Override
    public Authentication get(String filterName, String cacheKey) {
        AuthenticationCacheEntry entry = cache.getIfPresent(new AuthenticationCacheKey(filterName, cacheKey));
        if (entry==null) {
            if(LOGGER.isLoggable(Level.FINE)) {
                LOGGER.fine("AuthenticationCache has no entry for " + filterName + ", " + cacheKey);
            }
            return null;
        }
        entry.setLastAccessed(System.currentTimeMillis());
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache found an entry for " + filterName + ", " + cacheKey);
        }
        return entry.getAuthentication();
    }

    @Override
    public void put(String filterName, String cacheKey, Authentication auth,
            Integer timeToIdleSeconds, Integer timeToLiveSeconds) {
        timeToIdleSeconds = timeToIdleSeconds != null ? timeToIdleSeconds : this.timeToIdleSeconds;;
        timeToLiveSeconds = timeToLiveSeconds != null ? timeToLiveSeconds : this.timeToLiveSeconds;
        // by entry timeIdle and timeToLive are currently not supported
        // global timeouts are always applied
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache adding new entry for " + filterName + ", " + cacheKey);
            LOGGER.fine("Cache entries #: " + cache.size());
        }
        cache.put(new AuthenticationCacheKey(filterName, cacheKey),
                new AuthenticationCacheEntry(auth, 
                        timeToIdleSeconds,
                        timeToLiveSeconds));
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache added new entry for " + filterName + ", " + cacheKey);
            LOGGER.fine("Cache entries #: " + cache.size());
        }
    }

    @Override
    public void put(String filterName, String cacheKey, Authentication auth) {
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache adding new entry for " + filterName + ", " + cacheKey);
            LOGGER.fine("Cache entries #: " + cache.size());
        }
        put(filterName,cacheKey,auth,timeToIdleSeconds,timeToLiveSeconds);
        if(LOGGER.isLoggable(Level.FINE)) {
            LOGGER.fine("AuthenticationCache added new entry for " + filterName + ", " + cacheKey);
            LOGGER.fine("Cache entries #: " + cache.size());
        }
    }
    
    public boolean isEmpty() {
        return cache.size() == 0;
    }
}
