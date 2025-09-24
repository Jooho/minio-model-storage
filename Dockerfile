FROM quay.io/jooholee/model-minio:intrim AS runtime

# Create final image combining minio and user setup
FROM quay.io/minio/minio:RELEASE.2025-04-22T22-12-26Z

# Copy user and permission setup from runtime
COPY --from=runtime /etc/passwd /etc/passwd
COPY --from=runtime /etc/group /etc/group
COPY --from=runtime /data_tmp /data_tmp

# Create a data folder
RUN mkdir -p /data_tmp/example-models && \
    mkdir -p /data1 && \
    chmod -R g+rwX /data_tmp /data1 && \
    chmod -R 777 /data_tmp /data1

COPY ./hacks/start.sh /usr/bin/start.sh

RUN chmod +x /usr/bin/start.sh

EXPOSE 9000 9001

# Switch to the new user
USER 1000
ENTRYPOINT ["/usr/bin/start.sh"]
