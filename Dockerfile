FROM cnservices/spark-base
LABEL maintainer="Julian Nonino <noninojulian@gmail.com>"

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
