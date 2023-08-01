#!/bin/bash  

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
  
function setupBashrc {  
    #echo "Setting up .bashrc..."
    echo "Configurando .bashrc..."  
    echo 'export HBASE_HOME=/usr/local/hbase' >> ~/.bashrc  
    echo 'export PATH=$PATH:$HBASE_HOME/bin' >> ~/.bashrc  
    source ~/.bashrc  
}  
  
function createHBaseDir {  
    #echo "Creating HBase directory in HDFS..."
    echo "Creando el directorio HBase en HDFS..."  
    hdfs dfs -mkdir /hbase  
}  
  
function setupHBaseSite {  
    #echo "Setting up hbase-site.xml..."
    echo "Configurando hbase-site.xml..."  
    properties=(  
    "hbase.rootdir hdfs://localhost:9000/hbase"  
    "hbase.cluster.distributed true"  
    "hbase.zookeeper.quorum localhost"  
    "dfs.replication 1"  
    "hbase.zookeeper.property.clientPort 2181"  
    "hbase.zookeeper.property.dataDir /usr/local/hbase/zookeeper"  
    "hbase.tmp.dir ./tmp"  
    "hbase.unsafe.stream.capability.enforce false"  
    "hbase.wal.provider filesystem"  
    )  
    
    for i in "${properties[@]}"; do  
        name=$(echo $i | cut -d' ' -f1)  
        value=$(echo $i | cut -d' ' -f2)  
        if grep -q "<name>$name</name>" $HBASE_HOME/conf/hbase-site.xml; then  
            sed -i "/<name>$name<\/name>/!b;n;c<value>$value</value>" $HBASE_HOME/conf/hbase-site.xml  
        else  
            sed -i "/<\/configuration>/i <property>\n<name>$name</name>\n<value>$value</value>\n</property>" $HBASE_HOME/conf/hbase-site.xml  
        fi  
    done   
}  
  
function startHBase {  
    #echo "Starting HBase..."
    echo "Iniciando HBase..."  
    $HBASE_HOME/bin/start-hbase.sh  
}  
  
# Call the functions  
downloadAndExtract  
setupHBaseEnv  
setupBashrc  
createHBaseDir  
setupHBaseSite  
