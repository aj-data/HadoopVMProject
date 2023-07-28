#!/bin/bash  
  
HADOOP_HOME=/usr/local/hadoop  
HIVE_HOME=/usr/local/hive  
  
function setupHiveEnv {  
    echo "Setting up Hive environment variables..."  
    echo 'export HADOOP_HOME=/usr/local/hadoop' >> $HIVE_HOME/conf/hive-env.sh  
}  
  
function installMySQL {  
    echo "Installing MySQL..."  
    sudo apt-get install -y mysql-server  
}  
  
function setupMetastoreDB {  
    echo "Setting up Hive metastore database..."  
    sudo mysql -u root -p -e "CREATE DATABASE metastore_db; CREATE USER 'hiveuser'@'localhost' IDENTIFIED BY 'hivepassword'; GRANT ALL PRIVILEGES ON metastore_db.* TO 'hiveuser'@'localhost'; FLUSH PRIVILEGES;"  
}  
  
function setupHiveSite {  
    echo "Setting up hive-site.xml..."  
    cp $HIVE_HOME/conf/hive-default.xml.template $HIVE_HOME/conf/hive-site.xml  
    # Add your properties to hive-site.xml here  
}  
  
function installMySQLJavaConnector {  
    echo "Installing MySQL Java Connector..."  
    wget -P ~/temp https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-8.0.32.tar.gz  
    tar -xzvf ~/temp/mysql-connector-java-8.0.32.tar.gz -C ~/temp --remove-files  
    cp ~/temp/mysql-connector-java-8.0.32/mysql-connector-java-8.0.32.jar $HIVE_HOME/lib/  
}  
  
function initMetastore {  
    echo "Initializing Hive metastore..."  
    schematool -initSchema -dbType mysql  
}  
  
function setupHiveLocation {  
    echo "Setting up default Hive location..."  
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
