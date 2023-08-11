#!/bin/bash  

source "/vagrant/scripts/common.sh"
HADOOP_HOME=/usr/local/hadoop

function startHDFS {
    #echo "Starting HDFS..."
    echo "Iniciando HDFS..."
    su - vagrant -c "start-dfs.sh"
}

function startYarn {
    #echo "Starting YARN..."
    echo "Iniciando YARN..."
    su - vagrant -c "start-yarn.sh"
}

function startMetastore {
    echo "Inicializando metastore de Hive"  
    sudo -u vagrant nohup /usr/local/hive/bin/hive --service metastore < /dev/null > /usr/local/hive/logs/hive_metastore_`date +"%Y%m%d%H%M%S"`.log 2>&1 &
    #su -u vagrant "$HIVE_HOME/bin/hive --service hiveserver2 &"
    sudo -u vagrant nohup /usr/local/hive/bin/hive --service hiveserver2 < /dev/null > /usr/local/hive/logs/hive_server2_`date +"%Y%m%d%H%M%S"`.log 2>&1 &
}

startHDFS
startYarn
startMetastore