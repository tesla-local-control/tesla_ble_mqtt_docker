#!/bin/ash
set +e

echo "tesla_ble_mqtt_docker by Iain Bullock 2024 https://github.com/iainbullock/tesla_ble_mqtt_docker"
echo "Inspiration by Raphael Murray https://github.com/raphmur"
echo "Instructions by Shankar Kumarasamy https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3"

echo "Configuration Options are:"
echo TESLA_VIN=$TESLA_VIN
echo SSH_PORT=$SSH_PORT
echo MQTT_IP=$MQTT_IP
echo MQTT_PORT=$MQTT_PORT
echo MQTT_USER=$MQTT_USER
echo "MQTT_PWD=Not Shown"

echo "Setting up auto discovery for Home Assistant"
. /app/discovery.sh

echo "Listening to MQTT"
while true
do
 mosquitto_sub -h $mqtt_ip -p $mqtt_port -u $mqtt_user -P $mqtt_pwd -t tesla_ble/+ -F "%t %p" | while read -r payload
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
     echo Command $msg requested;;
    
    tesla_ble/charging-amps)
     echo Set Charging Amps to $msg requested;;
    
    *)
     echo Invalid MQTT topic;;
   esac
  done
 sleep 1
done
