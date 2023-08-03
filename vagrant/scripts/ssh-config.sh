#!/bin/bash  
  
function installPackages {  
    #echo "Installing necessary packages..."
	echo "Instalando los paquetes necesarios..."   
    sudo apt-get install -y openssh-server openssh-client  
}

function createSSHKey {
	#echo "generating ssh key"
    echo "Generando clave ssh"
    cp -f /vagrant/resources/misc/ssh-key.sh /etc/profile.d/ssh-key.sh
	. /etc/profile.d/ssh-key.sh
} 

# Call the functions
installPackages
createSSHKey