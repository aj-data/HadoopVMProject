#!/bin/bash  
  
function stopService {  
    #echo "Stopping unattended-upgrades service..."  
    echo "Deteniendo el servicio unattended-upgrades..."
    sudo systemctl stop unattended-upgrades  
}  
  
function removeService {  
    #echo "Removing unattended-upgrades..."  
    echo "Eliminando unattended-upgrades..."
    sudo apt-get purge -y unattended-upgrades  
}

function createTempFolder {
    echo "Creando carpeta temporal..."
    mkdir temp
}

function installJava {
    echo "Instalando Java..."
    sudo apt-get install -y openjdk-8-jdk
}
  
# Copiar el archivo init-script.sh a la raíz del sistema operativo 
function copyInitScript {  
    #echo "Copying init-script.sh to root..."  
    echo "Copiando init-script.sh..." 
    sudo cp /vagrant/resources/scripts/init-script.sh /  
    # Dar permisos de ejecución al archivo  
    sudo chmod +x /init-script.sh 
}

# Call the functions  
stopService 
removeService
createTempFolder
installJava
copyInitScript