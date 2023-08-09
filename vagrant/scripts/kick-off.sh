#!/bin/bash

function kickOff {
    # Fecha y hora para el nombre del log
    NOW=$(date +'%Y-%m-%d_%H-%M-%S') 

    # Ruta del log
    LOG="/tmp/start_services_$NOW.log"

    # Ejecutar comandos con confirmaciones
    echo "Iniciando Hadoop..." | tee -a $LOG
    start-all.sh >> $LOG 2>&1
    echo "Hadoop iniciado correctamente." | tee -a $LOG

    #echo "Iniciando metastore de Hive..." | tee -a $LOG
    #hive --service metastore >> $LOG 2>&1 &
    #echo "Metastore de Hive iniciado correctamente." | tee -a $LOG

    #echo "Iniciando HiveServer2..." | tee -a $LOG
    #hive --service hiveserver2 >> $LOG 2>&1 &
    #echo "HiveServer2 iniciado correctamente." | tee -a $LOG

    #echo "Iniciando HBase..." | tee -a $LOG
    #$HBASE_HOME/bin/start-hbase.sh >> $LOG 2>&1
    #echo "HBase iniciado correctamente." | tee -a $LOG

    #echo "Iniciando Jupyter..." | tee -a $LOG
    ##cd /home/vagrant/mientorno && source entornojupyter/bin/activate ; jupyter notebook >> $LOG 2>&1 &
    #jupyter notebook >> $LOG 2>&1 &
    #echo "Jupyter iniciado correctamente." | tee -a $LOG
    #echo "Servicios iniciados y registro en $LOG"

}

kickOff
