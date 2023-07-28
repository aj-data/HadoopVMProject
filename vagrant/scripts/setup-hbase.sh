#!/bin/bash  
  
function downloadAndExtract {  
    echo "Downloading and extracting HBase..."  
    wget -P ~/temp https://dlcdn.apache.org/hbase/2.5.5/hbase-2.5.5-bin.tar.gz  
    tar -xzvf ~/temp/hbase-2.5.5-bin.tar.gz -C ~/temp --remove-files  
    sudo mv ~/temp/hbase-2.5.5 /usr/local/hbase  
}  
  
function setupHBaseEnv {  
    echo "Setting up HBase environment variables..."  
    echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /usr/local/hbase/conf/hbase-env.sh  
    echo 'export HBASE_REGIONSERVERS=/usr/local/hbase/conf/regionservers' >> /usr/local/hbase/conf/hbase-env.sh  
    echo 'export HBASE_MANAGES_ZK=true' >> /usr/local/hbase/conf/hbase-env.sh  
}  
  
function setupBashrc {  
    echo "Setting up .bashrc..."  
    echo 'export HBASE_HOME=/usr/local/hbase' >> ~/.bashrc  
    echo 'export PATH=$PATH:$HBASE_HOME/bin' >> ~/.bashrc  
    source ~/.bashrc  
}  
  
function createHBaseDir {  
    echo "Creating HBase directory in HDFS..."  
    hdfs dfs -mkdir /hbase  
}  
  
function setupHBaseSite {  
    echo "Setting up hbase-site.xml..."  
    # Add your properties to hbase-site.xml here  
}  
  
function startHBase {  
    echo "Starting HBase..."  
    $HBASE_HOME/bin/start-hbase.sh  
}  
  
# Call the functions  
downloadAndExtract  
setupHBaseEnv  
setupBashrc  
createHBaseDir  
setupHBaseSite  
