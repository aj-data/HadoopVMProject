# HadoopVMProject

This repository contains a Vagrant configuration for setting up a Hadoop cluster with Hive, Spark, and HBase. The configuration is designed to run on a single machine using VirtualBox and Vagrant.

The repository contains several scripts that are used to provision the virtual machines with the necessary software and configuration. These scripts include:

- init-config.sh: This script sets up the environment variables required for the other scripts to function properly.
- ssh-config.sh: This script sets up passwordless SSH between the virtual machines.
- setup-hadoop.sh: This script installs and configures Hadoop on the virtual machines.
- setup-hive.sh: This script installs and configures Hive on the virtual machines.
- setup-metastore.sh: This script initializes the schema for the Hive metastore using the MySQL database.
- setup-spark.sh: This script installs and configures Spark on the virtual machines.
- setup-hbase.sh: This script installs and configures HBase on the virtual machines.
- setup-jupyter.sh: This script installs and configures Jupyter Notebook on the virtual machines.
- end-config.sh: This script sets up the environment variables required for the virtual machines to function properly.
- kickoff.sh: This script starts the Hadoop services on the virtual machines.
- start_hdp_hv_mtst.sh: This script starts the Hadoop, Hive, and Metastore services on the virtual machines.

The Vagrantfile contains the configuration for the virtual machines, including the network settings and the provisioning scripts to run.

To use the repository, you must have VirtualBox and Vagrant installed on your machine. Once you have installed these dependencies, you can clone the repository and run the vagrant up command to start the virtual machines. The provisioning scripts will automatically install and configure the necessary software.
