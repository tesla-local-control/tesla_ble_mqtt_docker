#!/bin/ash

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
  "unique_id": "tesla_ble_deploy_key"
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
  "unique_id": "tesla_ble_wake"
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
  "unique_id": "tesla_ble_trunk-close"
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
  "unique_id": "tesla_ble_charging-stop"
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
  "icon": "mdi:current-ac"
 }' 

