# Tesla BLE MQTT Docker

Send commands via MQTT to a Tesla car using Bluetooth Low Energy (BLE). BLE bypasses the current Fleet API rate limitation and does not rely on the API.
The MQTT setup can run on your Home Assistant (HA) system or any device separate from your HA server, e.g. Raspberry Pi located close to where you park your car

**Prerequisite: Have an MQTT broker installed (in Home Assistant or other of your choice).**
If Home Assistant is already using the MQTT integration, then the various entities will be auto-discovered by HA.

## Two options to run this tool:

### 1 - Tesla BLE MQTT Docker

This is a Docker container which can be deployed on any machine you want. See [INSTALL.md](https://github.com/tesla-local-control/tesla_ble_mqtt_docker/blob/main/INSTALL.md) for instructions

### 2 - Tesla Local Control Add-on

This is a Home Assistant Add-On installed on your HA instance. Go to this associated repository: [tesla-local-control-addon](https://github.com/tesla-local-control/tesla-local-control-addon)
