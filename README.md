_🍿 Smash that ⭐️ like you're fast-forwarding through a bad commercial break._

# Duplex 📺🚀

Welcome to Duplex—your backstage pass to running a star-studded Plex Media Server on Synology NAS! Think of it as your assistant director for managing all the Docker magic behind your media empire. 🎬

## Overview 📋
>
> ☠️ **Rumor has it there's hidden treasure in these waters...** [🦜🏴‍☠️](config/plundarr/README.md)

The `docker-compose.yml` script sets the scene for running your Plex Media Server on Synology NAS. It's like having a sitcom cast of helpful apps for metadata, cleaning, monitoring, and auto-updating—always ready for their cue.

For a deeper dive into the Docker Compose configuration, check out the Docker Compose file in this repository.

- 📄 [View docker-compose.yml](./docker-compose.yml)

## Included Tools 🛠️

Here's the cast list—starring the finest apps to keep your Plex show running smoother than a perfect cold open:

| Tool                 | Description                                                   | More Info                                                             |
|----------------------|---------------------------------------------------------------|-----------------------------------------------------------------------|
| **Kometa** ✨         | Turns your Plex into a blockbuster.                          | [Wiki](https://kometa.wiki/en/latest/)                          |
| **ImageMaid** 🧼     | Scrubs your Plex images till they shine.                     | [Wiki](https://kometa.wiki/en/nightly/kometa/scripts/imagemaid/) |
| **Overlay Reset** 🧹 | Wipes away old overlays like a reboot.                       | [Repo](https://github.com/kometa-team/overlay-reset)             |
| **PATTRMM** 📅       | Schedules chores so you don't have to.                       | [Repo](https://github.com/insertdisc/pattrmm)                    |
| **Tautulli** 📊      | Spies on your Plex binge habits.                            | [Repo](https://github.com/Tautulli/Tautulli/)                    |
| **Notifiarr** 🔔     | Blasts you with updates before drama hits.                  | [Repo](https://github.com/Notifiarr/notifiarr/)                  |
| **Watchtower** 🛠️   | Updates containers while you sleep.                         | [Repo](https://github.com/containrrr/watchtower)                 |

> [!NOTE]
> Overlay Reset is included as a separate docker compose deployment in [`config/overlay-reset`](./config/overlay-reset/README.md). It can be deployed separately using the same steps in the [Deploying with Container Manager](./SETUP.md#deploying-with-container-manager-) section.

## Usage 🚀

### Clone the Project to Your Synology NAS 🎬

Lights, camera, action! First, grab the project and all its star performers (submodules included) to your Synology NAS. Use the command below to ensure you include all the necessary submodules:

> [!NOTE]
> 🎬 The Kometa configuration files are spun off into their own spinoff series: [kometa-config](https://github.com/scottgigawatt/kometa-config). It's included here as a submodule at `config/kometa`—so don't skip that `--recurse-submodules` magic trick.

```sh
git clone --recurse-submodules https://github.com/scottgigawatt/duplex.git /volume1/docker/duplex
```

### Managing Docker Config Environment Variables 🧩

Every great production needs a script. Copy the example `.env` files and tweak them so your Docker cast hits their marks perfectly.

- 📄 [View example.env](example.env)
- 📄 [View config/imagemaid/example.env](config/imagemaid/example.env)

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

### 🎬 Critical Setup Briefing 🍿

> [!IMPORTANT]
> 🎞️ _In a world where containers rise and networks clash..._
>
> Make sure you read the [Docker Project Setup](./SETUP.md) guide! It covers the essential plot points: configuring Docker networking, fine-tuning Synology settings, locking down the firewall, and launching your app stack with Container Manager. Miss it, and your production might never make it to opening night.

The [Docker Project Setup](./SETUP.md) script features:

- 🌍🔧 [Configuring Docker Networking](./SETUP.md#configuring-docker-networking-)
- 🖥️⚙️ [Synology Configuration](./SETUP.md#synology-configuration-️)
  - 🔥🛡️ [Updating Firewall Settings](./SETUP.md#updating-firewall-settings-️)
  - 📦🚀 [Deploying With Container Manager](./SETUP.md#deploying-with-container-manager-)

Don't be the hero who forgets their training montage. Read the guide. Save the project. 🎥

## License 📄

Licensed under the Apache 2 License—because every good show deserves a fair contract. 📄

---

Contribute, suggest plot twists, or leave a review—your feedback keeps the Duplex series renewed for another season. Happy Plexing, and may your binge-watching be uninterrupted! 🌟
