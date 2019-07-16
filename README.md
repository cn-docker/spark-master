# Spark Master Docker Image [![Docker hub](https://img.shields.io/docker/pulls/jnonino/spark-master.svg)](https://hub.docker.com/r/jnonino/spark-master/)

https://hub.docker.com/r/jnonino/spark-master-docker-image/

## Run a Spark Master Standalone

To run a Spark Master server, run this command:  

    docker run --name spark-master jnonino/spark-master-docker-image

## Run Spark Master Cluster for High Availability

You can use Zookeeper to provide High Availability in Spark Master. For example:

    docker run --name spark-master-1 jnonino/spark-master-docker-image <ZOOKEEPER_ENDPOINT>
    docker run --name spark-master-2 jnonino/spark-master-docker-image <ZOOKEEPER_ENDPOINT>
    docker run --name spark-master-3 jnonino/spark-master-docker-image <ZOOKEEPER_ENDPOINT>

Spark Master nodes will use Zookeeper to connect to each other and elect a leader. Leader election will be performed again if the current leader node goes down.

The Spark Master UI can be accessed using:  

    <SPARK_MASTER_CONTAINER_IP>:8080
