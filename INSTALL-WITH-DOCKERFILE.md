# Deploy using Dockerfile #
## Deploy using Dockerfile via Command Line ##
This is for those who can't (or don't want to) use the pre-built images from Dockerhub. For example you may have an architecture for which there is no image on Dockerhub
i. Build the image from the command line `docker build -t tesla_ble_mqtt:latest https://github.com/tesla-local-control/tesla_ble_mqtt_docker.git`. Note this can take some time on slower machines, e.g. 65mins+ on a RPi1b. The output will look something like this:
```
[+] Building 3977.9s (18/18) FINISHED                                                                                                       docker:default
 => CACHED [internal] load git source https://github.com/tesla-local-control/tesla_ble_mqtt_docker.git                                                3.5s
 => [internal] load metadata for docker.io/library/alpine:3.20.0                                                                                      1.7s
 => [internal] load metadata for docker.io/library/golang:1.22.4-alpine3.20                                                                           1.8s
 => [build 1/8] FROM docker.io/library/golang:1.22.4-alpine3.20@sha256:ace6cc3fe58d0c7b12303c57afe6d6724851152df55e08057b43990b927ad5e8             660.7s
 => => resolve docker.io/library/golang:1.22.4-alpine3.20@sha256:ace6cc3fe58d0c7b12303c57afe6d6724851152df55e08057b43990b927ad5e8                     0.6s
 => => sha256:ace6cc3fe58d0c7b12303c57afe6d6724851152df55e08057b43990b927ad5e8 10.29kB / 10.29kB                                                      0.0s
 => => sha256:dcc11b8cc70ef07dac6273dc695fcb3ab6e46da300ab939708f5ad1be4bd53d5 1.92kB / 1.92kB                                                        0.0s
 => => sha256:ae51de63cd1eed172ccfbf3b0617e64e41ac77842f79618b49518c0442c96685 2.09kB / 2.09kB                                                        0.0s
 => => sha256:3d2af5f613c84e549fb09710d45b152d3cdf48eb7a37dc3e9c01e2b3975f4f76 3.37MB / 3.37MB                                                       20.5s
 => => sha256:fb26f139748033dd9f410aaee2fa9f225bf8b64a17b5e3f1adf1ef26427ce27e 293.61kB / 293.61kB                                                   10.9s
 => => sha256:743e448a2b4bba38b1783fb849b3f5093e7931cf69d898520c4f1462ad93a836 67.71MB / 67.71MB                                                    235.0s
 => => extracting sha256:3d2af5f613c84e549fb09710d45b152d3cdf48eb7a37dc3e9c01e2b3975f4f76                                                            19.2s
 => => sha256:e17aa4a6c18860c6004fb2b335568db1f1bcfcd78962c48ca4fe9172dda6d304 127B / 127B                                                           30.4s
 => => sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1 32B / 32B                                                             31.0s
 => => extracting sha256:fb26f139748033dd9f410aaee2fa9f225bf8b64a17b5e3f1adf1ef26427ce27e                                                             9.1s
 => => extracting sha256:743e448a2b4bba38b1783fb849b3f5093e7931cf69d898520c4f1462ad93a836                                                           387.1s
 => => extracting sha256:e17aa4a6c18860c6004fb2b335568db1f1bcfcd78962c48ca4fe9172dda6d304                                                             0.1s
 => => extracting sha256:4f4fb700ef54461cfa02571ae0db9a0dc1e0cdb5577484a6d75e68dc38e8acc1                                                             0.0s
 => [stage-1 1/5] FROM docker.io/library/alpine:3.20.0@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd                       73.3s
 => => resolve docker.io/library/alpine:3.20.0@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd                                0.6s
 => => sha256:4a6ffef76277d8c1d912ad489e0c09ddc09fdf7aefae51750a33dc47478c0cc0 528B / 528B                                                            0.0s
 => => sha256:31d13e3b0449067f05eecde6a52c560b2edc027e8943f40968f3dcd1861e4614 1.49kB / 1.49kB                                                        0.0s
 => => sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd 1.85kB / 1.85kB                                                        0.0s
 => => sha256:b0da55d51ed2f4a2e9c4e3ca1e420bac26a1a37098e2f1437841049c51df7320 3.37MB / 3.37MB                                                       29.4s
 => => extracting sha256:b0da55d51ed2f4a2e9c4e3ca1e420bac26a1a37098e2f1437841049c51df7320                                                            35.3s
 => [build 4/8] ADD https://github.com/teslamotors/vehicle-command/archive/refs/heads/main.zip /tmp                                                  19.7s
 => [stage-1 2/5] RUN apk add --no-cache   bluez   bluez-deprecated   mosquitto-clients   openssl                                                   105.7s
 => [stage-1 3/5] RUN mkdir /data                                                                                                                    28.2s
 => [stage-1 4/5] COPY app liblog.sh libproduct.sh /app/                                                                                             14.4s
 => [build 2/8] RUN apk add --no-cache   unzip                                                                                                       28.2s
 => [build 3/8] RUN mkdir -p /app/bin                                                                                                                10.4s
 => [build 4/8] ADD https://github.com/teslamotors/vehicle-command/archive/refs/heads/main.zip /tmp                                                   4.0s
 => [build 5/8] RUN unzip /tmp/main.zip -d /app                                                                                                      15.5s
 => [build 6/8] WORKDIR /app/vehicle-command-main                                                                                                     2.5s
 => [build 7/8] RUN go get ./...                                                                                                                    174.8s
 => [build 8/8] RUN go build -o /app/bin ./...                                                                                                     3035.4s
 => [stage-1 5/5] COPY --from=build /app/bin/tesla-control /usr/bin/                                                                                  6.0s
 => exporting to image                                                                                                                               19.5s
 => => exporting layers                                                                                                                              19.2s
 => => writing image sha256:87b1c8676fba83a9903257dbc41e5a6bbd95339ca29eebe4da4aa4bf0aceb908                                                          0.0s
 => => naming to docker.io/library/tesla_ble_mqtt:latest  
```
ii. When completed, check it's there by issuing `docker images`. You will see somthing like this:
```
REPOSITORY                   TAG                 IMAGE ID       CREATED          SIZE
tesla_ble_mqtt               latest              8032d3fc0fb8   14 minutes ago   35.4MB
hello-world                  latest              f0c407f2ecb9   4 months ago     8.95kB
```
iii. Create a tesla_ble_mqtt_docker folder in your user directory and change directory into it:
   ```shell
   cd ~ 
   mkdir tesla_ble_mqtt_docker 
   cd tesla_ble_mqtt_docker
   ```
iv. Download docker-compose.yml and stack.env from the github repository:
   ```shell
   curl -O https://raw.githubusercontent.com/tesla-local-control/tesla_ble_mqtt_docker/main/docker-compose.yml
   curl -O https://raw.githubusercontent.com/tesla-local-control/tesla_ble_mqtt_docker/main/stack.env
   ```
v. You will need to edit docker-compose.yml. Change the line `image: "iainbullock/tesla_ble_mqtt:latest"` to `image: "tesla_ble_mqtt:latest"`
vi. Update the environment variables in stack.env according to your needs. As a minimum enter the VIN of your car, and the connection details for your MQTT server. If you want BLE detection enter the BLE MAC address of the car (see below for instructions on how to find this TODO):
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
vii. Create the Docker volume: `docker volume create tesla_ble_mqtt`
viii. Create a symbolic link to the environment file: `ln -s stack.env env`
ix. Start the container: `docker compose up -d`
x. Check the logs `docker logs -t tesla_ble_mqtt`. Typical logs after start up look like this (when DEBUG=false):
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

## Deploy using Dockerfile via Portainer ##
Again this is for those who can't (or don't want to) use the pre-built images from Dockerhub
TODO
