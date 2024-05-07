# Duplex

Duplex simplifies Plex Media Server management on Synology NAS by providing a Docker Compose configuration with essential tools and utilities.

## Tools Included

- **Kometa**: Manages Plex Media Server metadata. [Configuration details](https://github.com/scottgigawatt/kometa-config). [More info](https://kometa.wiki/en/nightly/)
- **ImageMaid**: Cleans Plex Media Server photos. [More info](https://kometa.wiki/en/nightly/kometa/scripts/imagemaid/)
- **Tautulli**: Monitors and tracks Plex Media Server usage. [GitHub](https://github.com/Tautulli/Tautulli/)
- **Watchtower**: Automatically updates Docker container base images. [GitHub](https://github.com/containrrr/watchtower)

## Usage

### Starting the Service Stack

Follow these steps to start the Duplex service stack:

1. Clone this repository to your Synology NAS.

2. Navigate to the directory containing the `docker-compose.yml` file.

3. Open a terminal or SSH into your Synology NAS.

4. Run:

    ```bash
    docker-compose up -d
    ```

    This command starts the Docker containers defined in [`docker-compose.yml`](docker-compose.yml) in detached mode.

5. Access the services through their respective endpoints.

### Managing Docker Config Environment Variables

Manage Docker configuration environment variables in the [`.env`](.env) file. Override these variables easily on the command line when starting the Docker Compose stack:

```bash
KOMETA_TAG="latest" docker-compose up -d
```

Adjust the values of these environment variables to your requirements.

### Managing the Project with DSM Container Manager

To import this project into DSM 7.2 Container Manager's Project feature:

1. SSH into your Synology system.

2. Clone this repository:

   ```bash
   git clone https://github.com/scottgigawatt/duplex.git
   ```

3. In Container Manager, click **Project** then **Create**.

4. Provide a title, e.g., **duplex**.

5. Set the path to the cloned repository.

6. Proceed through UI prompts to finish creating the project.

Refer to the official Synology documentation [here](https://kb.synology.com/en-id/DSM/help/ContainerManager/docker_project?version=7) for more on Container Manager Projects.

## Secure Access to Synology Applications

Use DSM 7 Reverse Proxy to configure secure access to Synology applications. Follow the guide [here](https://mariushosting.com/synology-how-to-use-reverse-proxy-on-dsm-7/) for DSM 7.

## Environment Details

Tested on Synology DS916+ running DSM 7.2.1-69057 Update 5, with Docker Compose version v2.9.0-6413-g38f6acd.

## License

Licensed under the Apache 2 License - see [LICENSE](LICENSE) for details.

---

Contribute or provide feedback to improve the Duplex repository. Happy Plexing!
