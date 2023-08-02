#!/bin/bash  
  
function createSSHKey {
	#echo "generating ssh key"
    echo "Generando clave ssh"
	ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
	#cp -f $RES_SSH_CONFIG ~/.ssh
    chmod 0600 ~/.ssh/authorized_keys
}
  
function installPackages {  
    #echo "Installing necessary packages..."
	echo "Instalando los paquetes necesarios..."   
    sudo apt-get install -y openssh-server openssh-client  
}  
  
# Switch to the hadoop user  
su - hadoop << EOF  
$(declare -f createSSHKey)  
$(declare -f installPackages)  
createSSHKey
installPackages   
EOF 