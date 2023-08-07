#!/bin/bash

source "/vagrant/scripts/common.sh"

function createUser {  
    #echo "Creating 'hadoop' user..."
	echo "Creando el usuario 'hadoop'..."  
    sudo useradd -m -s /bin/bash hadoop  
    echo "hadoop:${HADOOP_USER_PASSWORD}" | sudo chpasswd  
    sudo usermod -aG sudo hadoop  
}

# Call the functions 
createUser