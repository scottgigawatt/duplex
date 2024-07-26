# Duplex 📺🚀

Duplex simplifies Plex Media Server management on Synology NAS by providing a Docker Compose configuration with essential tools and utilities.

## Overview 📋

The `docker-compose.yml` file in this repository configures Docker containers for managing a Plex Media Server on a Synology NAS. It includes tools for metadata management, photo cleaning, monitoring, and automated updates.

For more details on the Docker Compose configuration, refer to the [docker-compose.yml](docker-compose.yml) file in this repository.

## Included Tools 🛠️

- **Kometa**: Manages Plex Media Server metadata. [More info](https://kometa.wiki/en/nightly/)
  > **Note**: Kometa configuration details are in a [separate repository](https://github.com/scottgigawatt/kometa-config) and included as a submodule in this repository at `config/kometa` for easier deployment.
- **ImageMaid**: Cleans Plex Media Server photos. [More info](https://kometa.wiki/en/nightly/kometa/scripts/imagemaid/)
- **PATTRMM**: Schedule and run media processing tasks. [GitHub](https://github.com/insertdisc/pattrmm)
- **Tautulli**: Monitors and tracks Plex Media Server usage. [GitHub](https://github.com/Tautulli/Tautulli/)
- **Notifiarr**: Provides notifications for various media server activities. [GitHub](https://github.com/Notifiarr/notifiarr/)
- **Watchtower**: Automatically updates Docker container base images. [GitHub](https://github.com/containrrr/watchtower)
- **Kometa Overlay Reset**: Removes all overlays placed on a Plex Library. [More info](https://github.com/kometa-team/overlay-reset)

## Usage 🚀

### Starting the Service Stack

Follow these steps to start the Duplex service stack:

1. Clone this repository to your Synology NAS, including the submodules.

   ```bash
   git clone --recurse-submodules https://github.com/yourusername/duplex.git
   ```

2. Navigate to the directory containing the `docker-compose.yml` file.
3. Open a terminal or SSH into your Synology NAS.
4. Run `docker-compose up -d` to start the containers in detached mode.
5. Access the services through their respective endpoints.
6. Configure services to connect to Plex using the gateway IP address of the Docker bridge network. Find this IP in `Container Manager -> Network` for DSM 7.2 and above.

### Managing Docker Config Environment Variables 🧩

The configurations for the main Docker Compose file, ImageMaid, and Overlay Reset are managed using `.env` files. The `example.env` files can be copied to `.env` and updated to change the behavior.

- Main Docker Compose: [example.env](example.env)
- ImageMaid: [config/imagemaid/example.env](config/imagemaid/example.env)
- Overlay Reset: [config/overlay-reset/example.env](config/overlay-reset/example.env)

Override these variables easily on the command line when starting the Docker Compose stack:

```bash
KOMETA_TAG="latest" docker-compose up -d
```

Adjust the values of these environment variables to your requirements.

Sure, here's an updated section for your `plundarr` repository README:

---

### Viewing Configuration Details

The `plundarr` repository provides several tools to view and manage the environment and Docker Compose configuration details. While the configuration files are heavily documented to assist with understanding and customization, some users may prefer to see the uncommented versions for simplicity.

#### Makefile Targets

The included `Makefile` contains targets to help with this:

- **Print the evaluated Docker Compose default environment configuration:**

  ```sh
  make env
  ```

- **Render the actual data model to be applied on the Docker Engine:**

  ```sh
  make config
  ```

- **Print the raw uncommented Docker Compose environment configuration:**

  ```sh
  make print-env
  ```

- **Print the raw uncommented Docker Compose YAML configuration:**

  ```sh
  make print-config
  ```

Using these commands will provide you with a clearer view of the environment and configuration details without the additional comments.

### Managing the Project with DSM Container Manager 📦

To import this project into DSM 7.2 Container Manager's Project feature:

1. SSH into your Synology system.
2. Clone this repository.
3. In Container Manager, click **Project** then **Create**.
4. Provide a title, e.g., **duplex**.
5. Set the path to the cloned repository.
6. Proceed through UI prompts to finish creating the project.

Refer to the official Synology documentation [here](https://kb.synology.com/en-id/DSM/help/ContainerManager/docker_project?version=7) for more on Container Manager Projects.

### Secure Access to Synology Applications 🔒

Use DSM 7 Reverse Proxy to configure secure access to Synology applications. Follow the guide [here](https://mariushosting.com/synology-how-to-use-reverse-proxy-on-dsm-7/) for DSM 7.

> **Note**: If you encounter "Socket closed" errors when accessing the DSM UI via reverse proxy and trying to open terminals for running containers, enable WebSocket for the reverse proxy record:
>
> 1. Go to `Control Panel -> Application Portal -> Reverse Proxy`.
> 2. Select `Edit` for your reverse proxy record.
> 3. Navigate to the `Custom Header` tab.
> 4. From the `Create` dropdown, select `WebSocket`.
> 5. Save the changes to resolve the issue.

## Environment Details 🖥️

Tested on Synology DS916+ running DSM 7.2.1-69057 Update 5, with Docker Compose version v2.9.0-6413-g38f6acd.

## License 📄

Licensed under the Apache 2 License - see [LICENSE](LICENSE) for details.

---

Contribute or provide feedback to improve the Duplex repository. Happy Plexing! 🌟
