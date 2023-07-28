#!/bin/bash  
  
function downloadAndExtract {  
    echo "Downloading and extracting Hive..."  
    wget -P ~/temp https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz  
    tar -xzvf ~/temp/apache-hive-3.1.3-bin.tar.gz -C ~/temp --remove-files  
    sudo mv ~/temp/apache-hive-3.1.3-bin /usr/local/hive  
}  
  
function setupEnvironmentVars {  
    echo "Setting up Hive environment variables..."  
    echo 'export HIVE_HOME=/usr/local/hive' >> ~/.bashrc  
    echo 'export PATH=$PATH:$HIVE_HOME/bin' >> ~/.bashrc  
    source ~/.bashrc  
}  
  
function fixWarning {  
    echo "Fixing Hive warning..."  
    sudo rm /usr/local/hive/lib/log4j-slf4j-impl-2.17.1.jar  
}  
  
  
# Call the functions  
downloadAndExtract  
setupEnvironmentVars  
fixWarning
