#!/bin/sh

function setupJavaHome {
    #echo "Setting up Java home in Hadoop configuration files..."
    echo "Configurando Java home en archivos de configuración de Hadoop..." 
    while read -r line; do
        if ! echo $PATH | grep -q "$line"; then
            echo "$line" >> ~/.bashrc
            source ~/.bashrc
            echo "Added $line to PATH"
        else
            echo "$line is already in PATH"
        fi
    done < /vagrant/resources/hadoop/java.sh
}

setupJavaHome