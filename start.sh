#!/bin/bash

ZOOKEEPER_HOST=$1

###############################################################################################
# SPARK HOSTNAME
###############################################################################################
DEFAULT_IF="$(ip route list | awk '/^default/ {print $5}')"
IP_ADDRESS="$(ifconfig | grep -A 1 $DEFAULT_IF | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
#SPARK_MASTER_HOST="`hostname -f`"
SPARK_MASTER_HOST="$IP_ADDRESS"

###############################################################################################
# SPARK CONFIGURATION FILE
###############################################################################################
# Variables
SPARK_CONF_FILE="${SPARK_HOME}/conf/spark.conf"
echo "# Spark Configuration" >> $SPARK_CONF_FILE
# Deploy
if [[ -z "$ZOOKEEPER_HOST" ]]; then
    echo "No Zookeeper endpoint provided, running single master"
else
    echo "Setting up Zookeeper to have multiple masters"
    echo "# Deploy" >> $SPARK_CONF_FILE
    echo "spark.deploy.recoveryMode ZOOKEEPER" >> $SPARK_CONF_FILE
    echo "spark.deploy.zookeeper.url $ZOOKEEPER_HOST" >> $SPARK_CONF_FILE
fi

###############################################################################################
# RUN SPARK
###############################################################################################
CLASS="org.apache.spark.deploy.master.Master"
. "${SPARK_HOME}/sbin/spark-config.sh"
. "${SPARK_HOME}/bin/load-spark-env.sh"
$SPARK_HOME/bin/spark-class $CLASS --host $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT --properties-file ${SPARK_CONF_FILE}