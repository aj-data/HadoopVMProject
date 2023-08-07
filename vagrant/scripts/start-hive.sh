#!/bin/bash

source "/vagrant/scripts/common.sh"

function startHive {  
    #echo "Starting Hive..."
    echo "Inicializando Hive"  
    hive --service metastore &  
    hive --service hiveserver2 &  
} 

# Llamando las funciones
startHive