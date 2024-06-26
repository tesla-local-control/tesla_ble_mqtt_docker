#!/bin/ash

setup_auto_discovery() {
 echo "Setting up HA auto discovery for $1"

 if [ "$TESLA_VIN" ]; then
  # Deprecated topic / entity / device names	
  DEV_ID=tesla_ble
  DEV_NAME=Tesla_BLE_MQTT
 else	 
  DEV_ID=tesla_ble_mqtt_$1
  DEV_NAME=Tesla_BLE_MQTT_$1
 fi 

 TOPIC_ROOT=tesla_ble_mqtt/$1

 echo "DEV_ID=$DEV_ID"
 echo "DEV_NAME=$DEV_NAME"
 echo "TOPIC_ROOT=$TOPIC_ROOT"
 
 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/binary_sensor/${DEV_ID}/presence/config -m \
  '{
   "state_topic": "'${TOPIC_ROOT}'/binary_sensor/presence",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "device_class": "presence",
   "name": "Presence",
   "unique_id": "'${DEV_ID}'_presence"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/generate_keys/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/config",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "device_class": "update",
   "name": "Generate Keys",
   "payload_press": "generate_keys",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_generate_keys"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/deploy_key/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/config",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "device_class": "update",
   "name": "Deploy Key",
   "payload_press": "deploy_key",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_deploy_key"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/scan_bluetooth/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/config",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "device_class": "update",
   "name": "Scan Bluetooth",
   "payload_press": "scan_bluetooth",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_scan_bluetooth"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/wake/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Wake Car",
   "payload_press": "wake",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_wake"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/flash-lights/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Flash Lights",
   "payload_press": "flash-lights",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_flash_lights"
  }'

  mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/honk/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Honk",
   "payload_press": "honk",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_honk"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/lock/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Lock Car",
   "payload_press": "lock",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_lock"
  }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/unlock/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Unlock Car",
   "payload_press": "unlock",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_unlock"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/auto-seat-climate/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/auto-seat-and-climate",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Auto Seat & Climate",
   "payload_press": "auto-seat-and-climate",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_auto_seat-climate"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/climate-off/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Climate Off",
   "payload_press": "climate-off",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_climate-off"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/climate-on/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Climate On",
   "payload_press": "climate-on",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_climate-on"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/trunk-open/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Open Trunk",
   "payload_press": "trunk-open",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_trunk-open"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/trunk-close/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Close Trunk",
   "payload_press": "trunk-close",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_trunk-close"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/frunk-open/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Open Frunk",
   "payload_press": "frunk-open",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_frunk-open"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/charging-start/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Start Charging",
   "payload_press": "charging-start",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_charging-start"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/charging-stop/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Stop Charging",
   "payload_press": "charging-stop",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_charging-stop"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/charge-port-open/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Open Charge Port",
   "payload_press": "charge-port-open",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_charge-port-open"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/charge-port-close/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Close Charge Port",
   "payload_press": "charge-port-close",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_charge-port-close"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/windows-close/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Close Windows",
   "payload_press": "windows-close",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_windows-close"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/windows-vent/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/command",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Vent Windows",
   "payload_press": "windows-vent",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_windows-vent"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/number/${DEV_ID}/charging-set-amps/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/charging-amps",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Charging Current",
   "unique_id": "'${DEV_ID}'_charging-set-amps",
   "min": "0",
   "max": "48",
   "mode": "slider",
   "unit_of_measurement": "A",
   "qos": 1,
   "icon": "mdi:current-ac"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/number/${DEV_ID}/charging-set-limit/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/charging-set-limit",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Charging Limit",
   "unique_id": "'${DEV_ID}'_charging-set-limit",
   "min": "0",
   "max": "100",
   "mode": "slider",
   "unit_of_measurement": "%",
   "qos": 1,
   "icon": "mdi:battery-90"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/number/${DEV_ID}/climate-temp/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/climate-set-temp",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Climate Temp",
   "unique_id": "'${DEV_ID}'_climate-set-temp",
   "min": "5",
   "max": "40",
   "mode": "slider",
   "unit_of_measurement": "°C",
   "qos": 1,
   "icon": "mdi:temperature"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/switch/${DEV_ID}/sw-heater/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/sw-heater",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Steering Wheel Heater",
   "device_class": "switch",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_sw_heater"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/switch/${DEV_ID}/sentry-mode/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/sentry-mode",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Sentry Mode",
   "device_class": "switch",
   "qos": 1,
   "unique_id": "'${DEV_ID}'_sentry-mode"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/select/${DEV_ID}/heated_seat_left/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/heated_seat_left",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Heated Seat Left",
   "options": ["off", "low", "medium", "high"],
   "qos": 1,
   "icon": "mdi:car-seat-heater",
   "unique_id": "'${DEV_ID}'_heated_seat_left"
   }'

 mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/select/${DEV_ID}/heated_seat_right/config -m \
  '{
   "command_topic": "'${TOPIC_ROOT}'/heated_seat_right",
   "device": {
    "identifiers": [
    "'${DEV_ID}'"
    ],
    "manufacturer": "iainbullock",
    "model": "tesla_ble_mqtt",
    "name": "'${DEV_NAME}'"
   },
   "name": "Heated Seat Right",
   "options": ["off", "low", "medium", "high"],
   "qos": 1,
   "icon": "mdi:car-seat-heater",
   "unique_id": "'${DEV_ID}'_heated_seat_right"
   }'
   
# Entities which are seemingly not useful for BLE commands   
#  mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/ping/config -m \
#  '{
#   "command_topic": "'${TOPIC_ROOT}'/command",
#   "device": {
#    "identifiers": [
#    "'${DEV_ID}'"
#    ],
#    "manufacturer": "iainbullock",
#    "model": "tesla_ble_mqtt",
#    "name": "'${DEV_NAME}'"
#   },
#   "name": "Ping",
#   "payload_press": "ping",
#   "enabled_by_default": 0,
#   "qos": 1,
#   "unique_id": "'${DEV_ID}'_ping"
#  }'
#
#  mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/product-info/config -m \
#  '{
#   "command_topic": "'${TOPIC_ROOT}'/command",
#   "device": {
#    "identifiers": [
#    "'${DEV_ID}'"
#    ],
#    "manufacturer": "iainbullock",
#    "model": "tesla_ble_mqtt",
#    "name": "'${DEV_NAME}'"
#   },
#   "name": "Product Info",
#   "payload_press": "product-info",
#   "qos": 1,
#   "enabled_by_default": 0,
#   "unique_id": "'${DEV_ID}'_product-info"
#   }'
#
# mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/${DEV_ID}/session-info/config -m \
#  '{
#   "command_topic": "'${TOPIC_ROOT}'/command",
#   "device": {
#    "identifiers": [
#    "'${DEV_ID}'"
#    ],
#    "manufacturer": "iainbullock",
#    "model": "tesla_ble_mqtt",
#    "name": "'${DEV_NAME}'"
#   },
#   "name": "Session Info",
#   "payload_press": "session-info",
#   "qos": 1,
#   "enabled_by_default": 0,
#   "unique_id": "'${DEV_ID}'_session-info"
#   }'
# 
 }

