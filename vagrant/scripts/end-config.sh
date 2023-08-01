#!/bin/bash  
  
# Copia el archivo desde /resources/misc a la carpeta raíz  
cp /vagrant/resources/misc/init-script.sh /root/  
  
# Otorga permisos de ejecución al archivo  
chmod +x /root/init-script.sh  
