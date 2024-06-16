#!/bin/ash
set +r

setup_auto_discovery() {

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/binary_sensor/tesla_ble/presence/config -m \
  '{
   "state_topic": "tesla_ble/binary_sensor/presence",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "device_class": "presence",
   "name": "Presence",
   "unique_id": "tesla_ble_presence"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/generate_keys/config -m \
  '{
   "command_topic": "tesla_ble/config",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "device_class": "update",
   "name": "Generate Keys",
   "payload_press": "generate_keys",
   "qos": 1,
   "unique_id": "tesla_ble_generate_keys"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/deploy_key/config -m \
  '{
   "command_topic": "tesla_ble/config",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "device_class": "update",
   "name": "Deploy Key",
   "payload_press": "deploy_key",
   "qos": 1,
   "unique_id": "tesla_ble_deploy_key"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/scan_bluetooth/config -m \
  '{
   "command_topic": "tesla_ble/config",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "device_class": "update",
   "name": "Scan Bluetooth",
   "payload_press": "scan_bluetooth",
   "qos": 1,
   "unique_id": "tesla_ble_scan_bluetooth"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/wake/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Wake Car",
   "payload_press": "wake",
   "qos": 1,
   "unique_id": "tesla_ble_wake"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/flash-lights/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Flash Lights",
   "payload_press": "flash-lights",
   "qos": 1,
   "unique_id": "tesla_ble_flash_lights"
  }'

  mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/ping/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Ping",
   "payload_press": "ping",
   "enabled_by_default": 0,
   "qos": 1,
   "unique_id": "tesla_ble_ping"
  }'

  mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/honk/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Honk",
   "payload_press": "honk",
   "qos": 1,
   "unique_id": "tesla_ble_honk"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/lock/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Lock Car",
   "payload_press": "lock",
   "qos": 1,
   "unique_id": "tesla_ble_lock"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/unlock/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Unlock Car",
   "payload_press": "unlock",
   "qos": 1,
   "unique_id": "tesla_ble_unlock"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/auto-seat-climate/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Auto Seat & Climate",
   "payload_press": "auto-seat-and-climate",
   "qos": 1,
   "unique_id": "tesla_ble_auto_seat-climate"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/climate-off/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Climate Off",
   "payload_press": "climate-off",
   "qos": 1,
   "unique_id": "tesla_ble_climate-off"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/climate-on/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Climate On",
   "payload_press": "climate-on",
   "qos": 1,
   "unique_id": "tesla_ble_climate-on"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/trunk-open/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Open Trunk",
   "payload_press": "trunk-open",
   "qos": 1,
   "unique_id": "tesla_ble_trunk-open"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/trunk-close/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Close Trunk",
   "payload_press": "trunk-close",
   "qos": 1,
   "unique_id": "tesla_ble_trunk-close"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/frunk-open/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Open Frunk",
   "payload_press": "frunk-open",
   "qos": 1,
   "unique_id": "tesla_ble_frunk-open"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/charging-start/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Start Charging",
   "payload_press": "charging-start",
   "qos": 1,
   "unique_id": "tesla_ble_charging-start"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/charging-stop/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Stop Charging",
   "payload_press": "charging-stop",
   "qos": 1,
   "unique_id": "tesla_ble_charging-stop"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/charge-port-open/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Open Charge Port",
   "payload_press": "charge-port-open",
   "qos": 1,
   "unique_id": "tesla_ble_charge-port-open"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/charge-port-close/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Close Charge Port",
   "payload_press": "charge-port-close",
   "qos": 1,
   "unique_id": "tesla_ble_charge-port-close"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/windows-close/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Close Windows",
   "payload_press": "windows-close",
   "qos": 1,
   "unique_id": "tesla_ble_windows-close"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/windows-vent/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Vent Windows",
   "payload_press": "windows-vent",
   "qos": 1,
   "unique_id": "tesla_ble_windows-vent"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/product-info/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Product Info",
   "payload_press": "product-info",
   "qos": 1,
   "enabled_by_default": 0,
   "unique_id": "tesla_ble_product-info"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/button/tesla_ble/session-info/config -m \
  '{
   "command_topic": "tesla_ble/command",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Session Info",
   "payload_press": "session-info",
   "qos": 1,
   "enabled_by_default": 0,
   "unique_id": "tesla_ble_session-info"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/number/tesla_ble/charging-set-amps/config -m \
  '{
   "command_topic": "tesla_ble/charging-amps",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Charging Current",
   "unique_id": "tesla_ble_charging-set-amps",
   "min": "0",
   "max": "48",
   "mode": "slider",
   "unit_of_measurement": "A",
   "qos": 1,
   "icon": "mdi:current-ac"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/number/tesla_ble/charging-set-limit/config -m \
  '{
   "command_topic": "tesla_ble/charging-set-limit",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Charging Limit",
   "unique_id": "tesla_ble_charging-set-limit",
   "min": "0",
   "max": "100",
   "mode": "slider",
   "unit_of_measurement": "%",
   "qos": 1,
   "icon": "mdi:battery-90"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/number/tesla_ble/climate-temp/config -m \
  '{
   "command_topic": "tesla_ble/climate-set-temp",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Climate Temp",
   "unique_id": "tesla_ble_climate-set-temp",
   "min": "5",
   "max": "40",
   "mode": "slider",
   "unit_of_measurement": "°C",
   "qos": 1,
   "icon": "mdi:temperature"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/number/tesla_ble/seat-heater/config -m \
  '{
   "command_topic": "tesla_ble/seat-heater",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Seat Heater",
   "unique_id": "tesla_ble_seat-heater",
   "min": "0",
   "max": "3",
   "mode": "slider",
   "qos": 1,
   "icon": "mdi:temperature"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/switch/tesla_ble/sw-heater/config -m \
  '{
   "command_topic": "tesla_ble/sw-heater",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Steering Wheel Heater",
   "device_class": "switch",
   "qos": 1,
   "unique_id": "tesla_ble_sw_heater"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t homeassistant/switch/tesla_ble/sentry-mode/config -m \
  '{
   "command_topic": "tesla_ble/sentry-mode",
   "device": {
    "identifiers": [
    "tesla_ble_mqtt"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "Tesla_BLE_MQTT"
   },
   "name": "Sentry Mode",
   "device_class": "switch",
   "qos": 1,
   "unique_id": "tesla_ble_sentry-mode"
   }'

 }

