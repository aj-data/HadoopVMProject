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
        wget -P /tmp/temp https://dlcdn.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz  
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
    sudo cp -f $HADOOP_RES_DIR/hdp_envs.sh /usr/local/scripts
    chmod +x /usr/local/scripts/hdp_envs.sh
	/usr/local/scripts/hdp_envs.sh
} 

# Incluir versión de Java en Hadoop
function setupJavaHome {  
    #echo "Setting up Java home in Hadoop configuration files..."
    echo "Configurando variables de entorno de Hadoop..."
    cp -f $HADOOP_RES_DIR/java-home.sh /usr/local/scripts
    chmod +x /usr/local/scripts/java-home.sh
	/usr/local/scripts/java-home.sh
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
    hdfs_xml=$(cat /vagrant/resources/hadoop/hdfs-site.xml)
    infile=$HADOOP_HOME/etc/hadoop/hdfs-site.xml
    outfile=/tmp/hdfs-site.xml

    copy=1
    while read line; do
    if [[ $line == *"<configuration>"* ]]; then
        echo "$line"
        echo "$hdfs_xml" 
        copy=0
    elif [[ $line == *"</configuration>"* ]]; then
        echo "$line"
        copy=1
    elif [[ $copy -eq 1 ]]; then
        echo "$line"
    fi  
    done < "$infile" > "$outfile"

    mv $outfile $infile
}

# Formatear sistema de archivos de Hadoop
function formatHDFS {  
    #echo "Formatting HDFS..." 
    echo "Formateando HDFS..." 
    sudo -u vagrant $HADOOP_HOME/bin/hdfs namenode -format  
}

# Modificar mapred-site.xml
function setupMapredSite {
    #echo "Setting up mapred-site.xml..."
    echo "Configurando mapred-site.xml..."
    mapred_xml=$(cat /vagrant/resources/hadoop/mapred-site.xml)
    infile=$HADOOP_HOME/etc/hadoop/mapred-site.xml
    outfile=/tmp/mapred-site.xml

    copy=1
    while read line; do
    if [[ $line == *"<configuration>"* ]]; then
        echo "$line"
        echo "$mapred_xml" 
        copy=0
    elif [[ $line == *"</configuration>"* ]]; then
        echo "$line"
        copy=1
    elif [[ $copy -eq 1 ]]; then
        echo "$line"
    fi  
    done < "$infile" > "$outfile"

    mv $outfile $infile
}

# Modificar yarn-site.xml
function setupYarnSite {
    #echo "Setting up yarn-site.xml..."
    echo "Configurando yarn-site.xml..."  
    yarn_xml=$(cat /vagrant/resources/hadoop/yarn-site.xml)
    infile=$HADOOP_HOME/etc/hadoop/yarn-site.xml
    outfile=/tmp/yarn-site.xml

    copy=1
    while read line; do
    if [[ $line == *"<configuration>"* ]]; then
        echo "$line"
        echo "$yarn_xml" 
        copy=0
    elif [[ $line == *"</configuration>"* ]]; then
        echo "$line"
        copy=1
    elif [[ $copy -eq 1 ]]; then
        echo "$line"
    fi  
    done < "$infile" > "$outfile"

    mv $outfile $infile
}

# Call the functions
downloadAndExtract
setupEnvironmentVars
setupJavaHome
setupHDFSDirs
setupHdfsSite
formatHDFS
setupMapredSite
setupYarnSite