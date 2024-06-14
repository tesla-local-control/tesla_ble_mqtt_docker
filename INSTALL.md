# Installation procedure

## Prerequisites

### Hardware
1. A Raspberry Pi or similar SBC capable of running Linux, with Bluetooth antenna.
2. Micro SD card + SD adapter + necessary cables for OS installation (not detailed in this procedure).


> [!Important]
> In what follows, "RPi" refers to the device where the service will be executed.

### Software
#### On the RPi
1. A Linux distribution (DietPi used for this procedure). **Remember to enable Bluetooth in the settings!**
2. Docker
3. Docker-compose
4. Optional: Portainer, useful for viewing logs and other details.

#### In Home Assistant
1. Mosquitto Add-on
2. MQTT Integration

## Installation

### Deploy the Container
1. Connect to the RPi, via SSH for example.
2. 
    a. Clone the repo.

 **OR**

2.
    b. Create a `tesla_ble_mqtt_docker` folder in your user directory: `cd ~ && mkdir tesla_ble_mqtt_docker && cd $_.`

    Add a docker-compose.yml file: `nano docker-compose.yml`.
4. Adjust `docker-compose.yml` to your needs. Pay attention to the environment variables :
   ```yaml
   environment:
      - TZ='Europe/London'
      - TESLA_VIN =<tesla VIN> # Can be found in the App.
      - MQTT_IP=<IP of the MQTT broker> # In most cases the local IP of HA.
      - MQTT_PORT=1883 # 1883 is the default port, do not modify unless you specified another.
      - MQTT_USER=<MQTT username> # Use what's specified in the MQTT broker on HA.
      - MQTT_PWD=<MQTT password> # Use what's specified in the MQTT broker on HA.
   ```
6. Save and exit.
7. Create the Docker volume: `docker volume create tesla_ble_mqtt`
8. Start the container: `docker-compose up -d`

    Check the logs in Portainer (or other). They should look like this:
```
tesla_ble_mqtt_docker by Iain Bullock 2024 https://github.com/iainbullock/tesla_ble_mqtt_docker
Inspiration by Raphael Murray https://github.com/raphmur
Instructions by Shankar Kumarasamy https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3
Configuration Options are:
TESLA_VIN=****
MQTT_IP=192.168.1.51
MQTT_PORT=1883
MQTT_USER=****
MQTT_PWD=Not Shown
Setting up auto discovery for Home Assistant
Listening to MQTT
```

### Activate the Key via Home Assistant
1. Go to the Integrations page in Home Assistant and click on the MQTT box.
2. A new device should appear in the list: `tesla_ble_mqtt`
3. Access the list of entities linked to the device by clicking on it.
4. Press the button `Generate Keys`.
5. Optionally, check the logs in Portainer.

### Add the Key to the Vehicle

> [!Important]
> The RPi must be near the vehicle.

1. Get a vehicle key card.
2. Sit in the driver’s seat with your phone open to the Home Assistant page for the MQTT device. The vehicle screen should be active.
3. Press Deploy Key from the HA interface on your phone.
4. Immediately, place the key card on the central console as if to start the vehicle. A confirmation message will ask you to validate adding the key.
5. Rename the newly added Unknown Key to a recognizable name, like BLE Key.

### Test Sending Commands with the BLE Key
From the Home Assistant interface, test the available commands.
