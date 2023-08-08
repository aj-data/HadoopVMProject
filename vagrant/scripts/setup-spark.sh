#!/bin/bash  

source "/vagrant/scripts/common.sh"

function installDependencies {  
    #echo "Installing dependencies..."
    echo "Instalando dependencias..."  
    sudo apt install -y curl mlocate git scala  
}  
  
function downloadAndExtract {  
    #echo "Downloading and extracting Spark..."
    echo "Descargando y extrayendo Spark..."  
    wget -P /tmp/temp https://archive.apache.org/dist/spark/spark-3.4.1/spark-3.4.1-bin-hadoop3.tgz
    tar -xzvf /tmp/temp/spark-3.4.1-bin-hadoop3.tgz -C /tmp/temp --remove-files  
    sudo mv /tmp/temp/spark-3.4.1-bin-hadoop3 /usr/local/spark
    #sudo chown -R vagrant:vagrant /usr/local/spark
}  

# Configurar variables de entorno de Spark
function setupEnvironmentVars {
    #echo "Setting up Spark environment variables..."
    echo "Configurando variables de entorno de Hadoop..."
	cp -f $SPARK_RES_DIR/spark.sh /etc/profile.d/spark.sh
	. /etc/profile.d/spark.sh
    echo "Agregando variables al PATH..."
    /vagrant/resources/spark/spark-envs.sh
}

# Call the functions  
installDependencies  
downloadAndExtract  
setupEnvironmentVars  
