package it.geosolutions.graphhopper;

import java.io.File;
import java.io.FilenameFilter;
import java.util.Arrays;

public abstract class Utils {

    public static final String BLOCKED_EDGE_IDS_KEY = "_blocked_edges";
    
    /**
     * Check that all required files are present in the provided GraphHopper storage dir.
     *  
     * @param graphStorageDir the graph storage directory
     * @return true if all required files are found, false otherwise
     */
    public static boolean isGraphStorageDirEmpty(File graphStorageDir) {
        if (graphStorageDir == null) {
            return false;
        }
        
        final String[] GRAPH_STORAGE_FILES = new String[] { "edges", "nodes", "location_index" };
        Arrays.sort(GRAPH_STORAGE_FILES);
        
        boolean allFilesFound = false;
        if (graphStorageDir.exists() && graphStorageDir.isDirectory()) {
            File[] graphFiles = graphStorageDir.listFiles(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    return Arrays.binarySearch(GRAPH_STORAGE_FILES, name) >= 0;
                }
            });
            allFilesFound = graphFiles.length == GRAPH_STORAGE_FILES.length;
        }
        
        return !allFilesFound;
    }

}
