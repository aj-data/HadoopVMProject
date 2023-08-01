#!/bin/bash  

source "/vagrant/scripts/common.sh"

function downloadAndExtract {  
    #echo "Downloading and extracting Hive..."
    echo "Descargando e instalando Hive..."  
    wget -P /tmp/temp https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz  
    tar -xzvf /tmp/temp/apache-hive-3.1.3-bin.tar.gz -C /tmp/temp --remove-files  
    sudo mv /tmp/temp/apache-hive-3.1.3-bin /usr/local/hive  
}  
  
# Configurar variables de entorno de Hive
function setupEnvironmentVars {
    #echo "Setting up Hadoop environment variables..."
    echo "Configurando variables de entorno de Hive..."
    cp -f $HIVE_RES_DIR/hive.sh /etc/profile.d/hive.sh
	. /etc/profile.d/hive.sh
}
  
function fixWarnings {  
    #echo "Fixing Hive warning..."
    echo "Corrigiendo advertencia de Hive..."  
    #sudo rm /usr/local/hive/lib/log4j-slf4j-impl-2.17.1.jar
    HIVE_SITE_XML="/usr/local/hive/conf/hive-site.xml"
    PROP_NAME="hive.server2.enable.doAs"
    PROP_VALUE="false"
    if grep -q "$PROP_NAME" "$HIVE_SITE_XML"; then
    sed -i "s/\(<name>$PROP_NAME<\/name>\).*/<name>$PROP_NAME<\/name>\n    <value>$PROP_VALUE<\/value>/" "$HIVE_SITE_XML"
    else
    sed -i "/<configuration>/a \\\n    <property>\\\n        <name>$PROP_NAME</name>\\\n        <value>$PROP_VALUE</value>\\\n    </property>" "$HIVE_SITE_XML"
    fi
}  
  
# Call the functions  
downloadAndExtract  
setupEnvironmentVars  
fixWarnings
