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
    mkdir temp
    mkdir /tmp/temp
    sudo -u vagrant mkdir /home/vagrant/temp
    sudo chown vagrant:vagrant /home/vagrant/temp
}

function createScriptsFolder {
    echo "Creando carpeta de scripts..."
    mkdir /usr/local/scripts
}

function setupHosts {
	#echo "modifying /etc/hosts file"
    echo "Modificando archivo /etc/hosts..."
        echo "127.0.0.1 node1" >> /etc/nhosts
	echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" >> /etc/nhosts
	echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/nhosts
	cp /etc/nhosts /etc/hosts
	rm -f /etc/nhosts
}

function installJava {
    echo "Instalando Java..."
    if [ -f "/vagrant/resources/misc/OpenJDK8U-jdk_x64_linux.tar.gz" ]; then
        sudo tar -xzf /vagrant/resources/misc/OpenJDK8U-jdk_x64_linux.tar.gz -C /usr/lib/jvm/
        sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_221/bin/java 1
        sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_221/bin/javac 1
    else
        apt-get update 
        apt-get install -y openjdk-8-jdk-headless
    fi
}

function setupSwap {
    # setup swapspace daemon to allow more memory usage.
    echo "Instalando swapspace..."
    apt-get install -y swapspace
}

function setupUtilities {
    # so the `locate` command works
    echo "Instalando utilidades..."
    apt-get install -y mlocate
    updatedb
    apt-get install -y ant
    apt-get install -y unzip
    apt-get install -y python-minimal
    apt-get install -y curl apt-utils
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
setupHosts
installJava
#setupSwap
#setupUtilities
copyInitScript