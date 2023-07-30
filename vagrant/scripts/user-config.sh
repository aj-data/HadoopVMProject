#!/bin/bash  
  
function createUser {  
    #echo "Creating 'hadoop' user..."
	echo "Creando el usuario 'hadoop'..."  
    sudo useradd -m -s /bin/bash hadoop  
    echo "hadoop:${HADOOP_USER_PASSWORD}" | sudo chpasswd  
    sudo usermod -aG sudo hadoop  
}  
  
# function setupSSH {  
#     #echo "Setting up SSH for 'hadoop' user..." 
# 	echo "Configurando SSH para el usuario 'hadoop'..." 
#     sudo -u hadoop bash << EOF  
#     ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa -q  
#     cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys  
#     chmod 0600 ~/.ssh/authorized_keys  
# EOF  
# }

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
  
# Call the functions 
createUser  
installPackages
createSSHKey