#!/bin/bash  

source "/vagrant/scripts/common.sh"
HBASE_HOME=/usr/local/hbase

function downloadAndExtract {  
    #echo "Downloading and extracting HBase..."
    echo "Descargando y extrayendo HBase..."  
    wget -P /tmp/temp https://dlcdn.apache.org/hbase/2.5.5/hbase-2.5.5-bin.tar.gz  
    tar -xzvf /tmp/temp/hbase-2.5.5-bin.tar.gz -C /tmp/temp --remove-files  
    sudo mv /tmp/temp/hbase-2.5.5 /usr/local/hbase  
}  
  
function setupHBaseEnv {  
    #echo "Setting up HBase environment variables..."
    echo "Configurando las variables de entorno de HBase..."  
    echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /usr/local/hbase/conf/hbase-env.sh  
    echo 'export HBASE_REGIONSERVERS=/usr/local/hbase/conf/regionservers' >> /usr/local/hbase/conf/hbase-env.sh  
    echo 'export HBASE_MANAGES_ZK=true' >> /usr/local/hbase/conf/hbase-env.sh  
}

# Configurar variables de entorno de HBase
function setupEnvironmentVars {
    #echo "Setting up HBase environment variables..."
    echo "Configurando variables de entorno de HBase..."
	cp -f $HBASE_RES_DIR/hbase.sh /etc/profile.d/hbase.sh
	. /etc/profile.d/hbase.sh
    echo "Agregando variables al PATH..."
    /vagrant/resources/hbase/hbase-envs.sh
}
  
function createHBaseDir {  
    #echo "Creating HBase directory in HDFS..."
    echo "Creando el directorio HBase en HDFS..."  
    sudo -u vagrant hdfs dfs -mkdir /hbase  
}  

function setupHBaseSite {  
    echo "Configurando hbase-site.xml..."  
    /vagrant/resources/hbase/hbase_props.sh
}

function startHBase {  
    #echo "Starting HBase..."
    echo "Iniciando HBase..."  
    $HBASE_HOME/bin/start-hbase.sh  
}  

# Call the functions  
downloadAndExtract  
setupHBaseEnv  
setupEnvironmentVars  
createHBaseDir  
setupHBaseSite  
