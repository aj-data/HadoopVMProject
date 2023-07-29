#!/bin/bash  
  
HADOOP_HOME=/home/hadoop/hadoop-3.3.0  

function startHadoop {  
    #echo "Starting Hadoop..."
    echo "Inicializando Hadoop..."  
    sudo -u hadoop $HADOOP_HOME/sbin/start-dfs.sh  
}

function startYarn {  
    #echo "Starting Yarn..."
    echo "Inicializando Yarn..."  
    sudo -u hadoop $HADOOP_HOME/sbin/start-yarn.sh  
}  

# Llamando las funciones
startHadoop
startYarn