#!/bin/bash  

source "/vagrant/scripts/common.sh"

# Descargar e instalar Hadoop
function downloadAndExtract {  
    #echo "Downloading and extracting Hadoop..."
    echo "Descargando e instalando Hadoop..."  
    wget -P /tmp/temp https://dlcdn.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz  
    tar -xzvf /tmp/temp/hadoop-3.3.5.tar.gz -C /tmp/temp --remove-files  
    # Verifica si /usr/local/hadoop es un archivo no directorio y lo elimina si es así  
    if [[ -e /usr/local/hadoop && ! -d /usr/local/hadoop ]]; then  
        sudo rm /usr/local/hadoop  
    fi 
    sudo mv /tmp/temp/hadoop-3.3.5 /usr/local/hadoop
    sudo chown -R hadoop:hadoop /usr/local/hadoop   
} 

# Configurar variables de entorno de Hadoop
function setupEnvVars {
    #echo "Setting up Hadoop environment variables..."
    echo "Configurando variables de entorno de Hadoop..."
    cp -f $HADOOP_RES_DIR/hadoop.sh /etc/profile.d/hadoop.sh
	. /etc/profile.d/hadoop.sh
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
    sudo -u hadoop $HADOOP_HOME/bin/hdfs namenode -format  
}

# Modificar mapred-site.xml
function setupMapredSite {
    #echo "Setting up mapred-site.xml..."
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
setupEnvVars
setupJavaHome
setupHDFSDirs
setupHdfsSite
formatHDFS
setupMapredSite
setupYarnSite  
