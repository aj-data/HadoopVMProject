#!/bin/bash  
  
function startHBase {  
    #echo "Starting HBase..."
    echo "Incializando HBase...  
    $HBASE_HOME/bin/start-hbase.sh  
}

startHBase