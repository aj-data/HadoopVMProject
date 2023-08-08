#!/bin/bash  

source "/vagrant/scripts/common.sh"

HADOOP_HOME=/usr/local/hadoop
HIVE_HOME=/usr/local/hive

function setupHiveEnv {  
    #echo "Setting up Hive environment variables..."
    echo "Configurando variables de entorno de Hive..."
    cp $HIVE_HOME/conf/hive-env.sh.template $HIVE_HOME/conf/hive-env.sh
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
    echo "Configurando hive-site.xml..."  
    cp $HIVE_HOME/conf/hive-default.xml.template $HIVE_HOME/conf/hive-site.xml
    sudo /vagrant/resources/hive/hive_props.sh
}

function fixWarnings {
    echo "Corrigiendo advertencia de símbolo no válido..."
    sudo sed -i "s/r&#8;/ /g" "/usr/local/hive/conf/hive-site.xml" 
}

function installMySQLJavaConnector {
    #echo "Installing MySQL Java Connector..."
    echo "Instalando MySQL Java Connector..."
    #wget -P /tmp/temp https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-8.0.32.tar.gz  
    tar -xzvf /vagrant/resources/misc/mysql-connector-j-8.1.0.tar.gz -C /tmp/temp --remove-files  
    cp /tmp/temp/mysql-connector-j-8.1.0/mysql-connector-j-8.1.0.jar $HIVE_HOME/lib/  
}

function initMetastore {
    #echo "Initializing Hive metastore..."
    echo "Inicializando metastore de Hive..."
    sudo -u vagrant schematool -initSchema -dbType mysql
}

function setupHiveLocation {
    #echo "Setting up default Hive location..."
    echo "Configurando ubicación predeterminada de Hive..."
    sudo -u vagrant $HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/hive/warehouse
    sudo -u vagrant $HADOOP_HOME/bin/hdfs dfs -chmod g+w /tmp
    sudo -u vagrant $HADOOP_HOME/bin/hdfs dfs -chmod g+w /user/hive/warehouse
}

function startMetastore {
    echo "Inicializando Hive"  
    sudo -u vagrant hive --service metastore &  
    sudo -u vagrant hive --service hiveserver2 &  
}

# Call the functions
setupHiveEnv
installMySQL
setupMetastoreDB
setupHiveSite
fixWarnings
installMySQLJavaConnector
initMetastore
setupHiveLocation
startMetastore
