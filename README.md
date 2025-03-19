# Duplex 📺🚀

Welcome to Duplex! Your trusty sidekick for Plex Media Server management on Synology NAS, serving up a delightful Docker Compose configuration packed with essential tools and utilities.

## Overview 📋
>
> ☠️ **Rumor has it there's hidden treasure in these waters...** [🦜🏴‍☠️](config/plundarr/README.md)

The `docker-compose.yml` file in this repository sets the stage for managing your Plex Media Server on a Synology NAS. It's like your personal assistant, complete with tools for metadata management, photo cleaning, monitoring, and automated updates.

For a deeper dive into the Docker Compose configuration, check out the Docker Compose file in this repository.

- 📄 [View docker-compose.yml](./docker-compose.yml)

## Included Tools 🛠️

| Tool                    | Description                                                  | More Info |
|-------------------------|--------------------------------------------------------------|-----------|
| **Kometa** ✨            | The savvy first mate for yer Plex metadata.                | [More Info](https://kometa.wiki/en/nightly/)                            |
| **ImageMaid** 🧼        | Swabs yer Plex photos clean as a whistle.                   | [More Info](https://kometa.wiki/en/nightly/kometa/scripts/imagemaid/)   |
| **Overlay Reset** 🧹    | Scrubs away every overlay from yer Plex library.            | [More Info](https://github.com/kometa-team/overlay-reset)               |
| **PATTRMM** 📅          | Schedules yer chores like a true deckhand.                  | [More Info](https://github.com/insertdisc/pattrmm)                      |
| **Tautulli** 📊         | Tracks crew activity on yer Plex vessel.                    | [More Info](https://github.com/Tautulli/Tautulli/)                      |
| **Notifiarr** 🔔        | Sends word o' ship happenings straight to yer crow's nest.  | [More Info](https://github.com/Notifiarr/notifiarr/)                    |
| **Watchtower** 🛠️       | Auto-updates yer containers like a lookout changin' shifts.  | [More Info](https://github.com/containrrr/watchtower)                   |

## Usage 🚀

### Starting the Service Stack

Ready to kick off your Duplex service stack? Follow these blockbuster steps:

1. Clone this repository to your Synology NAS, including the submodules.

   ```bash
   git clone --recurse-submodules https://github.com/scottgigawatt/duplex.git
   ```

   > [!NOTE]
   > 🎬 The Kometa configuration files are maintained in a separate repo: [kometa-config](https://github.com/scottgigawatt/kometa-config). It's included here as a submodule at `config/kometa`—hence the `--recurse-submodules` magic.

   > [!TIP]
   > 🍿 Want to remix this blockbuster? Fork both repos and update the URLs to create your own cinematic universe!

2. Navigate to the directory containing the `docker-compose.yml` file.
3. Open a terminal or SSH into your Synology NAS—time to get technical!
4. Run `docker-compose up -d` to start the containers in detached mode.
5. Access the services through their respective endpoints—like opening a treasure chest of media!
6. Configure services to connect to Plex using the gateway IP address of the Docker bridge network. You can find this IP in `Container Manager -> Network` for DSM 7.2 and above.

   > [!IMPORTANT]
   > 🎥 For the smoothest production rollout, we recommend managing this project via DSM Container Manager's Project feature. Jump to [Managing the Project with DSM Container Manager 📦](#managing-the-project-with-dsm-container-manager-) to roll out the red carpet for your deployment.

### Managing Docker Config Environment Variables 🧩

The configurations for the main Docker Compose file, ImageMaid, and Overlay Reset are managed using `.env` files. Copy the `example.env` files to `.env` and tweak them to suit your cinematic needs.

- Main Docker Compose: [example.env](example.env)
- ImageMaid: [config/imagemaid/example.env](config/imagemaid/example.env)
- Overlay Reset: [config/overlay-reset/example.env](config/overlay-reset/example.env)

Want to override these variables on the fly? Just do it on the command line when starting the Docker Compose stack:

```bash
KOMETA_TAG="latest" docker-compose up -d
```

Adjust the values of these environment variables to fit your streaming dreams.

### Managing the Project with DSM Container Manager 📦

Let's make your project shine in DSM 7.2 Container Manager's Project feature:

1. SSH into your Synology NAS and log in.
2. Clone this repository to a directory, such as `/volume1/docker/duplex` (or your preferred path).
3. Open **Container Manager** and navigate to the **Project** tab.
4. Click **Create**, give your project a name (e.g., `duplex`), and set the project path to the cloned directory.
5. Follow the on-screen prompts to review settings and deploy the project like a pro!

For more on Container Manager Projects, refer to the official Synology documentation [here](https://kb.synology.com/en-id/DSM/help/ContainerManager/docker_project?version=7).

### Secure Access to Synology Applications 🔒

Want to ensure secure access to your Synology applications? Use DSM 7 Reverse Proxy! Follow the guide [here](https://mariushosting.com/synology-how-to-use-reverse-proxy-on-dsm-7/) for DSM 7.

> [!WARNING]
> 🚨 If you get "Socket closed" errors when accessing the DSM UI through a reverse proxy, enable WebSocket support under `Custom Header` to avoid cutting your scenes short.

## Environment Details 🖥️

> [!CAUTION]
> ⚠️ This setup has been tested on a Synology DS916+ with DSM 7.2.1-69057 Update 5. Other setups may have unexpected plot twists!

Tested on Synology DS916+ running DSM 7.2.1-69057 Update 5, with Docker Compose v2.9.0-6413-g38f6acd.

## License 📄

Licensed under the Apache 2 License - see [LICENSE](LICENSE) for details.

---

Contribute or provide feedback to improve the Duplex repository. Happy Plexing and may your binge-watching be ever delightful! 🌟
