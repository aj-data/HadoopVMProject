#!/bin/sh

function setupJavaHome {
    #echo "Setting up Java home in Hadoop configuration files..."
    echo "Configurando Java home en archivos de configuración de Hadoop..." 
    while read -r line; do
        if ! echo $PATH | grep -q "$line"; then
            echo "$line" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
            echo "Added $line to hadoop-env.sh"
        else
            echo "$line is already in hadoop-env.sh"
        fi
    done < /vagrant/resources/hadoop/java.sh
}

setupJavaHome