# Duplex

Docker Utilities for Plex (Duplex) contains a Docker Compose configuration tailored for Synology NAS environments. It simplifies the setup process for managing Plex Media Server by integrating several useful tools and utilities.

## Tools Included

- **Kometa**: Manages metadata in Plex Media Server (configuration located [here](https://github.com/scottgigawatt/kometa-config)). [More info](https://kometa.wiki/en/nightly/)
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

    This command will start the Docker containers defined in the [`docker-compose.yml`](docker-compose.yml) file in detached mode.

5. Access the services through their respective endpoints.

### Managing Docker Config Environment Variables

Docker configuration environment variables can be set and managed in the [`.env`](.env) file in the root of the project directory. These variables can also be easily overridden on the command line when starting the Docker Compose stack by setting the variables in front of the command like:

```bash
# Run the 'kometa' service using the 'latest' image tag
KOMETA_TAG="latest" docker-compose up -d
```

Feel free to adjust the values of these environment variables according to your specific requirements.

## Managing the Project with DSM Container Manager

To import the Duplex Docker Compose project into the DSM 7.2 Container Manager's Project feature, follow these steps:

1. SSH into your Synology system.

2. Clone this repository onto the system.

   ```bash
   git clone https://github.com/scottgigawatt/duplex.git
   ```

3. Open Container Manager and click on **Project**, then **Create**.

   <img width="747" alt="Screenshot 2024-05-07 at 00 15 07" src="https://github.com/scottgigawatt/duplex/assets/16313565/cccc73b3-0ca9-434b-ac77-753163cf8f50">

4. Click **Set Path** and browse to the cloned repository, then click **Select**.

5. Click **OK** on the popup window stating there is an existing `docker-compose.yml` in the selected path.

   <img width="485" alt="Screenshot 2024-05-07 at 00 16 11" src="https://github.com/scottgigawatt/duplex/assets/16313565/41433a35-e194-4882-9e4d-f70c4430bd70">

6. Give the project a title, e.g., **duplex**, and proceed through the UI prompts to create the project.

7. The project will be created, and you can see all of the project containers and information in one place.

   <img width="1202" alt="Screenshot 2024-05-07 at 00 18 49" src="https://github.com/scottgigawatt/duplex/assets/16313565/b328cb18-7b9b-408b-915c-bd854dd5b618">

See the official Synology documentation [here](https://kb.synology.com/en-id/DSM/help/ContainerManager/docker_project?version=7) for more information on Container Manager Projects.

## Accessing Synology Applications Securely

You can use the DSM 7 Reverse Proxy feature to configure secure access to your Synology applications. Follow the guide provided [here](https://mariushosting.com/synology-how-to-use-reverse-proxy-on-dsm-7/) to set up reverse proxy on DSM 7.

## Environment Details

The Duplex configuration has been tested on a Synology DS916+ running DSM 7.2.1-69057 Update 5, with Docker Compose version v2.9.0-6413-g38f6acd.

## License

This project is licensed under the Apache 2 License - see the [LICENSE](LICENSE) file for details.

---

Feel free to contribute or provide feedback to improve the Duplex repository. Happy Plexing!
