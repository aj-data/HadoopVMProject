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
    sudo mv /tmp/temp/hadoop-3.3.5 /usr/local/vagrant
    sudo chown -R vagrant:vagrant /usr/local/vagrant   
}

# Configurar variables de entorno de Hadoop
#function setupEnvVars {
#    #echo "Setting up Hadoop environment variables..."
#    echo "Configurando variables de entorno de Hadoop..."
#    cp -f $HADOOP_RES_DIR/hadoop.sh /etc/profile.d/hadoop.sh
#	. /etc/profile.d/hadoop.sh
#}

# Configurar variables de entorno de Hadoop
function setupEnvVars {
    #echo "Setting up Hadoop environment variables..."
    echo "Configurando variables de entorno de Hadoop..."
    while read -r line; do
        if ! echo $PATH | grep -q "$line"; then
            echo "$line" >> ~/.bashrc
            source ~/.bashrc
            echo "Added $line to PATH"
        else
            echo "$line is already in PATH"
        fi
    done < /vagrant/resources/hadoop/hadoop.sh
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

# Switch to the hadoop user  
# su hadoop -c "$(declare -f downloadAndExtract setupEnvVars setupJavaHome setupHDFSDirs setupHdfsSite formatHDFS setupMapredSite setupYarnSite); downloadAndExtract; setupEnvVars; setupJavaHome; setupHDFSDirs; setupHdfsSite; formatHDFS; setupMapredSite; setupYarnSite"

# Call the functions
downloadAndExtract
setupEnvVars
setupJavaHome
setupHDFSDirs
setupHdfsSite
formatHDFS
setupMapredSite
setupYarnSite