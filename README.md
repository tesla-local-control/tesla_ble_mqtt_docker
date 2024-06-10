# Tesla BLE MQTT Docker

Send commands via MQTT to a Tesla car using Bluetooth Low Energy (BLE)

If Home Assistant (HA) is already using the MQTT integration, then the various entities will be auto-discovered by HA

The advantage of the MQTT setup is that it can run on a device separate to your HA server, e.g. Raspberry Pi located close to where you park your car 

<a href="https://www.buymeacoffee.com/iainbullock" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

## Contributions
I'm seeing a lot of interest already. Please submit PRs against the dev branch

## Installation and setup
TODO, but here's a start. Read this alongside Shankar's blog https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3

- You must already have a working MQTT broker. If you want the entities to be auto-discovered by Home Assistant (HA), then the HA MQTT Integration must already be set up and working. It is out of scope of this project to support the setup of this; it is well documented elsewhere

- I also assume you already have Docker working on the host device, and you are familiar with basic Docker concepts and actions

- Build the docker image using the Dockerfile. Alternatively you can get the image directly from Dockerhub [https://hub.docker.com/r/iainbullock/tesla_http_prox](https://hub.docker.com/r/iainbullock/tesla_ble_mqtt)

- Make any required changes required to suit your setup in docker-compose.yml, in particular the environment variables will need changing according to your requirements

- Deploy the stack. View the container logs whilst working on the next steps, as this gives some feedback as to what is going on

- On your HA instance, navigate to the Integrations page, and click on the MQTT Integration tile. A new device called Tesla_BLE_MQTT should have automatically appeared. Click it to view the the associated entities. You should find a list of Button entities and a Number entity

- If this is the first time you have run the container, press the 'Generate Keys' button. This will generate the public and private keys as per Shanker's blog

- Wake up your car using the Tesla App. Then press the 'Deploy Key' button. This will deploy the public key to the car. You will then need to access your car and use a Key Card to accept the public key into the car (see the blog for screenshots)

- Press the other button entities to send various commands, or change the Charging Current. You can use the relevant service calls in HA automations if you wish

- Note the car has to be awake for this to work, I can't get it to wake via BLE. You must either use the Tesla App, the Tesla HA Integration, or turn on charging power to wake the car

## Credits

I got the idea for this from Raphael Murray as described here https://github.com/alandtse/tesla/issues/961#issuecomment-2150897886 

The technical method was derived from Shankar Kumarasamy's blog https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3

