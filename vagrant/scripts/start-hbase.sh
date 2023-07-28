#!/bin/bash  
  
function startHBase {  
    echo "Starting HBase..."  
    $HBASE_HOME/bin/start-hbase.sh  
}

startHBase