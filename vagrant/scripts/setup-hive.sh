#!/bin/bash  
  
function downloadAndExtract {  
    #echo "Downloading and extracting Hive..."
    echo "Descargando e instalando Hive..."  
    wget -P ~/temp https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz  
    tar -xzvf ~/temp/apache-hive-3.1.3-bin.tar.gz -C ~/temp --remove-files  
    sudo mv ~/temp/apache-hive-3.1.3-bin /usr/local/hive  
}  
  
function setupEnvironmentVars {  
    #echo "Setting up Hive environment variables..."
    echo "Configurando variables de entorno de Hive..."  
    echo 'export HIVE_HOME=/usr/local/hive' >> ~/.bashrc  
    echo 'export PATH=$PATH:$HIVE_HOME/bin' >> ~/.bashrc  
    source ~/.bashrc  
}  
  
function fixWarnings {  
    #echo "Fixing Hive warning..."
    echo "Corrigiendo advertencia de Hive..."  
    sudo rm /usr/local/hive/lib/log4j-slf4j-impl-2.17.1.jar
    sed -i 's|<name>hive.server2.enable.doAs</name>|<name>hive.server2.enable.doAs</name>\n<value>false</value>|' $HIVE_HOME/conf/hive-site.xml 
}  
  
# Call the functions  
downloadAndExtract  
setupEnvironmentVars  
fixWarnings
