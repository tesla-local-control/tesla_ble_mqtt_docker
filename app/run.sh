#!/bin/ash
set -e

echo "------------------------------------------------------------------------------------------------------------------------------"
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

#TESLA_VIN=$TESLA_VIN1

echo "Configuration Options are:"
if [ "$TESLA_VIN" ]; then
 echo TESLA_VIN=$TESLA_VIN
 echo " Use of TESLA_VIN is deprecated. Please migrate to using TESLA_VIN1, TESLA_VIN2, TESLA_VIN3 instead"
 echo " Home Assistant entities associated with TESLA_VIN will be renamed upon migration"
 echo " Upon migration you will need to manually update references to these entities if used in cards or automations"
 echo " Support for TESLA_VIN may be dropped in future releases"
else
 echo TESLA_VIN1=$TESLA_VIN1
 echo TESLA_VIN2=$TESLA_VIN2
 echo TESLA_VIN3=$TESLA_VIN3
fi
echo BLE_MAC=$BLE_MAC
echo MQTT_IP=$MQTT_IP
echo MQTT_PORT=$MQTT_PORT
echo MQTT_USER=${MQTT_USER}
echo "MQTT_PWD=Not Shown"
echo SEND_CMD_RETRY_DELAY=$SEND_CMD_RETRY_DELAY

echo "Include subroutines"
. /app/subroutines.sh
. /app/discovery.sh
. /app/listen_to_mqtt.sh

if [ ! -d /share/tesla_ble_mqtt ]; then
 mkdir /share/tesla_ble_mqtt
else
 echo "/share/tesla_ble_mqtt already exists, existing BLE keys can be reused"
fi

if [ -f /share/tesla_ble_mqtt/private.pem ]; then
 echo "Keys exist from a previous installation made using TESLA_VIN which is deprecated"
 echo "Please migrate to use TESLA_VIN1, TESLA_VIN2, TESLA_VIN3 instead"
  if [ ! "$TESLA_VIN" ] && [ $TESLA_VIN1 != "00000000000000000" ]; then
   echo "Legacy keys, MQTT topics, and Home Assistant entity names will now be migrated"
   echo "Upon migration you will need to manually update references to these entities in HA if used in cards or automations"
    delete_legacies
  fi 
fi

echo "Setting up auto discovery for Home Assistant"
if [ "$TESLA_VIN" ]; then
 setup_auto_discovery $TESLA_VIN
else
 if [ "$TESLA_VIN1" ] && [ $TESLA_VIN1 != "00000000000000000" ]; then
  setup_auto_discovery $TESLA_VIN1
 fi 
 if [ "$TESLA_VIN2" ] && [ $TESLA_VIN2 != "00000000000000000" ]; then
  setup_auto_discovery $TESLA_VIN2
 fi
 if [ "$TESLA_VIN3" ] && [ $TESLA_VIN3 != "00000000000000000" ]; then
  setup_auto_discovery $TESLA_VIN3
 fi
fi

echo "Listening for Home Assistant Start (in background)"
listen_for_HA_start &

echo "Discarding any unread MQTT messages"
if [ "$TESLA_VIN" ]; then
 mosquitto_sub -E -i tesla_ble_mqtt -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble/$TESLA_VIN/+ 
else
 mosquitto_sub -E -i tesla_ble_mqtt -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble_mqtt/$TESLA_VIN1/+ 
 mosquitto_sub -E -i tesla_ble_mqtt -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble_mqtt/$TESLA_VIN2/+ 
 mosquitto_sub -E -i tesla_ble_mqtt -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble_mqtt/$TESLA_VIN3/+ 
fi

echo "Entering listening loop"
while true
do
 listen_to_mqtt
# listen_to_ble
 sleep 2
done
