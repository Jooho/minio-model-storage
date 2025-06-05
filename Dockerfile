FROM registry.access.redhat.com/ubi9/ubi-minimal:latest as runtime

# Install necessary utilities and add user
RUN microdnf install -y shadow-utils && \
    mkdir /home/modelserving && \
    groupadd -g 1000 modelserving && \
    useradd -u 1000 -g 1000 modelserving && \
    curl -O https://dl.min.io/client/mc/release/linux-amd64/mc && \
    chmod +x mc && \
    mv mc /usr/bin/ && \
    microdnf remove -y shadow-utils && \
    microdnf clean all

# Create final image combining minio and user setup
FROM quay.io/minio/minio:RELEASE.2025-04-22T22-12-26Z

# Copy user and permission setup from runtime
COPY --from=runtime /etc/passwd /etc/passwd
COPY --from=runtime /etc/group /etc/group

# Create a data folder
RUN mkdir -p /data1/example-models

# To add models to Minio
COPY ./hacks/setup.sh /usr/bin/setup.sh

# Give execute permission to setup.sh 
RUN chmod +x /usr/bin/setup.sh

# Change ownership of necessary directories
RUN chown -R 1000:1000 /data1 && \
    chmod -R 775 /data1

EXPOSE 9000 9001

# Switch to the new user
USER 1000
