#!/bin/ash

send_command() {
 for i in $(seq 5); do
  echo "Sending command $@, attempt $i/5"
  set +e
  tesla-control -ble -key-name /share/tesla_ble_mqtt/private.pem -key-file /share/tesla_ble_mqtt/private.pem $@
  EXIT_STATUS=$?
  set -e
  if [ $EXIT_STATUS -eq 0 ]; then
    echo "Ok"
    break
  else
   echo "Error calling tesla-control, exit code=$EXIT_STATUS - will retry in $SEND_CMD_RETRY_DELAY seconds"
   sleep $SEND_CMD_RETRY_DELAY
  fi  
 done 
}

listen_to_ble() {
 echo "Listening to BLE"
 set +e
 bluetoothctl --timeout 2 scan on | grep $BLE_MAC
 EXIT_STATUS=$?
 set -e
 if [ $EXIT_STATUS -eq 0 ]; then
   echo "$BLE_MAC presence detected"
   mosquitto_pub --nodelay -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble/binary_sensor/presence -m ON
 else
   echo "$BLE_MAC presence not detected"
   mosquitto_pub --nodelay -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble/binary_sensor/presence -m OFF
 fi
}

send_key() {
 for i in $(seq 5); do
  echo "Attempt $i/5"
  set +e
  tesla-control -ble -vin $TESLA_VIN add-key-request /share/tesla_ble_mqtt/public.pem owner cloud_key
  EXIT_STATUS=$?
  set -e
  if [ $EXIT_STATUS -eq 0 ]; then
    echo "KEY SENT TO VEHICLE: PLEASE CHECK YOU TESLA'S SCREEN AND ACCEPT WITH YOUR CARD"
    break
  else
    echo "COULD NOT SEND THE KEY. Is the car awake and sufficiently close to the bluetooth device?"
    sleep $SEND_CMD_RETRY_DELAY
  fi
 done
}
