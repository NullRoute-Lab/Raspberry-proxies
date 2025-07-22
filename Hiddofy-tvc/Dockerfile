# 1. Use the official Alpine image from Docker Hub
FROM alpine:3.20

WORKDIR /hiddify

# Install required packages
RUN apk update && apk add --no-cache bash curl tar gzip libc6-compat

LABEL type="network"

# 2. Download and extract the ARM64 version of the Hiddify core
RUN curl -L -o hiddify-cli-linux-arm64.tar.gz https://github.com/NullRoute-Lab/hiddify-core/releases/download/v1.0.1/hiddify-cli-linux-arm64.tar.gz && \
    tar -xzf hiddify-cli-linux-arm64.tar.gz && \
    rm hiddify-cli-linux-arm64.tar.gz

# Copy the entrypoint script into the image
COPY entrypoint.sh .

# Make the script executable
RUN chmod +x entrypoint.sh

EXPOSE 2334 2335 6756 6450

# 3. Execute the new script as the entrypoint
ENTRYPOINT ["./entrypoint.sh"]

# CMD is now removed because its logic has been moved to the entrypoint script 