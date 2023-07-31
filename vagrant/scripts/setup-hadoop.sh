#!/bin/bash  

source "/vagrant/scripts/common.sh"

# Descargar e instalar Hadoop
function downloadAndExtract {  
    #echo "Downloading and extracting Hadoop..."
    echo "Descargando e instalando Hadoop..."  
    wget -P ~/temp https://dlcdn.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz  
    tar -xzvf ~/temp/hadoop-3.3.5.tar.gz -C ~/temp --remove-files  
    sudo mv ~/temp/hadoop-3.3.5.tar.gz /usr/local/hadoop
    sudo chown -R hadoop:hadoop /usr/local/hadoop   
} 

# Configurar variables de entorno de Hadoop
function setupEnvVars {
    #echo "Setting up Hadoop environment variables..."
    echo "Configurando variables de entorno de Hadoop..."
    $HADOOP_RES_DIR/hadoop.sh
}

# Incluir versión de Java en Hadoop
function setupJavaHome {  
    #echo "Setting up Java home in Hadoop configuration files..."
    echo "Configurando Java home en archivos de configuración de Hadoop..."  
    sed -i '/export JAVA_HOME=${JAVA_HOME}/a \  
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' $HADOOP_HOME/etc/hadoop/hadoop-env.sh  
}

# Crear directorios para NameNode y DataNode y cambiar titularidad
function setupHDFSDirs {  
    #echo "Setting up HDFS directories..." 
    echo "Configurando directorios HDFS..."
    sudo mkdir -p /home/hadoop/hdfs/{namenode,datanode}  
    sudo chown -R hadoop:hadoop /home/hadoop/hdfs  
} 

# Modificar hdfs-site.xml
function setupHdfsSite {  
    #echo "Setting up hdfs-site.xml..."
    echo "Configurando hdfs-site.xml..."  
    hdfs_properties=$(cat /vagrant/resources/hadoop/hdfs-site.xml)
    sed -i "/<\/configuration>/i\\
    $hdfs_properties
    " $HADOOP_HOME/etc/hadoop/hdfs-site.xml
}

# Formatear sistema de archivos de Hadoop
function formatHDFS {  
    #echo "Formatting HDFS..." 
    echo "Formateando HDFS..." 
    sudo -u hadoop $HADOOP_HOME/bin/hdfs namenode -format  
}

# Modificar mapred-site.xml
function setupMapredSite {
    #echo "Setting up mapred-site.xml..."
    echo "Configurando mapred-site.xml..."  
    mapred_properties=$(cat /vagrant/resources/hadoop/mapred-site.xml)
    sed -i "/<\/configuration>/i\\
    $mapred_properties
    " $HADOOP_HOME/etc/hadoop/mapred-site.xml
}

# Modificar yarn-site.xml
function setupYarnSite {
    #echo "Setting up yarn-site.xml..."
    echo "Configurando yarn-site.xml..."  
    echo "Configurando hdfs-site.xml..."  
    yarn_properties=$(cat /vagrant/resources/hadoop/yarn-site.xml)
    sed -i "/<\/configuration>/i\\
    $yarn_properties
    " $HADOOP_HOME/etc/hadoop/yarn-site.xml
}  

# Call the functions  
downloadAndExtract
setupEnvVars
setupJavaHome
setupHDFSDirs
setupHdfsSite
formatHDFS
setupMapredSite
setupYarnSite  
