# Tesla BLE MQTT Docker

 **Major release v0.5.0 that improves Bluetooth stability and allows for periodically getting your car's state information (sensors and other entities). Whilst the car is at home, there is now no need for FleetAPI!**

Send commands and read state via MQTT for a Tesla car using Bluetooth Low Energy (BLE). BLE bypasses the current Fleet API rate limitation and does not rely on the API.
The MQTT setup can run on your Home Assistant (HA) system or any device separate from your HA server, e.g. Raspberry Pi located close to where you park your car

**Prerequisite: Have an MQTT broker installed (in Home Assistant or other of your choice).**
If Home Assistant is already using the MQTT integration, then the various entities will be auto-discovered by HA.

## Hardware
Bluetooth communication is done using the Tesla vehicle-command project https://github.com/teslamotors/vehicle-command. The reliablity of this is dependent upon the type of hardware used and distance it is located from the car. Successful installations have been achieved on various hardware including Raspberry Pi 3 and above with built in bluetooth. Maximum recommended distance is 3 metres in clear line of sight of the car.

## Note regarding polling / reading of state
The v0.3.x releases didn't poll to read state. You (or more likely a HA automation) needed to press the 'Force Data Update' button to read / update the state. From v0.4.3, the option of automatic polling of state is added. Note the following:
 - Two new entities have been added to control polling. The Polling switch enables or disables polling completely for the selected car. The Polling Interval number determines in seconds how often (approximately) polling takes place. The minimum setting is 30 secs, maximum is 3600 secs. Values MUST be a multiple of 30. I recommend setting this to a minimum value of 660 to prevent the car staying awake and draining the battery due to excessive polling. If the car is charging it can be reduced as required. Intervals less than 60 (for a single car setup) are not recommended if polling all state categories as all entities may not be returned before the next poll starts, which will eventually lead to the system breaking
 - It is possible to exclude selected state categories (i.e. charge, climate, tire-pressure, closures, drive) from the polling sequence. This speeds up the poll, thereby allowing lower values of polling interval to be reliably selected. To exclude categories from the poll, include the category name in a space separated list of names in the Docker environment variable NO_POLL_SECTIONS. E.g. to only poll the charge category you would set NO_POLL_SECTIONS='climate tire-pressure closures drive'
 - <ins>**The poll will only take place if the car is awake**</ins> at the moment the poll is attempted. It will not wake the car if it is asleep to prevent battery drain issues. Once the car is asleep you will have to wake it if you want polling to recommence. You can wake the car by turning on charging power, or sending a command for example. If the polling interval is 660 or greater, the car  will likely be asleep by the time the next poll comes around (in 11 minutes). Whilst the implementation used here is not identical, the principle is described well here https://github.com/alandtse/tesla/wiki/Polling-policy
 - Several Force Update button entities have been added. 'Force Update All' wakes the car and updates all the entities. There are also individual Force Update buttons for each of the state categories. These wake the car and update just that category. Note these buttons do not respect the NO_POLL_SECTIONS environment variable. Finally, there is a button called 'Force Update Env', which is like 'Force Update All', but it does respect the NO_POLL_SECTIONS environment variable
 - On first installation you will need to set the Polling Switch and Polling Interval Number entities for each car to your requirements. After first installation, the settings will be remembered as they are stored on the MQTT server (with retain flag set), even following updates to the Docker container etc.
 - The environment variable $IMMEDIATE_UPDATE enables or disables the automatic updating of state_topics after a command to change a value has been sent. If this is set to true (default), then after a command has been successfully sent to the car, the state_topic for the relevant entity is automatically and immediately updated. If set to false, this doesn't happen automatically, the state_topic is updated at the next polling occurence or a force update button press

## Two options to run this tool:

### 1 - Tesla BLE MQTT Docker

This is a Docker container which can be deployed on any machine you want. See [INSTALL.md](https://github.com/tesla-local-control/tesla_ble_mqtt_docker/blob/main/INSTALL.md) for instructions

### 2 - Tesla Local Control Add-on

This is a Home Assistant Add-On installed on your HA instance. Go to this associated repository: [tesla-local-control-addon](https://github.com/tesla-local-control/tesla-local-control-addon)

## Updating to a new version, or using the Development version
See [UPDATING.md](UPDATING.md)

