# Tesla BLE MQTT Docker

Send commands via MQTT to a Tesla car using Bluetooth Low Energy (BLE).

# Read before

The advantage of the MQTT setup is that it can run on HA system or any device separate to your HA server, e.g. Raspberry Pi located close to where you park your car

**Prerequisite: Have an MQTT broker installed (in Home Assistant or other of your choice).**
If Home Assistant (HA) is already using the MQTT integration, then the various entities will be auto-discovered by HA.

# Two options to run this tool

## Standalone docker deployed on any machine you want

Good introduction: read this alongside Shankar's blog https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3
You should already have Docker working on the host device, and you are familiar with basic Docker concepts and actions

Then:
- Build the docker image using the Dockerfile. Alternatively you can get the image directly from Dockerhub https://hub.docker.com/r/iainbullock/tesla_ble_mqtt
- Make any required changes required to suit your setup in docker-compose.yml, in particular the environment variables will need changing according to your requirements
- Deploy the stack. View the container logs whilst working on the next steps, as this gives some feedback as to what is going on
- On your HA instance, navigate to the Integrations page, and click on the MQTT Integration tile. A new device called Tesla_BLE_MQTT should have automatically appeared. Click it to view the the associated entities. You should find a list of Button entities and a Number entity
- If this is the first time you have run the container, press the 'Generate Keys' button. This will generate the public and private keys as per Shankar's blog
- Wake up your car using the Tesla App. Then press the 'Deploy Key' button. This will deploy the public key to the car. You will then need to access your car and use a Key Card to accept the public key into the car (see the blog for screenshots)
- Press the other button entities to send various commands, or change the Charging Current. You can use the relevant service calls in HA automations if you wish

## Using as a Home Assistant addon

This repo is embedded in the Home Assistant [tesla-local-control-addon](https://github.com/tesla-local-control/tesla-local-control-addon) 
Please follow this link, or add the repo to your home assistant addon repos

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/tesla-local-control/tesla-local-control-addon)


# Credits

I got the idea for this from Raphael Murray as described here https://github.com/alandtse/tesla/issues/961#issuecomment-2150897886
The technical method was derived from Shankar Kumarasamy's blog https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3
