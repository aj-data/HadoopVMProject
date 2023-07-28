#!/bin/bash  
  
HADOOP_HOME=/home/hadoop/hadoop-3.3.0  
  
function copyConfigFiles {  
    echo "Copying configuration files..."  
    sudo cp /vagrant/resources/hbase/core-site.xml $HADOOP_HOME/etc/hadoop/  
    sudo cp /vagrant/resources/hbase/hdfs-site.xml $HADOOP_HOME/etc/hadoop/  
    sudo chown hadoop:hadoop $HADOOP_HOME/etc/hadoop/core-site.xml  
    sudo chown hadoop:hadoop $HADOOP_HOME/etc/hadoop/hdfs-site.xml  
}   
  
function setupHDFSDirs {  
    echo "Setting up HDFS directories..."  
    sudo mkdir -p /home/hadoop/hdfs/{namenode,datanode}  
    sudo chown -R hadoop:hadoop /home/hadoop/hdfs  
}   
  
function formatHDFS {  
    echo "Formatting HDFS..."  
    sudo -u hadoop $HADOOP_HOME/bin/hdfs namenode -format  
}  

function copyYarnConfigFiles {  
    echo "Copying Yarn configuration files..."  
    sudo cp /vagrant/resources/hadoop/mapred-site.xml $HADOOP_HOME/etc/hadoop/  
    sudo cp /vagrant/resources/hadoop/yarn-site.xml $HADOOP_HOME/etc/hadoop/  
    sudo chown hadoop:hadoop $HADOOP_HOME/etc/hadoop/mapred-site.xml  
    sudo chown hadoop:hadoop $HADOOP_HOME/etc/hadoop/yarn-site.xml  
}  

  
# Call the functions  
copyConfigFiles  
setupHDFSDirs
formatHDFS  
copyYarnConfigFiles 
