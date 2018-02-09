FROM jnonino/spark-base-docker-image
LABEL maintainer="Julian Nonino <noninojulian@outlook.com>"

# Expose:
#   - Application Web UI (4040)
#   - Master REST Port (6066)
#   - Master port (7077)
#   - Shuffle server (7337)
#   - Master Web UI (8080)
#   - Worker Web UI (8081)
#   - History Server (18080)
EXPOSE 4040 6066 7077 7337 8080 8081 18080

COPY start.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/start.sh"]