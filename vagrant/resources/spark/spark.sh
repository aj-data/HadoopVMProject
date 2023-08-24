export SPARK_HOME=/usr/local/spark
export PATH=$PATH:$SPARK_HOME/bin
export SPARK_LOCAL_IP=localhost
export PYSPARK_PYTHON=/usr/bin/python3
export PYTHONPATH=$(ZIPS=("$SPARK_HOME"/python/lib/*.zip); IFS=:; echo "${ZIPS[*]}"):$PYTHONPATH