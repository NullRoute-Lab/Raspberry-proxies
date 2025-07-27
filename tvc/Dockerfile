FROM ophub/openwrt-armv8:latest

# Copy all project files from the host's /tvc directory into the image's /tvc directory
COPY . /tvc/

# Set the working directory to /tvc
WORKDIR /tvc

# Run the setup script to install the service
RUN chmod +x setup.sh && sync && ./setup.sh

# Expose the necessary ports
EXPOSE 2334 6756

# Set the final command to start the OpenWrt environment
CMD ["/sbin/init"]
