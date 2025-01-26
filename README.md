# Tesla BLE MQTT Docker

### Update: it is now possible to read state as well as send commands using Bluetooth
### Update 2 (dev branch): polling of state is now possible

Send commands and read state via MQTT for a Tesla car using Bluetooth Low Energy (BLE). BLE bypasses the current Fleet API rate limitation and does not rely on the API.
The MQTT setup can run on your Home Assistant (HA) system or any device separate from your HA server, e.g. Raspberry Pi located close to where you park your car

**Prerequisite: Have an MQTT broker installed (in Home Assistant or other of your choice).**
If Home Assistant is already using the MQTT integration, then the various entities will be auto-discovered by HA.

### Note regarding polling / reading of state
The original production release didn't poll to read state. You (or more likely a HA automation) needed to press the 'Force Data Update' button to read / update the state. This development version adds the option of automatic polling of state. Note the following:
 - It is a DEVELOPMENT version so will have more issues than the production version. It might not even work at all. I put it here for people to test and give feedback, in order to improve it to the state where it can become a production release
 - Two new entities have been added to control polling. The Polling switch enables or disables polling completely for the selected car. The Polling Interval number determines in seconds how often (approximately) polling takes place. The minimum setting is 30 secs, maximum is 3600 secs. Values MUST be a multiple of 30. I recommend setting this to a minimum value of 660 to prevent the car staying awake and draining the battery due to excessive polling. If the car is charging it can be reduced as required. Intervals less than 60 (for a single car setup) are not recommended if polling all state categories as all entities may not be returned before the next poll starts, which will eventually lead to the system breaking
 - It is possible to exclude selected state categories (i.e. charge, climate, tire-pressure, closures, drive) from the polling sequence. This speeds up the poll, thereby allowing lower values of polling interval to be reliably selected. To exclude categories from the poll, include the category name in a space separated list of names in the Docker environment variable NO_POLL_SECTIONS. E.g. to only poll the charge category you would set NO_POLL_SECTIONS='climate tire-pressure closures drive'
 - The poll will only take place if the car is awake at the moment the poll is attempted. It will not wake the car if it is asleep to prevent battery drain issues. Once the car is asleep you will have to wake it if you want polling to recommence. You can wake the car by turning on charging power, or sending a command for example. If the polling interval is 660 or greater, the car  will likely be asleep by the time the next poll comes around (in 11 minutes). Whilst the implementation used here is not identical, the principle is described well here https://github.com/alandtse/tesla/wiki/Polling-policy
 - Additional Force Update button entities have been added. 'Force Update All' does what the previously named 'Force Date Update' button did, i.e. wakes the car and updates all the entities. There are now individual Force Update buttons for each of the state categories. These wake the car and update just that category. Note these buttons do not respect the NO_POLL_SECTIONS environment variable. Finally, there is a button called 'Force Update Env', which is like 'Force Update All', but it does respect the NO_POLL_SECTIONS environment variable
 - On first installation you will need to set the Polling Switch and Polling Interval Number entities for each car to your requirements. After first installation, the settings will be remembered as they are stored on the MQTT server (with retain flag set), even following updates to the Docker container etc.
 - May not implement. The environment variable $OPTIMISTIC_MODE enables or disables MQTT optimistic mode (see https://github.com/tesla-local-control/tesla_ble_mqtt_docker/issues/82). When true, entities will immediately change state after a command is sent from HA (even if the command ultimately fails). If false (default), the entity will wait for state confirmation via polling or a force update button press
 - The environment variable $IMMEDIATE_UPDATE enables or disables the automatic updating of state_topics after a command to change a value has been sent. If this is set to true (default), then after a command has been successfully sent to the car, the state_topic for the relevant entity is automatically and immediately updated. If set to false, this doesn't happen automatically, the state_topic is updated at the next polling occurence or a force update button press

## Two options to run this tool:

### 1 - Tesla BLE MQTT Docker

This is a Docker container which can be deployed on any machine you want. See [INSTALL.md](https://github.com/tesla-local-control/tesla_ble_mqtt_docker/blob/main/INSTALL.md) for instructions

### 2 - Tesla Local Control Add-on

This is a Home Assistant Add-On installed on your HA instance. Go to this associated repository: [tesla-local-control-addon](https://github.com/tesla-local-control/tesla-local-control-addon)
