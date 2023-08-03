#!/bin/bash  
  
function installPackages {  
    #echo "Installing necessary packages..."
	echo "Instalando los paquetes necesarios..."   
    sudo apt-get install -y openssh-server openssh-client  
}

function createSSHKey {
    echo "Creando par de claves ssh..."
    ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    #chmod 0600 ~/.ssh/authorized_keys
    cp -f /vagrant/resources/ssh/config ~/.ssh
}

# Call the functions
installPackages
createSSHKey