#!/bin/bash  
  
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
    echo '   
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64  
    export HADOOP_HOME=/usr/local/hadoop  
    export HADOOP_INSTALL=$HADOOP_HOME  
    export HADOOP_MAPRED_HOME=$HADOOP_HOME  
    export HADOOP_COMMON_HOME=$HADOOP_HOME  
    export HADOOP_HDFS_HOME=$HADOOP_HOME  
    export HADOOP_YARN_HOME=$HADOOP_HOME  
    export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native  
    export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin  
    export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"  
    ' >> ~/.bashrc    
    source ~/.bashrc  
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
    sed -i '/<configuration>/a \  
    <property>\n<name>dfs.replication</name>\n<value>1</value>\n</property>\n\  
    <property>\n<name>dfs.name.dir</name>\n<value>file:///home/hadoop/hdfs/namenode</value>\n</property>\n\  
    <property>\n<name>dfs.data.dir</name>\n<value>file:///home/hadoop/hdfs/datanode</value>\n</property>' $HADOOP_HOME/etc/hadoop/hdfs-site.xml  
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
    echo '  
    <property>  
    <name>mapreduce.framework.name</name>  
    <value>yarn</value>  
    </property>  
    <property>  
    <name>mapreduce.application.classpath</name>  
    <value>$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*:$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*</value>  
    </property>  
    ' >> $HADOOP_HOME/etc/hadoop/mapred-site.xml  
}

# Modificar yarn-site.xml
function setupYarnSite {
    #echo "Setting up yarn-site.xml..."
    echo "Configurando yarn-site.xml..."  
    echo '  
    <property>  
    <name>yarn.nodemanager.aux-services</name>  
    <value>mapreduce_shuffle</value>  
    </property>  
    <property>  
    <name>yarn.nodemanager.env-whitelist</name>  
    <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_HOME,PATH,LANG,TZ,HADOOP_MAPRED_HOME</value>  
    </property>  
    ' >> $HADOOP_HOME/etc/hadoop/yarn-site.xml
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
