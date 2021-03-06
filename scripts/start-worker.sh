#!/bin/bash

export SPARK_LOCAL_IP=`hostname`

bash ${SPARK_HOME}/sbin/spark-config.sh
bash ${SPARK_HOME}/bin/load-spark-env.sh

mkdir -p $SPARK_WORKER_LOG

ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker.out

spark-class org.apache.spark.deploy.worker.Worker \
    --webui-port $SPARK_WORKER_WEBUI_PORT  \
    ${SPARK_MASTER}
    >> $SPARK_WORKER_LOG/spark-master.out
