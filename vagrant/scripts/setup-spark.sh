#!/bin/bash  
  
function installDependencies {  
    #echo "Installing dependencies..."
    echo "Instalando dependencias..."  
    sudo apt install -y curl mlocate git scala  
}  
  
function downloadAndExtract {  
    #echo "Downloading and extracting Spark..."
    echo "Descargando y extrayendo Spark..."  
    wget -P ~/temp https://dlcdn.apache.org/spark/spark-3.4.1/spark-3.4.1-bin-hadoop3.tgz  
    tar -xzvf ~/temp/spark-3.4.1-bin-hadoop3.tgz -C ~/temp --remove-files  
    sudo mv ~/temp/spark-3.4.1-bin-hadoop3 /usr/local/spark  
}  
  
function setupEnvironmentVars {  
    #echo "Setting up Spark environment variables..."
    echo "Configurando variables de entorno de Spark..."  
    echo 'export SPARK_HOME=/usr/local/spark' >> ~/.bashrc  
    echo 'export PATH=$PATH:$SPARK_HOME/bin' >> ~/.bashrc  
    echo 'export SPARK_LOCAL_IP=localhost' >> ~/.bashrc  
    echo 'export PYSPARK_PYTHON=/usr/bin/python3' >> ~/.bashrc  
    echo 'export PYTHONPATH=$(ZIPS=("$SPARK_HOME"/python/lib/*.zip); IFS=:; echo "${ZIPS[*]}"):$PYTHONPATH' >> ~/.bashrc  
    source ~/.bashrc  
}  
  
# Call the functions  
installDependencies  
downloadAndExtract  
setupEnvironmentVars  
