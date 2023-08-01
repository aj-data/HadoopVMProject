#!/bin/bash  

source "/vagrant/scripts/common.sh"

function downloadAndExtract {  
    #echo "Downloading and extracting Hive..."
    echo "Descargando e instalando Hive..."  
    wget -P /tmp/temp https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz  
    tar -xzvf /tmp/temp/apache-hive-3.1.3-bin.tar.gz -C /tmp/temp --remove-files  
    sudo mv /tmp/temp/apache-hive-3.1.3-bin /usr/local/hive  
}  
  
# Configurar variables de entorno de Hive
function setupEnvironmentVars {
    #echo "Setting up Hadoop environment variables..."
    echo "Configurando variables de entorno de Hive..."
    cp -f $HIVE_RES_DIR/hive.sh /etc/profile.d/hive.sh
	. /etc/profile.d/hive.sh
}
  
function fixWarnings {  
    #echo "Fixing Hive warning..."
    echo "Corrigiendo advertencia de Hive..."  
    #sudo rm /usr/local/hive/lib/log4j-slf4j-impl-2.17.1.jar
    sed -i 's|<name>hive.server2.enable.doAs</name>|<name>hive.server2.enable.doAs</name>\n<value>false</value>|' $HIVE_HOME/conf/hive-site.xml 
}  
  
# Call the functions  
downloadAndExtract  
setupEnvironmentVars  
fixWarnings
