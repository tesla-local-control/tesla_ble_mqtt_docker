# Installation procedure

## Prerequisites

### Hardware
1. A Linux based computer which could be the same machine that runs Home Assistant (HA), or a seperate device located remotely from the HA machine, but close to where the car is located. We'll call this device the Host Device (HD). A Raspberry Pi makes an ideal HD
2. Bluetooth Low Energy (BLE) capabilities. This could be a plug in USB device or built-in to the HD. A strong BLE signal is required for reliable operation, so the HD should be located close to where the car is normally parked
3. An existing Linux OS installation which is already installed and operational on the HD. For a RPi this could be DietPi or Raspberry Pi OS. You will need to check that BLE (not just standard Bluetooth without BLE) is operational before proceeding

### Software
#### On the Host Device
1. A Linux distribution
2. docker. As an example for a Raspberry Pi OS 32-bit see these instructions https://docs.docker.com/engine/install/raspberry-pi-os/
3. docker-compose. Not required if using Portainer. If using Raspberry Pi OS use the following command to ensure you get the correct version: `sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose`
4. Optional: Portainer, useful if you prefer a GUI to manage your Docker setup. If you can put up with the ads, there's a good guide on installing Docker and Portainer here https://pimylifeup.com/raspberry-pi-portainer/

#### In Home Assistant
1. Mosquitto Add-on
2. MQTT Integration

## Installation

### Deploy the Container
There are various methods to deploy the container, I describe the main ones below:
#### Deploy using Command Line ####
1. Create a tesla_ble_mqtt_docker folder in your user directory and change directory into it:
   ```yaml
   cd ~ 
   mkdir tesla_ble_mqtt_docker 
   cd tesla_ble_mqtt_docker
   ```
2. Download docker-compose.yml and stack.env from the github repository:
   ```yaml
   wget https://raw.githubusercontent.com/tesla-local-control/tesla_ble_mqtt_docker/main/docker-compose.yml
   wget https://raw.githubusercontent.com/tesla-local-control/tesla_ble_mqtt_docker/main/stack.env
   ```
3. Check docker-compose.yml contents are suitable for your needs. It will be ok as is for most people
4. Update the environment variables in stack.env according to your needs. As a minimum enter the VIN of your car, and the connection details for your MQTT server. If you want BLE detection enter the BLE MAC address of the car (see below for instructions on how to find this TODO):
   ```yaml
   # Optional for car presence detection; If multiple cars, separate with , or | or white space
   #
   BLE_MAC_LIST=
   # Default 5 (seconds)
   #
   BLE_CMD_RETRY_DELAY=
   ### Default false
   #
   DEBUG=
   # Hostname or IP address
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
   # Default 120 (seconds)
   #
   PRESENCE_DETECTION_LOOP_DELAY=
   # Default 240 (seconds)
   #
   PRESENCE_DETECTION_TTL=
   # Mandatory; if multiple VINs separate with , or | or white space
   #
   VIN_LIST=
   # Your timezone
   # Ref: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
   #
   TZ='Europe/London'
   #
   # WARNING; If you run Home Assistant, keep this true unless you know what you're doing
   #
   ENABLE_HA_FEATURES=true
   ```
5. Create the Docker volume: `docker volume create tesla_ble_mqtt`
6. Create a symbolic link to the environment file: `ln -s stack.env env`
7. Start the container: `docker-compose up -d`
8. Check the logs `docker logs tesla_ble_mqtt`. Typical logs after start up look like this (when DEBUG=false):
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
#### Deploy using Portainer ####
TODO
#### Deploy using Dockerfile via Command Line ####
This is for those who can't (or don't want to) use the pre-built images from Dockerhub. For example you may have an architecture for which there is no image on Dockerhub
1. Build the image from the command line `docker build -t tesla_ble_mqtt:latest https://github.com/tesla-local-control/tesla_ble_mqtt_docker.git`. Note this can take some time on slower machines, e.g. 40mins+ on a RPi1b. The output will look something like this:
```
[+] Building 2818.9s (18/18) FINISHED                                                                                                       docker:default
 => [internal] load git source https://github.com/tesla-local-control/tesla_ble_mqtt_docker.git                                                      29.7s
 => [internal] load metadata for docker.io/library/golang:1.22.4-alpine3.20                                                                           0.1s
 => [internal] load metadata for docker.io/library/alpine:3.20.0                                                                                      0.0s
 => [build 1/8] FROM docker.io/library/golang:1.22.4-alpine3.20                                                                                       6.0s
 => CACHED [stage-1 1/5] FROM docker.io/library/alpine:3.20.0                                                                                         0.0s
 => [build 4/8] ADD https://github.com/teslamotors/vehicle-command/archive/refs/heads/main.zip /tmp                                                  18.4s
 => [stage-1 2/5] RUN apk add --no-cache openssl bluez mosquitto-clients                                                                            111.4s
 => [build 2/8] RUN apk add --no-cache   unzip                                                                                                       60.7s
 => [build 3/8] RUN mkdir -p /app/bin                                                                                                                44.2s
 => [build 4/8] ADD https://github.com/teslamotors/vehicle-command/archive/refs/heads/main.zip /tmp                                                   9.0s
 => [stage-1 3/5] RUN mkdir /data                                                                                                                    24.6s
 => [build 5/8] RUN unzip /tmp/main.zip -d /app                                                                                                      23.0s
 => [stage-1 4/5] COPY app /app                                                                                                                      11.8s
 => [build 6/8] WORKDIR /app/vehicle-command-main                                                                                                     5.6s
 => [build 7/8] RUN go get ./...                                                                                                                    162.6s
 => [build 8/8] RUN go build -o /app/bin ./...                                                                                                     2438.3s
 => [stage-1 5/5] COPY --from=build /app/bin/tesla-control /usr/bin/                                                                                 10.1s
 => exporting to image                                                                                                                               16.1s
 => => exporting layers                                                                                                                              15.8s
 => => writing image sha256:8032d3fc0fb818244a987ea0691df0c666527e6ac2dafade1604dc37a97998e5                                                          0.1s

 1 warning found (use --debug to expand):
 - FromAsCasing: 'as' and 'FROM' keywords' casing do not match (line 1)
```
2. When completed, check it's there by issuing `docker images`. You will see somthing like this:
```
REPOSITORY                   TAG                 IMAGE ID       CREATED          SIZE
tesla_ble_mqtt               latest              8032d3fc0fb8   14 minutes ago   34.1MB
golang                       1.22.4-alpine3.20   ae51de63cd1f   3 weeks ago      227MB
alpine                       3.20.0              31d13e3b0449   6 weeks ago      6.52MB
hello-world                  latest              f0c407f2ecb9   4 months ago     8.95kB
```
3. Follow steps 1 & 2 exactly as per 'Deploy using Command Line'
4. You will need to edit docker-compose.yml. Change the line `image: "iainbullock/tesla_ble_mqtt:latest"` to `image: "tesla_ble_mqtt:latest"`
5. Follow steps 4 to 8 exactly as per 'Deploy using Command Line'
#### Deploy using Dockerfile via Portainer ####
Again this is for those who can't (or don't want to) use the pre-built images from Dockerhub
TODO
### Activate the Key via Home Assistant
1. Go to the Integrations page in Home Assistant and click on the MQTT box.
2. One new device per vehicle should appear in the list: `Tesla_BLE_LRWXXXXXXXXXXX403`
3. Access the list of entities linked to the device by clicking on it.
4. Press the button `Generate Keys`
5. It is useful to monitor the logs during this process

### Add the Key to the Vehicle

> [!Important]
> The Host Device must be near the vehicle.

1. Get a vehicle key card.
2. Sit in the driver’s seat with your phone open to the Home Assistant page for the MQTT device. The vehicle screen should be active.
3. Press Deploy Key from the HA interface on your phone.
4. Immediately, place the key card on the central console as if to start the vehicle. A confirmation message will ask you to validate adding the key.
5. Rename the newly added Unknown Key to a recognizable name, like BLE Key.

### Test Sending Commands with the BLE Key
From the Home Assistant interface, test the available commands.
