# Duplex

Duplex simplifies Plex Media Server management on Synology NAS by providing a Docker Compose configuration with essential tools and utilities.

## Overview

This `docker-compose.yml` configures Docker containers for managing a Plex Media Server on a Synology NAS. It includes tools for metadata management, photo cleaning, monitoring, and automated updates.

## Included Tools

- **Kometa**: Manages Plex Media Server metadata. [Configuration details](https://github.com/scottgigawatt/kometa-config). [More info](https://kometa.wiki/en/nightly/)
- **ImageMaid**: Cleans Plex Media Server photos. [More info](https://kometa.wiki/en/nightly/kometa/scripts/imagemaid/)
- **PATTRMM**: Schedule and run media processing tasks. [GitHub](https://github.com/insertdisc/pattrmm)
- **Tautulli**: Monitors and tracks Plex Media Server usage. [GitHub](https://github.com/Tautulli/Tautulli/)
- **Notifiarr**: Provides notifications for various media server activities. [GitHub](https://github.com/Notifiarr/notifiarr/)
- **Watchtower**: Automatically updates Docker container base images. [GitHub](https://github.com/containrrr/watchtower)

## Docker Compose Configuration

Ensure your Docker Compose version is compatible with version 2.9.

### Services Configuration

> **Note**: Services will need to connect to Plex through the Docker bridge network. Use the gateway IP address of the bridge network assigned to each container to reach the Plex service running natively on the Synology NAS. You can find this IP by navigating to `Container Manager -> Network`.

#### Kometa

- **Image**: `kometateam/kometa:${KOMETA_TAG}`
- **Pull Policy**: Always
- **Container Name**: `kometa-${KOMETA_TAG}`
- **Restart Policy**: Unless stopped
- **Network Mode**: Bridge
- **Environment Variables**:
  - `KOMETA_DEBUG=${KOMETA_DEBUG}`
  - `TZ=${TZ}`
- **Volumes**:
  - `/volume1/docker/kometa-config:/config:rw`

#### ImageMaid

- **Image**: `kometateam/imagemaid:${IMAGE_MAID_TAG}`
- **Pull Policy**: Always
- **Container Name**: `imagemaid-${IMAGE_MAID_TAG}`
- **Restart Policy**: Unless stopped
- **Network Mode**: Bridge
- **Environment Variables**:
  - `TZ=${TZ}`
- **Volumes**:
  - `/volume1/docker/duplex/config/imagemaid:/config:rw`
  - `/volume1/PlexMediaServer/AppData/Plex Media Server:/plex:rw`

#### PATTRMM

- **Image**: `ghcr.io/insertdisc/pattrmm:${PATTRMM_TAG}`
- **Pull Policy**: Always
- **Container Name**: `pattrmm-${PATTRMM_TAG}`
- **Restart Policy**: Unless stopped
- **Network Mode**: Bridge
- **Environment Variables**:
  - `PATTRMM_TIME=${PATTRMM_TIME}`
  - `PUID=${PATTRMM_PUID}`
  - `GUID=${PATTRMM_PGID}`
  - `TZ=${TZ}`
- **Volumes**:
  - `${HOST_DOCKER_PATH}/duplex/config/pattrmm/data:/data:rw`
  - `${HOST_DOCKER_PATH}/duplex/config/pattrmm/preferences:/preferences:rw`
  - `${HOST_DOCKER_PATH}/kometa-config:/config:rw`

#### Tautulli

- **Image**: `tautulli/tautulli:${TAUTULLI_TAG}`
- **Pull Policy**: Always
- **Container Name**: `tautulli-${TAUTULLI_TAG}`
- **Restart Policy**: Unless stopped
- **Network Mode**: Bridge
- **Environment Variables**:
  - `PUID=${PUID}`
  - `PGID=${PGID}`
  - `TZ=${TZ}`
- **Ports**:
  - `8181:8181`
- **Volumes**:
  - `/volume1/docker/duplex/config/tautulli:/config:rw`

#### Notifiarr

- **Image**: `golift/notifiarr:${NOTIFIARR_TAG}`
- **Pull Policy**: Always
- **Container Name**: `notifiarr-${NOTIFIARR_TAG}`
- **Restart Policy**: Unless stopped
- **Network Mode**: Bridge
- **Hostname**: notifiarr
- **Ports**:
  - `5454:5454`
- **Volumes**:
  - `/volume1/docker/duplex/config/notifiarr:/config`
  - `/var/run/utmp:/var/run/utmp`
  - `/etc/machine-id:/etc/machine-id`
  - `/etc/localtime:/etc/localtime:ro`

#### Watchtower

- **Image**: `containrrr/watchtower:${WATCHTOWER_TAG}`
- **Pull Policy**: Always
- **Container Name**: `watchtower-${WATCHTOWER_TAG}`
- **Restart Policy**: Unless stopped
- **Network Mode**: Bridge
- **Environment Variables**:
  - `WATCHTOWER_POLL_INTERVAL=${WATCHTOWER_POLL_INTERVAL}`
  - `WATCHTOWER_CLEANUP=${WATCHTOWER_CLEANUP}`
- **Volumes**:
  - `/var/run/docker.sock:/var/run/docker.sock`
  - `/etc/localtime:/etc/localtime:ro`

## Usage

### Starting the Service Stack

Follow these steps to start the Duplex service stack:

1. Clone this repository to your Synology NAS.
2. Navigate to the directory containing the `docker-compose.yml` file.
3. Open a terminal or SSH into your Synology NAS.
4. Run `docker-compose up -d` to start the containers in detached mode.
5. Access the services through their respective endpoints.
6. Configure services to connect to Plex using the gateway IP address of the Docker bridge network. Find this IP in `Container Manager -> Network` for DSM 7.2 and above.

### Managing Docker Config Environment Variables

Manage Docker configuration environment variables in the `.env` file. Override these variables easily on the command line when starting the Docker Compose stack:

```bash
KOMETA_TAG="latest" docker-compose up -d
```

Adjust the values of these environment variables to your requirements.

### Managing the Project with DSM Container Manager

To import this project into DSM 7.2 Container Manager's Project feature:

1. SSH into your Synology system.
2. Clone this repository.
3. In Container Manager, click **Project** then **Create**.
4. Provide a title, e.g., **duplex**.
5. Set the path to the cloned repository.
6. Proceed through UI prompts to finish creating the project.

Refer to the official Synology documentation [here](https://kb.synology.com/en-id/DSM/help/ContainerManager/docker_project?version=7) for more on Container Manager Projects.

### Secure Access to Synology Applications

Use DSM 7 Reverse Proxy to configure secure access to Synology applications. Follow the guide [here](https://mariushosting.com/synology-how-to-use-reverse-proxy-on-dsm-7/) for DSM 7.

> **Note**: If you encounter "Socket closed" errors when accessing the DSM UI via reverse proxy and trying to open terminals for running containers, enable WebSocket for the reverse proxy record:
>
> 1. Go to `Control Panel -> Application Portal -> Reverse Proxy`.
> 2. Select `Edit` for your reverse proxy record.
> 3. Navigate to the `Custom Header` tab.
> 4. From the `Create` dropdown, select `WebSocket`.
> 5. Save the changes to resolve the issue.

## Environment Details

Tested on Synology DS916+ running DSM 7.2.1-69057 Update 5, with Docker Compose version v2.9.0-6413-g38f6acd.

## License

Licensed under the Apache 2 License - see [LICENSE](LICENSE) for details.

---

Contribute or provide feedback to improve the Duplex repository. Happy Plexing!
