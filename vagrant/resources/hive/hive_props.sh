#!/bin/bash

function setupHiveSite {  
    echo "Configurando hive-site.xml..."
    properties=(  
    "javax.jdo.option.ConnectionURL jdbc:mysql://localhost/metastore_db?createDatabaseIfNotExist=true"    
    "javax.jdo.option.ConnectionDriverName com.mysql.cj.jdbc.Driver"    
    "javax.jdo.option.ConnectionUserName hiveuser"    
    "javax.jdo.option.ConnectionPassword hivepassword"    
    "hive.server2.enable.doAs false"  
    "system:java.io.tmpdir /tmp/hive/java"  
    "system:user.name ${user.name}"  
    )

    for i in "${properties[@]}"; do    
        name=$(echo $i | cut -d' ' -f1)    
        value=$(echo $i | cut -d' ' -f2-)    
        if grep -q "<name>$name</name>" /usr/local/hive/conf/hive-site.xml; then    
            sed -i "/<name>$name<\/name>/!b;n;c<value>$value</value>" /usr/local/hive/conf/hive-site.xml    
        else    
            sed -i "/<\/configuration>/i <property>\n<name>$name</name>\n<value>$value</value>\n</property>" /usr/local/hive/conf/hive-site.xml    
        fi    
    done     
}

setupHiveSite