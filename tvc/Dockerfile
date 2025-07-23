FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    coreutils \
    curl \
    wget \
    jq \
    openvpn \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Copy the hiddify service files to the container
COPY . /root/hiddify

# Set the working directory
WORKDIR /root/hiddify

# Make the setup script executable and run it
RUN chmod +x setup.sh && \
    ./setup.sh

# Expose the necessary ports
EXPOSE 2334 6756

# Start the hiddify service
CMD ["/etc/init.d/hiddify", "start"]
