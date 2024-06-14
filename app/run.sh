#!/bin/ash
set +e

echo "tesla_ble_mqtt_docker by Iain Bullock 2024 https://github.com/iainbullock/tesla_ble_mqtt_docker"
echo "Inspiration by Raphael Murray https://github.com/raphmur"
echo "Instructions by Shankar Kumarasamy https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3"

echo "Configuration Options are:"
echo TESLA_VIN=$TESLA_VIN
echo MQTT_IP=$MQTT_IP
echo MQTT_PORT=$MQTT_PORT
echo MQTT_USER=$MQTT_USER
echo "MQTT_PWD=Not Shown"

send_command() {
 for i in $(seq 5); do
  echo "Attempt $i/5"
  tesla-control -ble -key-name private.pem -key-file private.pem $1
  if [ $? -eq 0 ]; then
    echo "Ok"
    break
  fi
  sleep 5
 done 
}

echo "Setting up auto discovery for Home Assistant"
. /app/discovery.sh

echo "Listening to MQTT"
while true
do
 mosquitto_sub -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t tesla_ble/+ -t homeassistant/status -F "%t %p" | while read -r payload
  do
   topic=$(echo "$payload" | cut -d ' ' -f 1)
   msg=$(echo "$payload" | cut -d ' ' -f 2-)
   echo "Received MQTT message: $topic $msg"
   case $topic in
    tesla_ble/config)
     echo "Configuration $msg requested"
     case $msg in
      generate_keys)
       echo "Generating the private key"
       openssl ecparam -genkey -name prime256v1 -noout > private.pem
       cat private.pem
       echo "Generating the public key"
       openssl ec -in private.pem -pubout > public.pem
       cat public.pem
       echo "Keys generated, ready to deploy to vehicle. Remove any previously deployed keys from vehicle before deploying this one";;
      deploy_key) 
       echo "Deploying public key to vehicle"  
        tesla-control -ble add-key-request public.pem owner cloud_key;;
      *)
       echo "Invalid Configuration request";;
     esac;;
    
    tesla_ble/command)
     echo "Command $msg requested"
     case $msg in
       trunk-open)
        echo "Opening Trunk"
        send_command $msg;;
       trunk-close)
        echo "Closing Trunk"
        send_command $msg;;
       charging-start)
        echo "Start Charging"
        send_command $msg;; 
       charging-stop)
        echo "Stop Charging"
        send_command $msg;;         
       *)
        echo "Invalid Command Request";;
      esac;;
      
    tesla_ble/charging-amps)
     echo Set Charging Amps to $msg requested
     # https://github.com/iainbullock/tesla_ble_mqtt_docker/issues/4
     echo First Amp set
     send_command "charging-set-amps $msg"
     sleep 1
     echo Second Amp set
     send_command "charging-set-amps $msg";;

    homeassistant/status)
     # https://github.com/iainbullock/tesla_ble_mqtt_docker/discussions/6
     echo "Home Assistant is stopping or starting, re-running auto-discovery setup"
     . /app/discovery.sh;;
    *)
     echo "Invalid MQTT topic";;
   esac
  done
 sleep 1
done
