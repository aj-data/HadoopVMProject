#!/bin/bash

function setupHBaseSite {
    echo "Agregando propiedades en hbase-site.xml..."
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
        value=$(echo $i | cut -d' ' -f2-)
        if grep -q "<name>$name</name>" /usr/local/hbase/conf/hbase-site.xml; then
            sed -i "/<name>$name<\/name>/!b;n;c<value>$value</value>" /usr/local/hbase/conf/hbase-site.xml
        else
            sed -i "/<\/configuration>/i <property>\n<name>$name</name>\n<value>$value</value>\n</property>" /usr/local/hbase/conf/hbase-site.xml  
        fi
    done
}

setupHBaseSite