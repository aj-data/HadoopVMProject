#!/bin/bash  
  
#function stopService {  
#    #echo "Stopping unattended-upgrades service..."  
#    echo "Deteniendo el servicio unattended-upgrades..."
#    sudo systemctl stop unattended-upgrades  
#}  
  
#function removeService {  
#    #echo "Removing unattended-upgrades..."  
#    echo "Eliminando unattended-upgrades..."
#    sudo apt-get purge -y unattended-upgrades  
#}

function createTempFolder {
    echo "Creando carpeta temporal..."
    mkdir /tmp/temp
}

function createScriptsFolder {
    echo "Creando carpeta de scripts..."
    mkdir /usr/local/scripts
}

function installJava {
    echo "Instalando Java..."
    if [ -f "/vagrant/resources/misc/OpenJDK8U-jdk_x64_linux.tar.gz" ]; then
        sudo tar -xzf /vagrant/resources/misc/OpenJDK8U-jdk_x64_linux.tar.gz -C /usr/lib/jvm/
        sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_221/bin/java 1
        sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_221/bin/javac 1
    else
        sudo apt-get update 
        sudo apt-get install -y openjdk-8-jdk
    fi
}

# Copiar el archivo init-script.sh a la raíz del sistema operativo 
function copyInitScript {  
    #echo "Copying init-script.sh to root..."  
    echo "Copiando init-script.sh..." 
    sudo cp /vagrant/resources/misc/init-script.sh /
    sudo chmod +x /init-script.sh 
}

# Call the functions  
stopService 
removeService
createTempFolder
createScriptsFolder
installJava
copyInitScript