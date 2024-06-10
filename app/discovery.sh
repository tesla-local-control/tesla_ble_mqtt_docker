#!/bin/bash

mqtt_ip=192.168.21.5
mqtt_port=1883
mqtt_user=hass
mqtt_pwd=grekshye

mosquitto_pub -h $mqtt_ip -p $mqtt_port -u $mqtt_user -P $mqtt_pwd -t homeassistant/button/tesla_ble/generate_keys/config -m \
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
  "unique_id": "tesla_ble_generate_keys"
 }' 

mosquitto_pub -h $mqtt_ip -p $mqtt_port -u $mqtt_user -P $mqtt_pwd -t homeassistant/button/tesla_ble/deploy_key/config -m \
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
  "name": "Deploy key",
  "payload_press": "deploy_key",
  "unique_id": "tesla_ble_deploy_key"
 }' 

mosquitto_pub -h $mqtt_ip -p $mqtt_port -u $mqtt_user -P $mqtt_pwd -t homeassistant/button/tesla_ble/open_trunk/config -m \
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
  "payload_press": "open_trunk",
  "unique_id": "tesla_ble_open_trunk"
 }' 

mosquitto_pub -h $mqtt_ip -p $mqtt_port -u $mqtt_user -P $mqtt_pwd -t homeassistant/button/tesla_ble/charging-start/config -m \
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
  "unique_id": "tesla_ble_charging-start"
 }' 

mosquitto_pub -h $mqtt_ip -p $mqtt_port -u $mqtt_user -P $mqtt_pwd -t homeassistant/button/tesla_ble/charging-stop/config -m \
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
  "unique_id": "tesla_ble_charging-stop"
 }' 

mosquitto_pub -h $mqtt_ip -p $mqtt_port -u $mqtt_user -P $mqtt_pwd -t homeassistant/number/tesla_ble/charging-set-amps/config -m \
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
  "name": "Charging Amps",
  "unique_id": "tesla_ble_charging-set-amps"
 }' 

