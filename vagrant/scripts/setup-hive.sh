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
  
# Call the functions  
downloadAndExtract  
setupEnvironmentVars  
