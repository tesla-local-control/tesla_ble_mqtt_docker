#!/bin/ash

send_command() {
 vin=$1
 shift 
 for i in $(seq 5); do
  echo "Sending command $@ to $vin, attempt $i/5"
  set +e
  tesla-control -vin $vin -ble -key-name /share/tesla_ble_mqtt/${vin}_private.pem -key-file /share/tesla_ble_mqtt/${vin}_private.pem $@
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
 echo "Needs updating for multi-car, only supports TESLA_VIN1 at this time. Doesn't support deprecated TESLA_VIN usage"
 set +e
 bluetoothctl --timeout 2 scan on | grep $BLE_MAC
 EXIT_STATUS=$?
 set -e
 if [ $EXIT_STATUS -eq 0 ]; then
   echo "$BLE_MAC presence detected"
   mosquitto_pub --nodelay -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble_mqtt/$TESLA_VIN1/binary_sensor/presence -m ON
 else
   echo "$BLE_MAC presence not detected"
   mosquitto_pub --nodelay -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble_mqtt/$TESLA_VIN1/binary_sensor/presence -m OFF
 fi
}

send_key() {
 for i in $(seq 5); do
  echo "Attempt $i/5"
  set +e
  tesla-control -ble -vin $1 add-key-request /share/tesla_ble_mqtt/$1_public.pem owner cloud_key
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

scan_bluetooth(){
 VIN_HASH=`echo -n ${TESLA_VIN} | sha1sum`
 BLE_ADVERT=S${VIN_HASH:0:16}C
 echo "Calculating BLE Advert ${BLE_ADVERT} from VIN"
 echo "Scanning Bluetooth for $BLE_ADVERT, wait 10 secs" 
 bluetoothctl --timeout 10 scan on | grep $BLE_ADVERT
 echo "More work needed on this"
}

delete_legacies(){
echo "Deleting Legacy MQTT Topics"
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/switch/tesla_ble/sw-heater/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/switch/tesla_ble/sentry-mode/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/select/tesla_ble/heated_seat_left/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/select/tesla_ble/heated_seat_right/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/binary_sensor/tesla_ble/presence/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/number/tesla_ble/charging-set-amps/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/number/tesla_ble/charging-set-limit/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/number/tesla_ble/climate-temp/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/generate_keys/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/deploy_key/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/scan_bluetooth/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/wake/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/flash-lights/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/honk/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/lock/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/unlock/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/auto-seat-climate/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/climate-on/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/climate-off/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/trunk-open/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/trunk-close/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/frunk-open/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/charging-start/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/charging-stop/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/charge-port-open/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/charge-port-close/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/windows-close/config -n
mosquitto_pub -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/button/tesla_ble/windows-vent/config -n

if [ -f /share/tesla_ble_mqtt/private.pem ]; then
 echo "Renaming legacy keys"
 mv /share/tesla_ble_mqtt/private.pem /share/tesla_ble_mqtt/${TESLA_VIN}_private.pem
 mv /share/tesla_ble_mqtt/public.pem /share/tesla_ble_mqtt/${TESLA_VIN}_public.pem
fi

}
