#!/bin/sh

function setupEnvVars {
    #echo "Setting up Hadoop environment variables..."
    echo "Configurando variables de entorno de Hadoop..."
    while read -r line; do
        if ! echo $PATH | grep -q "$line"; then
            echo "$line" >> ~/.bashrc
            source ~/.bashrc
            echo "Added $line to PATH"
        else
            echo "$line is already in PATH"
        fi
    done < /vagrant/resources/hadoop/hadoop.sh
}

setupEnvVars