#!/bin/ash
set -e

echo "tesla_ble_mqtt_docker by Iain Bullock 2024 https://github.com/iainbullock/tesla_ble_mqtt_docker"
echo "Inspiration by Raphael Murray https://github.com/raphmur"
echo "Instructions by Shankar Kumarasamy https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3"

# read options in case of HA addon. Otherwise, they will be sent as environment variables
if [ -n "${HASSIO_TOKEN:-}" ]; then
  TESLA_VIN="$(bashio::config 'vin')"; export TESLA_VIN
  BLE_MAC="$(bashio::config 'ble_mac')"; export BLE_MAC
  MQTT_IP="$(bashio::config 'mqtt_ip')"; export MQTT_IP
  MQTT_PORT="$(bashio::config 'mqtt_port')"; export MQTT_PORT
  MQTT_USER="$(bashio::config 'mqtt_user')"; export MQTT_USER
  MQTT_PWD="$(bashio::config 'mqtt_pwd')"; export MQTT_PWD
  SEND_CMD_RETRY_DELAY="$(bashio::config 'send_cmd_retry_delay')"; export SEND_CMD_RETRY_DELAY
fi

echo "Configuration Options are:"
echo TESLA_VIN=$TESLA_VIN
echo BLE_MAC=$BLE_MAC
echo MQTT_IP=$MQTT_IP
echo MQTT_PORT=$MQTT_PORT
echo MQTT_USER=${MQTT_USER}
echo "MQTT_PWD=Not Shown"
echo SEND_CMD_RETRY_DELAY=$SEND_CMD_RETRY_DELAY

if [ ! -d /share/tesla_ble_mqtt ]
then
    mkdir /share/tesla_ble_mqtt
else
    echo "/share/tesla_ble_mqtt already exists, existing keys can be reused"
fi

echo "Include subroutines"
. /app/subroutines.sh
. /app/discovery.sh
. /app/listen_to_mqtt.sh

echo "Listening for Home Assistant Start (in background)"
listen_for_HA_start &

echo "Setting up auto discovery for Home Assistant"
setup_auto_discovery 

echo "Discard any unread MQTT messages"
mosquitto_sub -E -i STESLA_VIN -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble/+ 

echo "Entering listening loop"
while true
do
 listen_to_mqtt
 listen_to_ble
 sleep 2
done
