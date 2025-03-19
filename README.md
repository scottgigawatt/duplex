_🍿 Smash that ⭐️ like it's the Netflix "Skip Intro" button._

# Duplex 📺🚀

Welcome to Duplex! Your ultimate co-star in managing Plex Media Server on Synology NAS, delivering a stellar Docker Compose configuration filled with essential tools and utilities for your media experience.

## Overview 📋
>
> ☠️ **Rumor has it there's hidden treasure in these waters...** [🦜🏴‍☠️](config/plundarr/README.md)

The `docker-compose.yml` file in this repository sets the stage for managing your Plex Media Server on a Synology NAS. It's like having your own personal assistant, equipped with tools for metadata management, photo cleaning, monitoring, and automated updates.

For a deeper dive into the Docker Compose configuration, check out the Docker Compose file in this repository.

- 📄 [View docker-compose.yml](./docker-compose.yml)

## Included Tools 🛠️

| Tool                 | Description                                                                    | More Info                                                             |
|----------------------|--------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| **Kometa** ✨         | Your metadata director, transforming your Plex library into a blockbuster hit. | [More Info](https://kometa.wiki/en/nightly/)                          |
| **ImageMaid** 🧼     | The photo stylist polishing your cast pics for the red carpet.                 | [More Info](https://kometa.wiki/en/nightly/kometa/scripts/imagemaid/) |
| **Overlay Reset** 🧹 | Hits reset like Hollywood rebooting your favorite franchise.                   | [More Info](https://github.com/kometa-team/overlay-reset)             |
| **PATTRMM** 📅       | The showrunner ensuring your automation schedule hits all the right notes.     | [More Info](https://github.com/insertdisc/pattrmm)                    |
| **Tautulli** 📊      | Your behind-the-scenes analytics for tracking viewer engagement.               | [More Info](https://github.com/Tautulli/Tautulli/)                    |
| **Notifiarr** 🔔     | Sends alerts faster than your favorite show's plot twists.                     | [More Info](https://github.com/Notifiarr/notifiarr/)                  |
| **Watchtower** 🛠️   | Auto-updates your containers like a dedicated editor in post-production.       | [More Info](https://github.com/containrrr/watchtower)                 |

> [!NOTE]
> Overlay Reset is included as a separate docker compose deployment in [`config/overlay-reset`](./config/overlay-reset/README.md). It can be deployed separately using the same steps in the [Managing the Project with DSM Container Manager](#3-managing-the-project-with-dsm-container-manager-) section.

---

## Usage 🚀

### 1. Clone the Project to Your Synology NAS 🎬

Ready to start your streaming adventure? First, clone the project repository to your Synology NAS. Use the command below to ensure you include all the necessary submodules:

> [!NOTE]
> 🎬 The Kometa configuration files are maintained in a separate repo: [kometa-config](https://github.com/scottgigawatt/kometa-config). It's included here as a submodule at `config/kometa`—hence the `--recurse-submodules` magic.

> [!IMPORTANT]
> Cloning with submodules is crucial for proper functionality.

```sh
git clone --recurse-submodules https://github.com/scottgigawatt/duplex.git /volume1/docker/duplex
```

### 2. Managing Docker Config Environment Variables 🧩

Next, set up the configurations for the main Docker Compose deployment and ImageMaid using `.env` files. Copy the `example.env` files to `.env` and customize them for your cinematic needs.

- 📄 [View example.env](example.env)
- 📄 [View config/imagemaid/example.env](config/imagemaid/example.env)

> [!NOTE]
> Remember to edit the `.env` files to suit your individual setup.

```sh
cp example.env .env
cp config/imagemaid/example.env config/imagemaid/.env

# Edit as needed
vim .env
vim config/imagemaid/.env
```

> [!TIP]
> Want to override these variables on the fly? Just do it on the command line when starting the Docker Compose stack:
>
> ```bash
> KOMETA_TAG="nightly" docker-compose up -d
> ```

Adjust the values of these environment variables to fit your streaming dreams.

### 3. Managing the Project with DSM Container Manager 📦

Let's make your project shine in DSM 7.2 Container Manager's Project feature:

1. Log in to your Synology NAS web UI.
2. Open **Container Manager** and navigate to the **Project** tab.
3. Click **Create**, give your project a name (e.g., `duplex`), and set the project path to the cloned directory.
4. Follow the on-screen prompts to review settings and deploy the project like a pro!

For more on Container Manager Projects, refer to the official Synology documentation [here](https://kb.synology.com/en-id/DSM/help/ContainerManager/docker_project?version=7).

---

## Configuring IPAM and Network Firewall 🌍

Let's talk Docker IPAM (IP Address Management). It's the superhero of container networking! To keep your containers communicating smoothly, you might need to tweak your firewall settings in Synology DSM.

### IPAM Configuration

Time to get your hands dirty! Configure the following in your [`.env`](example.env) file:

```bash
#
# Subnet range: 172.28.0.1 - 172.28.255.254
# Total IP addresses: 65,536
# Usable IP addresses: 65,534
# Subnet mask: 255.255.0.0
#
COMPOSE_NETWORK_SUBNET="${COMPOSE_NETWORK_SUBNET:-172.28.0.0/16}"

#
# IP range for containers: 172.28.5.1 - 172.28.5.254
# Total IP addresses: 256
# Usable IP addresses: 254
# Subnet mask: 255.255.255.0
#
COMPOSE_NETWORK_IP_RANGE="${COMPOSE_NETWORK_IP_RANGE:-172.28.5.0/24}"

#
# Network gateway IP address: 172.28.5.254
#
COMPOSE_NETWORK_GATEWAY="${COMPOSE_NETWORK_GATEWAY:-172.28.5.254}"
```

### Updating Firewall Settings on Synology NAS 🔥

Ready to unleash the power of communication for your Docker network? Update your **Synology Firewall** settings:

1. Open **Control Panel** → **Security** (under Connectivity).
2. Navigate to the **Firewall** tab → Click **Edit Rules**.
3. Click **Create** to add a new rule:
   - **Ports**: Select `All`
   - **Source IP**: Select `Specific IP`
   - Click `Select` → Choose `Subnet`
   - Enter `172.28.0.0` for **IP Address** and `255.255.0.0` for **Subnet mask/Prefix length**
   - **Action**: Select `Allow`
4. Click **OK** to apply the changes.

Now your containers can chat freely! 🎉

For more details, check out the **[Docker Compose IPAM documentation](https://docs.docker.com/compose/compose-file/06-networks/#ipam)**.

---

## License 📄

Licensed under the Apache 2 License - see [LICENSE](LICENSE) for details.

---

Contribute or provide feedback to improve the Duplex repository. Happy Plexing, and may your binge-watching be ever delightful! 🌟
