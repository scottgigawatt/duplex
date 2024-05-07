# Duplex

Docker Utilities for Plex (Duplex) contains a Docker Compose configuration tailored for Synology NAS environments. It simplifies the setup process for managing Plex Media Server by integrating several useful tools and utilities.

## Tools Included

- **Kometa**: Manages metadata in Plex Media Server. [More info](https://kometa.wiki/en/nightly/)
- **ImageMaid**: Cleans photos in Plex Media Server. [More info](https://kometa.wiki/en/nightly/kometa/scripts/imagemaid/)
- **Tautulli**: Provides monitoring and tracking tools for Plex Media Server. [GitHub](https://github.com/Tautulli/Tautulli/)
- **Watchtower**: Automates Docker container base image updates. [GitHub](https://github.com/containrrr/watchtower)

## Usage

### Starting the Docker Compose Service Stack

To start the Duplex service stack, follow these steps:

1. Clone this repository to your Synology NAS.

2. Navigate to the directory containing the `docker-compose.yml` file.

3. Open a terminal or SSH into your Synology NAS.

4. Run the following command:

    ```bash
    docker-compose up -d
    ```

    This command will start the Docker containers defined in the `docker-compose.yml` file in detached mode.

5. Access the services through their respective endpoints.

### Managing Docker Config Environment Variables

Docker configuration environment variables can be set and managed in the `.env` file in the root of the project directory. These variables can also be easily overridden on the command line when starting the Docker Compose stack by setting the variables in front of the command like:

```bash
# Run the 'kometa' service using the 'latest' image tag
KOMETA_TAG="latest" docker-compose up -d
```

Feel free to adjust the values of these environment variables according to your specific requirements.

## Accessing Synology Applications Securely

You can use the DSM 7 Reverse Proxy feature to configure secure access to your Synology applications. Follow the guide provided [here](https://mariushosting.com/synology-how-to-use-reverse-proxy-on-dsm-7/) to set up reverse proxy on DSM 7.

## Environment Details

The Duplex configuration has been tested on a Synology DS916+ running DSM 7.2.1-69057 Update 5, with Docker Compose version v2.9.0-6413-g38f6acd.

## License

This project is licensed under the Apache 2 License - see the [LICENSE](LICENSE) file for details.

---

Feel free to contribute or provide feedback to improve the Duplex repository. Happy Plexing!
