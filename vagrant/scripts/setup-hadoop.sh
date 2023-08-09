#!/bin/bash  

source "/vagrant/scripts/common.sh"
HADOOP_HOME=/usr/local/hadoop

# Descargar e instalar Hadoop
function downloadAndExtract {  
    #echo "Downloading and extracting Hadoop..."
    echo "Descargando e instalando Hadoop..."  
    if [[ -e /vagrant/resources/hadoop/hadoop-3.3.5.tar.gz ]]; then
        tar -xzvf /vagrant/resources/hadoop/hadoop-3.3.5.tar.gz -C /tmp/temp --remove-files  
    else
        wget -P /tmp/temp https://archive.apache.org/dist/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz
        tar -xzvf /tmp/temp/hadoop-3.3.5.tar.gz -C /tmp/temp --remove-files  
    fi
    # Verifica si /usr/local/hadoop es un archivo no directorio y lo elimina si es así  
    if [[ -e /usr/local/hadoop && ! -d /usr/local/hadoop ]]; then  
        sudo rm /usr/local/hadoop
    fi 
    sudo mv /tmp/temp/hadoop-3.3.5 /usr/local/hadoop
    sudo chown -R vagrant:vagrant /usr/local/hadoop 
}

# Configurar variables de entorno de Hadoop
function setupEnvironmentVars {
    #echo "Setting up Hadoop environment variables..."
    echo "Configurando variables de entorno de Hadoop..."
	cp -f $HADOOP_RES_DIR/hadoop.sh /etc/profile.d/hadoop.sh
	. /etc/profile.d/hadoop.sh
    echo "Agregando variables al PATH..."
    /vagrant/resources/hadoop/hdp-envs.sh
}

# Incluir versión de Java en Hadoop
function setupJavaHome {  
    #echo "Setting up Java home in Hadoop configuration files..."
    echo "Configurando variables de entorno de Java de Hadoop..."
    cp -f $HADOOP_RES_DIR/java-home.sh /usr/local/scripts
    chmod +x /usr/local/scripts/java-home.sh
	/usr/local/scripts/java-home.sh
}

# Modificar CORE-site.xml
function setupCoreSite {  
    #echo "Setting up core-site.xml..."
    echo "Configurando core-site.xml..."
    sudo cp -f $HADOOP_RES_DIR/core-site.xml  $HADOOP_HOME/etc/hadoop/core-site.xml
}

# Crear directorios para NameNode y DataNode y cambiar titularidad
function setupHDFSDirs {  
    #echo "Setting up HDFS directories..." 
    echo "Configurando directorios HDFS..."
    sudo mkdir -p /home/vagrant/hdfs/{namenode,datanode}  
    sudo chown -R vagrant:vagrant /home/vagrant/hdfs  
} 

# Modificar hdfs-site.xml
function setupHdfsSite {  
    #echo "Setting up hdfs-site.xml..."
    echo "Configurando hdfs-site.xml..."
    sudo cp -f $HADOOP_RES_DIR/hdfs-site.xml  $HADOOP_HOME/etc/hadoop/hdfs-site.xml
}

# Formatear sistema de archivos de Hadoop
function formatHDFS {  
    #echo "Formatting HDFS..." 
    echo "Formateando HDFS..." 
    sudo -u vagrant $HADOOP_HOME/bin/hdfs namenode -format  
}

function startHDFS {
    #echo "Starting HDFS..."
    echo "Iniciando HDFS..."
    sudo -u vagrant $HADOOP_HOME/sbin/start-dfs.sh
}

# Modificar mapred-site.xml
function setupMapredSite {
    #echo "Setting up mapred-site.xml..."
    echo "Configurando mapred-site.xml..."
    sudo cp -f $HADOOP_RES_DIR/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
}

# Modificar yarn-site.xml
function setupYarnSite {
    #echo "Setting up yarn-site.xml..."
    echo "Configurando yarn-site.xml..."
    sudo cp -f $HADOOP_RES_DIR/yarn-site.xml  $HADOOP_HOME/etc/hadoop/yarn-site.xml
}

function startYarn {
    #echo "Starting YARN..."
    echo "Iniciando YARN..."
    sudo -u vagrant $HADOOP_HOME/sbin/start-yarn.sh
}

# Call the functions
downloadAndExtract
setupEnvironmentVars
setupJavaHome
setupCoreSite
setupHDFSDirs
setupHdfsSite
formatHDFS
startHDFS
setupMapredSite
setupYarnSite
startYarn