# 🚀 Watchtower Run Once Configuration

Welcome to the watchtower directory! This directory contains the Docker Compose configuration for running Watchtower one time only using the WATCHTOWER_RUN_ONCE environment variable. 🕒 Watchtower will check for updates on the specified containers, apply them, and then exit.

## 🛠️ Usage

 1. Clone Repository:

    ```bash
    git clone https://github.com/scottgigawatt/duplex.git
    cd duplex/config/watchtower
    ```

 1. Configure Environment:

    Copy `example.env` to `.env` and configure the variables, including the container names you want to update. 📝

 1. Run Docker Compose:

    ```bash
    docker-compose up
    ```

    🎯 This will trigger Watchtower to:
    - Run once
    - Check for container updates
    - Apply updates if available 🧩
    - Exit when complete.

## 📂 Files

- docker-compose.yml: Docker Compose configuration for Watchtower.
- example.env: Example environment file to set container targets and options.

## ⚠️ Notes

- Make sure the container names in your .env file match the names of the running containers you want to update.
- For more details on the WATCHTOWER_RUN_ONCE feature, visit the Watchtower Documentation.

---

🔄 Happy updating with Watchtower!
