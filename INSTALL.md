# Installation procedure

## Prerequisites

### Hardware
- A Linux based computer which could be the same machine that runs Home Assistant (HA), or a seperate device located remotely from the HA machine, but close to where the car is located. We'll call this device the Host Device (HD). A Raspberry Pi makes an ideal HD
- Bluetooth Low Energy (BLE) capabilities. This could be a plug in USB device or built-in to the HD. A strong BLE signal is required for reliable operation, so the HD should be located close to where the car is normally parked
- An existing Linux OS installation which is already installed and operational on the HD. For a RPi this could be DietPi or Raspberry Pi OS. You will need to check that BLE (not just standard Bluetooth without BLE) is operational before proceeding

### Software
#### On the Host Device
- A Linux distribution
- Docker. As an example for a Raspberry Pi OS 32-bit see these instructions https://docs.docker.com/engine/install/raspberry-pi-os/
- Optional: Portainer, useful if you prefer a GUI to manage your Docker setup. If you can put up with the ads, there's a good guide on installing Docker and Portainer here https://pimylifeup.com/raspberry-pi-portainer/

#### In Home Assistant
- Mosquitto Add-on
- MQTT Integration

## Installation

### Deploy the Container
There are various methods to deploy the container, see the main ones below:
#### Deploy using Command Line ####
1. Create a tesla_ble_mqtt_docker folder in your user directory and change directory into it:
   ```shell
   cd ~ 
   mkdir tesla_ble_mqtt_docker 
   cd tesla_ble_mqtt_docker
   ```
2. Download docker-compose.yml and stack.env from the github repository:
   ```shell
   curl -O https://raw.githubusercontent.com/tesla-local-control/tesla_ble_mqtt_docker/main/docker-compose.yml
   curl -O https://raw.githubusercontent.com/tesla-local-control/tesla_ble_mqtt_docker/main/stack.env
   ```
3. Check docker-compose.yml contents are suitable for your needs. It will be ok as is for most people
4. Update the environment variables in stack.env according to your needs. As a minimum enter the VIN of your car, and the connection details for your MQTT server. If you want BLE detection enter the BLE MAC address of the car (see below for instructions on how to find this TODO):
  ```shell
  # Mandatory; if multiple VINs separate with , or white space
  #
  VIN_LIST=
  # Mandatory; Hostname or IP address
  #
  MQTT_SERVER=
  # Service port # or name
  #
  MQTT_PORT=1883
  # If no username provided, anonymous mode.
  #
  MQTT_USERNAME=
  # If you have special characters, wrap with ' at both ends; escape ' if needed
  #
  MQTT_PASSWORD=
  # Optional for car presence detection; If multiple cars, separate with , or white space
  #
 BLE_MAC_LIST=
  # Default 5 (seconds)
  #
  BLE_CMD_RETRY_DELAY=
  # Default 120 (seconds)
  #
  PRESENCE_DETECTION_LOOP_DELAY=
  # Default 240 (seconds)
  #
  PRESENCE_DETECTION_TTL=
  # Your timezone
  # Ref: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  #
  TZ='Europe/London'
  ### Default false
  #
  DEBUG=
  #
  # WARNING; If you run Home Assistant, keep this true unless you know what you're doing
  #
  ENABLE_HA_FEATURES=true
  ```
5. Create the Docker volume: `docker volume create tesla_ble_mqtt`
6. Create a symbolic link to the environment file: `ln -s stack.env env`
7. Start the container: `docker compose up -d`
8. Check the logs `docker logs -t tesla_ble_mqtt`. Typical logs after start up look like this (when DEBUG=false):
  ```
  Configuration Options are:
    BLE_CMD_RETRY_DELAY=5
    BLE_MAC_LIST=40:XX:XX:XX:XX:F9
    DEBUG=false
    MQTT_SERVER=192.168.1.5
    MQTT_PORT=1883
    MQTT_PASSWORD=Not Shown
    MQTT_USERNAME=XXXXXX
    PRESENCE_DETECTION_LOOP_DELAY=120
    PRESENCE_DETECTION_TTL=240
    VIN_LIST=LRWXXXXXXXXXXX403
    ENABLE_HA_FEATURES=true
  Setting up MQTT clients with authentication
  Presence detection is enable with a TTL of 240 seconds
  Setting up HA auto discovery for vin LRWXXXXXXXXXXX403
  Discarding any unread MQTT messages for LRWXXXXXXXXXXX403
  Listening for Home Assistant Start (in background)
  Entering main loop...
  Lauching background listen_to_mqtt_loop...
  Entering Listen to MQTT loop...
  Launch BLE scanning for car presence every 120 seconds
  Launching listen_to_mqtt
  ```
#### Deploy using Dockerfile #### 
See instructions here: INSTALL-WITH-DOCKERFILE.md
#### Deploy using Portainer ####
TODO
### Activate the Key via Home Assistant
- Go to the Integrations page in Home Assistant and click on the MQTT box.
- One new device per vehicle should appear in the list: `Tesla_BLE_LRWXXXXXXXXXXX403`
- Access the list of entities linked to the device by clicking on it.
- Press the button `Generate Keys`
- It is useful to monitor the logs during this process

### Add the Key to the Vehicle

> [!Important]
> The Host Device must be near the vehicle.

- Get a vehicle key card.
- Sit in the driver’s seat with your phone open to the Home Assistant page for the MQTT device. The vehicle screen should be active.
- Press Deploy Key from the HA interface on your phone.
- Immediately, place the key card on the central console as if to start the vehicle. A confirmation message will ask you to validate adding the key.
- Rename the newly added Unknown Key to a recognizable name, like BLE Key.

### Test Sending Commands with the BLE Key
From the Home Assistant interface, test the available commands.
