CATALINA_BASE=/opt/tomcat_geoserver_destination_plus
GEOSERVER_DATA_DIR=/opt/gs_data_dir_destination_plus
GEOSERVER_URL="http://localhost:8089/geoserver"
IRIDE_URL="http://applogic.csi.it/pep_wsfad_policy/services/PolicyEnforcerBase"
SIIG_URL="http://destination.geo-solutions.it/MapStore/"
JAVA_OPTS="-server -XX:SoftRefLRUPolicyMSPerMB=36000 -Xms1024m -Xmx1024m -XX:MaxPermSize=256m -XX:PermSize=256m -XX:+UseConcMarkSweepGC -XX:NewSize=48m -Dorg.geotools.shapefile.datetime=true -DGEOSERVER_DATA_DIR=$GEOSERVER_DATA_DIR -Dorg.geotools.filter.function.simplify=true -DGEOMETRY_COLLECT_MAX_COORDINATES=50000 -DIRIDE_URL=$IRIDE_URL -DSIIG_URL=$SIIG_URL"

export LD_LIBRARY_PATH="/usr/local/lib/"
export GDAL_DATA="/usr/local/share/gdal/"
export PATH="/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/lib/jvm/java-6-sun-1.6.0.24"
