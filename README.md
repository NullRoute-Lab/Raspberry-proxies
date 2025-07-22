# Raspberry Pi Proxy Suite

This project includes a collection of popular proxy services optimized for running on a **Raspberry Pi 4**. All services are managed via Docker for easy setup and maintenance.

## 🚀 Available Services

This suite includes the following services:

  * **Tor (`multitor`)**: Runs multiple instances of the Tor network to enhance privacy and throughput.
  * **Psiphon**: A powerful tool for bypassing internet filtering and censorship.
  * **Warp (`Warp-hiddify`)**: Uses the Cloudflare Warp network to create a secure and fast connection.
  * **Hiddify-TVC**: A service for creating and managing various proxy protocols.

## 📋 Prerequisites

  * A Raspberry Pi device (preferably model 4)
  * Raspberry Pi OS or another Linux distribution
  * `Docker` and `Docker Compose` must be installed

## ⚙️ Installation and Setup

Setting up this suite is very simple and can be done in just a few steps.

**1. Clone the Repository**

First, clone the project onto your Raspberry Pi:

```bash
git clone <URL_YOUR_REPOSITORY>
cd raspberry-proxies
```

**2. Make the Management Script Executable**

Grant execute permissions to the `manage.sh` script. This only needs to be done once.

```bash
chmod +x manage.sh
```

**3. Run All Services**

With a single command, you can build and run all services in the background:

```bash
./manage.sh up
```

Congratulations\! All your services are now active and ready to use.

## 🛠️ Management Commands

The `manage.sh` script makes it easy to manage all the services.

| Command | Description |
| :--- | :--- |
| `./manage.sh up` | Builds and runs all services in the background. |
| `./manage.sh down` | Stops and removes all service containers. |
| `./manage.sh build` | Rebuilds the Docker images (useful when you change a `Dockerfile`). |

## Ports

| Service | Port(s) |
| :--- | :--- |
| **multitor** | `16378`, `16379`, `16380` |
| **psiphon** | `1080`, `8080` |
| **warp** | `8086` |
| **hiddify-tvc** | `2334`, `2335`, `6756`, `6450` |
