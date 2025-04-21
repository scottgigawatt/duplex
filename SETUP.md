# Docker Project Setup 🏗️🐳

This guide provides common networking and deployment considerations for Docker Compose-based projects. These instructions focus on Synology DiskStations with DSM 7.2 or newer, but also apply to Linux and macOS.

## Configuring Docker Networking 🌍🔧

> [!IMPORTANT]
> Make sure you configure the IPAM settings correctly in your `.env` file before deploying the stack. Incorrect settings can cause container networking issues.

Docker IPAM (IP Address Management) lets you assign IP addresses within a defined subnet, improving predictability and simplifying troubleshooting 🛠️.

Update these settings in your `.env` file:

```bash
#
# Subnet range: 172.28.0.1 - 172.28.255.254
# Subnet mask: 255.255.0.0
#
COMPOSE_NETWORK_SUBNET="${COMPOSE_NETWORK_SUBNET:-172.28.0.0/16}"

#
# IP range for containers: 172.28.5.1 - 172.28.5.254
# Subnet mask: 255.255.255.0
#
COMPOSE_NETWORK_IP_RANGE="${COMPOSE_NETWORK_IP_RANGE:-172.28.5.0/24}"

#
# Network gateway IP address
#
COMPOSE_NETWORK_GATEWAY="${COMPOSE_NETWORK_GATEWAY:-172.28.5.254}"
```

For detailed documentation, refer to the [Docker Compose IPAM documentation](https://docs.docker.com/compose/compose-file/06-networks/#ipam).

## Synology Configuration 🖥️🔧

These settings are specific to configuring networking and deployment on Synology DiskStations.

### Updating Firewall Settings 🔥🛡️

> [!WARNING]
> Misconfigured firewall rules may prevent containers from communicating with each other or with external services. Double-check the source IP and subnet settings.

If your Synology DiskStation firewall is enabled, allow traffic for the custom Docker network:

1. 🛠️ Open **Control Panel** → **Security** (under Connectivity).
2. 🛡️ Go to the **Firewall** tab → Click **Edit Rules**.
3. ➕ Click **Create** to add a rule:
   - 🎯 **Ports**: Select `All`
   - 🌐 **Source IP**: Select `Specific IP`
   - 🧩 Click `Select` → Choose `Subnet`
   - 📝 Enter `172.28.0.0` for **IP Address** and `255.255.0.0` for **Subnet mask/Prefix length**
   - ✅ **Action**: Select `Allow`
4. 💾 Click **OK** to apply.

This allows containers to communicate internally within the defined Docker network.

### Deploying With Container Manager 📦🚀

> [!NOTE]
> If you're running Synology DSM 7.2 or later, the Container Manager Project feature provides an easier and faster way to deploy your apps. Make sure your system is updated before proceeding.

To deploy a project using Synology Container Manager:

1. 🔑 Log in to the Synology DSM web interface.
2. 📦 Open **Container Manager** and navigate to the **Project** tab 📂.
3. 🆕 Click **Create** and configure:
   - 🏷️ **Project Name**: (e.g., `duplex`)
   - 📂 **Project Path**: Path to the cloned repository.
4. 🚀 Review and confirm the settings to deploy the project.

Refer to the [official Synology documentation](https://kb.synology.com/en-id/DSM/help/ContainerManager/docker_project?version=7) for further details.

---

These tips should help you get rolling 🚴‍♂️ — may your containers stay healthy 🏥 and your logs stay quiet 🤫. Happy Dockering! 🐳🚀
