#!/bin/ash
set +e

echo "tesla_ble_mqtt_docker by Iain Bullock 2024 https://github.com/iainbullock/tesla_ble_mqtt_docker"
echo "Inspiration by Raphael Murray https://github.com/raphmur"
echo "Instructions by Shankar Kumarasamy https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3"

echo "Configuration Options are:"
echo TESLA_VIN=$TESLA_VIN
echo BLE_MAC=$BLE_MAC
echo MQTT_IP=$MQTT_IP
echo MQTT_PORT=$MQTT_PORT
echo MQTT_USER=$MQTT_USER
echo "MQTT_PWD=Not Shown"
echo SEND_CMD_RETRY_DELAY=$SEND_CMD_RETRY_DELAY

send_command() {
 for i in $(seq 5); do
  echo "Attempt $i/5"
#  tesla-control -ble -key-name private.pem -key-file private.pem $1
  if [ $? -eq 0 ]; then
    echo "Ok"
    break
  fi
  sleep $SEND_CMD_RETRY_DELAY
 done 
}

listen_to_ble() {
 echo "Listening to BLE"
 bluetoothctl --timeout 2 scan on | grep $BLE_MAC
 if [ $? -eq 0 ]; then
   echo "$BLE_MAC presence detected"
   mosquitto_pub --nodelay -h $MQTT_IP -p $MQTT_PORT -u "$MQTT_USER" -P "$MQTT_PWD" -t tesla_ble/binary_sensor/presence -m ON
 else
   echo "$BLE_MAC presence not detected"
   mosquitto_pub --nodelay -h $MQTT_IP -p $MQTT_PORT -u "$MQTT_USER" -P "$MQTT_PWD" -t tesla_ble/binary_sensor/presence -m OFF
 fi
}

. /app/discovery.sh
. /app/listen_to_mqtt.sh

echo "Setting up auto discovery for Home Assistant"
setup_auto_discovery 

echo "Discard any unread MQTT messages"
mosquitto_sub -E -i tesla_ble_mqtt -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t tesla_ble/+ 

echo "Entering listening loop"
while true
do
 listen_to_mqtt
 listen_to_ble
 sleep 2
done
