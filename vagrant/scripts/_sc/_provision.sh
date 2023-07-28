#!/bin/bash

# Actualizar repositorios e instalar paquetes requeridos
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk

# Instalar Hadoop, Hive y Spark
# (Asegúrate de tener los enlaces de descarga actualizados para las versiones requeridas)
wget -qO- https://dlcdn.apache.org/hadoop/common/hadoop-3.3.5/hadoop-3.3.5.tar.gz | tar xvz -C /opt
wget -qO- https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz | tar xvz -C /opt
wget -qO- https://dlcdn.apache.org/spark/spark-3.4.1/spark-3.4.1-bin-hadoop3.tgz | tar xvz -C /opt

# Configurar variables de entorno para Hadoop y Spark
echo 'export HADOOP_HOME=/opt/hadoop-3.3.5' >> ~/.bashrc
echo 'export HIVE_HOME=/opt/apache-hive-3.1.3-bin' >> ~/.bashrc
echo 'export SPARK_HOME=/opt/spark-3.4.1-bin-hadoop3.2' >> ~/.bashrc
echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HIVE_HOME/bin:$SPARK_HOME/bin' >> ~/.bashrc

# Cargar las variables de entorno
source ~/.bashrc
