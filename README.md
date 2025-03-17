# Duplex 📺🚀

Welcome to Duplex! Your trusty sidekick for Plex Media Server management on Synology NAS, serving up a delightful Docker Compose configuration packed with essential tools and utilities.

## Overview 📋
>
> ☠️ **Rumor has it there's hidden treasure in these waters...** [🦜🏴‍☠️](#plundarr-the-ultimate-booty-for-plex-scallywags-️)

The `docker-compose.yml` file in this repository sets the stage for managing your Plex Media Server on a Synology NAS. It's like your personal assistant, complete with tools for metadata management, photo cleaning, monitoring, and automated updates.

For a deeper dive into the Docker Compose configuration, check out the Docker Compose file in this repository.

📄 [View docker-compose.yml](./docker-compose.yml)

## Included Tools 🛠️

| Tool                    | Description                                                  | More Info                                                                 |
|-------------------------|--------------------------------------------------------------|---------------------------------------------------------------------------|
| **Kometa** ✨            | Your metadata maestro for Plex Media Server.                | [Kometa Info](https://kometa.wiki/en/nightly/)                            |
| **ImageMaid** 🧼        | The superhero that cleans up those messy Plex Media Server photos. | [ImageMaid Info](https://kometa.wiki/en/nightly/kometa/scripts/imagemaid/)|
| **Overlay Reset** 🧹    | Bye-bye overlays! Removes all overlays from your Plex Library. | [Kometa Overlay Reset Info](https://github.com/kometa-team/overlay-reset) |
| **PATTRMM** 📅          | Your scheduler for media processing tasks—because timing is everything! | [PATTRMM GitHub](https://github.com/insertdisc/pattrmm)                   |
| **Tautulli** 📊         | Your Plex usage tracker—perfect for the stats-loving cinephile. | [Tautulli GitHub](https://github.com/Tautulli/Tautulli/)                  |
| **Notifiarr** 🔔        | Stay in the loop with notifications for all your media server shenanigans. | [Notifiarr GitHub](https://github.com/Notifiarr/notifiarr/)               |
| **Watchtower** 🛠️       | The auto-updater that keeps your Docker containers fresh and fabulous. | [Watchtower GitHub](https://github.com/containrrr/watchtower)             |

## Usage 🚀

### Starting the Service Stack

Ready to kick off your Duplex service stack? Follow these blockbuster steps:

1. Clone this repository to your Synology NAS, including the submodules.

   ```bash
   git clone --recurse-submodules https://github.com/scottgigawatt/duplex.git
   ```

   > 🎬 **Behind the Scenes**: The Kometa configuration files are maintained in a separate repo here: [kometa-config](https://github.com/scottgigawatt/kometa-config). It's included in this project as a submodule at `config/kometa`—that's why you see the `--recurse-submodules` magic in the `git clone` command. When updates roll out in the config, we bump the submodule here to sync things up, like a sequel that actually improves on the original. 🍿
   > Want to remix this setup for yourself? Fork both repos and update the URLs to point to your personal masterpieces. 🎞️✨

2. Navigate to the directory containing the `docker-compose.yml` file.
3. Open a terminal or SSH into your Synology NAS—time to get technical!
4. Run `docker-compose up -d` to start the containers in detached mode.
5. Access the services through their respective endpoints—like opening a treasure chest of media!
6. Configure services to connect to Plex using the gateway IP address of the Docker bridge network. You can find this IP in `Container Manager -> Network` for DSM 7.2 and above.
   > 🎥 **Pro Tip**: While you can use these commands for testing and debugging, we recommend running this project through DSM Container Manager for a smoother production experience. Jump to [Managing the Project with DSM Container Manager 📦](#managing-the-project-with-dsm-container-manager-) to roll out the red carpet for your deployment.

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

> **Note**: If you encounter "Socket closed" errors when accessing the DSM UI via reverse proxy and trying to open terminals for running containers, enable WebSocket for the reverse proxy record:
>
> 1. Go to `Control Panel -> Application Portal -> Reverse Proxy`.
> 2. Select `Edit` for your reverse proxy record.
> 3. Navigate to the `Custom Header` tab.
> 4. From the `Create` dropdown, select `WebSocket`.
> 5. Save the changes to resolve the issue—like fixing a plot hole!

## Environment Details 🖥️

Tested on Synology DS916+ running DSM 7.2.1-69057 Update 5, with Docker Compose v2.9.0-6413-g38f6acd.

## Plundarr: The Ultimate Booty for Plex Scallywags 🏴‍☠️⚓

Ahoy, matey! 🚢 So ye fancy yerself a proper Plex privateer? While **Duplex** gives ye a chest full o' shiny accessories to keep yer Plex shipshape—collections, automation, and tools aplenty—there be a darker, saltier sea to sail... 🌊☠️

If ye be ready to hoist the mainsail and take yer Plex adventures to legendary status, chart a course to **[Plundarr](https://github.com/scottgigawatt/plundarr)**! 🏴‍☠️ It's a treasure trove o' automation and services that'll make yer media empire the envy of every pirate in the digital seas. ⚓🍿

### 🏴‍☠️ Services Included in the Plundarr Armada

- 🏴 **privateerr**: [Repo](https://github.com/scottgigawatt/privateerr) - A true rogue's delight.
- 🐙 **gluetun**: [Repo](https://github.com/qdm12/gluetun) - Keep yer IP hidden like a kraken in the depths.
- 🔥 **flaresolverr**: [Repo](https://github.com/FlareSolverr/FlareSolverr) - Blast past them pesky captchas.
- 🎯 **prowlarr**: [Repo](https://github.com/Prowlarr/Prowlarr) - The lookout in yer crow's nest.
- ⚓ **qbittorrent**: [Repo](https://github.com/qbittorrent/qBittorrent) - Hoist torrents with ease.
- 🎥 **radarr**: [Repo](https://github.com/Radarr/Radarr) - Yer first mate for movies.
- 📺 **sonarr**: [Repo](https://github.com/Sonarr/Sonarr) - The boatswain for yer shows.
- 📝 **bazarr**: [Repo](https://github.com/morpheus65535/bazarr) - Subtitles to keep yer crew from mutiny.
- 📚 **readarr**: [Repo](https://github.com/Readarr/Readarr) - For the pirates who read between plunderin'.
- 🍿 **overseerr**: [Repo](https://github.com/sct/overseerr) - The quartermaster for yer crew's requests.
- 🏴‍☠️ **speedtest-tracker**: [Docs](https://docs.speedtest-tracker.dev) - Know if the wind be in yer favor.
- 🔐 **duplicati**: [Site](https://www.duplicati.com) - Keep yer loot backed up, lest ye lose it to Davy Jones!
- 🏠 **homepage**: [Docs](https://gethomepage.dev/latest) - A dashboard fit for a pirate king.

So grab yer spyglass, stock yer rum 🍻, and set sail for **Plundarr**. Yarr, automation be just the start of this adventure! 🦜⚓

## License 📄

Licensed under the Apache 2 License - see [LICENSE](LICENSE) for details.

---

Contribute or provide feedback to improve the Duplex repository. Happy Plexing and may your binge-watching be ever delightful! 🌟
