#!/bin/bash  

source "/vagrant/scripts/common.sh"

function downloadAndExtract {  
    #echo "Downloading and extracting Hive..."
    echo "Descargando e instalando Hive..."  
    wget -P /tmp/temp https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz  
    tar -xzvf /tmp/temp/apache-hive-3.1.3-bin.tar.gz -C /tmp/temp --remove-files  
    sudo mv /tmp/temp/apache-hive-3.1.3-bin /usr/local/hive  
} 

function removeWarning {
    echo "Eliminando advertencia de Hive..."
    sudo rm $HIVE_HOME/lib/log4j-slf4j-impl-2.17.1.jar
}

# Configurar variables de entorno de Hive
function setupEnvironmentVars {
    #echo "Setting up Hadoop environment variables..."
    echo "Configurando variables de entorno de Hive..."
    cp -f $HIVE_RES_DIR/hive.sh /etc/profile.d/hive.sh
	. /etc/profile.d/hive.sh
    echo "Agregando variables al PATH..."
    /vagrant/resources/hive/hive.sh
}

function startMetastore {
    echo "Iniciando metastore..."
    sudo -u vagrant /vagrant/scripts/start-hive.sh
}

# Call the functions  
downloadAndExtract 
removeWarning
setupEnvironmentVars
