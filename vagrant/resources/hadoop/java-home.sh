#!/bin/bash

function addJavaHome {
    echo "Añadiendo  JAVA_HOME al archivo hadoop-env.sh..."
    if ! grep -q "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" "$HADOOP_HOME/etc/hadoop/hadoop-env.sh"; then
        echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> "$HADOOP_HOME/etc/hadoop/hadoop-env.sh"
        echo "Línea agregada al archivo $HADOOP_HOME/etc/hadoop/hadoop-env.sh"
    else
        echo "La línea ya existe en el archivo $HADOOP_HOME/etc/hadoop/hadoop-env.sh"
    fi
}

addJavaHome