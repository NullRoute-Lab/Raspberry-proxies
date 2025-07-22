

# Raspberry Pi Proxy Suite

This project includes a collection of popular proxy services optimized for running on a **Raspberry Pi 4**. All services are managed via Docker for easy setup and maintenance.

## 🚀 Available Services

This suite includes the following services:

* **Tor (`multitor`)**: Runs multiple instances of the Tor network to enhance privacy and throughput.
* **Psiphon**: A powerful tool for bypassing internet filtering and censorship.
* **Warp (`Warp-hiddify`)**: Uses the Cloudflare Warp network to create a secure and fast connection.
* **Hiddify-TVC**: A service for creating and managing various proxy protocols.

## ⚙️ Full Setup Guide (From a Fresh OS)

This guide covers all steps from a fresh Raspberry Pi OS Lite installation to running the services.

### Step 1: Update Your System

First, ensure your system's package list and installed packages are up to date.

```bash
sudo apt update && sudo apt upgrade -y
```

### Step 2: Install Git

You need Git to clone the repository onto your device.

```bash
sudo apt install git -y
```

### Step 3: Install Docker Engine

This project relies on Docker. The official convenience script is the easiest way to install it.

```bash
curl -sSL [https://get.docker.com](https://get.docker.com) | sh
```

After the installation, add your current user to the `docker` group. This allows you to run Docker commands without `sudo` and is highly recommended.

```bash
sudo usermod -aG docker $USER
```

**Important:** You must reboot your Raspberry Pi for this change to take effect.

```bash
sudo reboot
```

### Step 4: Clone This Repository

After the reboot, clone this project's repository.

```bash
git clone <URL_YOUR_REPOSITORY>
cd raspberry-proxies
```

### Step 5: Make the Management Script Executable

Grant execute permissions to the `manage.sh` script. This only needs to be done once.

```bash
chmod +x manage.sh
```

## 🛠️ Management Commands

The `manage.sh` script simplifies the management of all services.

**To start all services:**

```bash
./manage.sh up
```

Here are the available commands:

| Command | Description |
| :--- | :--- |
| `./manage.sh up` | Builds and runs all services in the background. |
| `./manage.sh down` | Stops and removes all service containers. |
| `./manage.sh build`| Rebuilds the Docker images (useful when you change a `Dockerfile`).|

## Ports

| Service | Port(s) |
| :--- | :--- |
| **multitor** | `16378`, `16379`, `16380` |
| **psiphon** | `1080`, `8080` |
| **warp** | `8086` |
| **hiddify-tvc** | `2334`, `2335`, `6756`, `6450` |

```
```
