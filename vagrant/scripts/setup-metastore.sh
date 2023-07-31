#!/bin/bash  
  
HADOOP_HOME=/usr/local/hadoop  
HIVE_HOME=/usr/local/hive  
  
function setupHiveEnv {  
    #echo "Setting up Hive environment variables..."
    echo "Configurando variables de entorno de Hive..."  
    echo 'export HADOOP_HOME=/usr/local/hadoop' >> $HIVE_HOME/conf/hive-env.sh  
}  
  
function installMySQL {  
    #echo "Installing MySQL..."
    echo "Instalando MySQL..."  
    sudo apt-get install -y mysql-server  
}  
  
function setupMetastoreDB {  
    #echo "Setting up Hive metastore database..." 
    echo "Configurando base de datos de metastore de Hive..." 
    sudo mysql -u root -p -e "CREATE DATABASE metastore_db; CREATE USER 'hiveuser'@'localhost' IDENTIFIED BY 'hivepassword'; GRANT ALL PRIVILEGES ON metastore_db.* TO 'hiveuser'@'localhost'; FLUSH PRIVILEGES;"  
}  
  
function setupHiveSite {  
    #echo "Setting up hive-site.xml..."
    echo "Configurando hive-site.xml..."  
    cp $HIVE_HOME/conf/hive-default.xml.template $HIVE_HOME/conf/hive-site.xml  
    # Add your properties to hive-site.xml here
    properties=(  
    "javax.jdo.option.ConnectionURL jdbc:mysql://localhost/metastore_db?createDatabaseIfNotExist=true"  
    "javax.jdo.option.ConnectionDriverName com.mysql.cj.jdbc.Driver"  
    "javax.jdo.option.ConnectionUserName hiveuser"  
    "javax.jdo.option.ConnectionPassword hivepassword"   
    )  
    
    for i in "${properties[@]}"; do  
        name=$(echo $i | cut -d' ' -f1)  
        value=$(echo $i | cut -d' ' -f2)  
        if grep -q "<name>$name</name>" $HIVE_HOME/conf/hive-site.xml; then  
            sed -i "/<name>$name<\/name>/!b;n;c<value>$value</value>" $HIVE_HOME/conf/hive-site.xml  
        else  
            sed -i "/<\/configuration>/i <property>\n<name>$name</name>\n<value>$value</value>\n</property>" $HIVE_HOME/conf/hive-site.xml  
        fi  
    done   
}   
  
function installMySQLJavaConnector {  
    #echo "Installing MySQL Java Connector..."
    echo "Instalando MySQL Java Connector..."  
    wget -P /tmp/temp https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-8.0.32.tar.gz  
    tar -xzvf /tmp/temp/mysql-connector-java-8.0.32.tar.gz -C /tmp/temp --remove-files  
    cp /tmp/temp/mysql-connector-java-8.0.32/mysql-connector-java-8.0.32.jar $HIVE_HOME/lib/  
}  
  
function initMetastore {  
    #echo "Initializing Hive metastore..."
    echo "Inicializando metastore de Hive..."  
    schematool -initSchema -dbType mysql  
}  
  
function setupHiveLocation {  
    #echo "Setting up default Hive location..."
    echo "Configurando ubicación predeterminada de Hive..."  
    hdfs dfs -mkdir -p /user/hive/warehouse  
    hdfs dfs -chmod g+w /tmp  
    hdfs dfs -chmod g+w /user/hive/warehouse  
}  
  
# Call the functions  
setupHiveEnv  
installMySQL  
setupMetastoreDB  
setupHiveSite  
installMySQLJavaConnector  
initMetastore  
setupHiveLocation
