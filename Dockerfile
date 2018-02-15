FROM ubuntu:xenial
LABEL maintainer="Julian Nonino <noninojulian@outlook.com>"

# Install required tools, tar, curl and Java JRE
RUN apt-get update -y && \
    apt-get install -y tar curl openjdk-8-jre-headless net-tools iproute python3 python3-setuptools python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Spark
ENV SPARK_VERSION 2.2.1
ENV HADOOP_VERSION 2.7
RUN curl -O http://apache.dattatec.com/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    tar -xvf spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    rm -rf spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    mv spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION spark && \
    mv spark /opt && \
    cp /opt/spark/conf/log4j.properties.template /opt/spark/conf/log4j.properties
ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin:$SPARK_HOME/sbin:$SPARK_HOME/jars:$PATH
WORKDIR /opt/spark

# Spark Master Port
ENV SPARK_MASTER_PORT 7077
EXPOSE 7077

# Spark Master Web UI Port
ENV SPARK_MASTER_WEBUI_PORT 8080
EXPOSE 8080

# Spark Master REST Port
EXPOSE 6066

# Expose:
#   - Application Web UI (4040)
#   - Shuffle server (7337)
#   - History Server (18080)
# EXPOSE 4040 7337  18080

COPY start.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/start.sh"]