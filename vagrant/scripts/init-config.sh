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
  
# Call the functions  
stopService  
removeService  
