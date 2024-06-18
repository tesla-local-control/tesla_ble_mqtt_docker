#!/bin/ash
set +e

listen_to_mqtt() {
 echo "Listening to MQTT"
 mosquitto_sub --nodelay -E -c -i $TESLA_VIN -q 1 -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble/+ -F "%t %p" | while read -r payload
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
       openssl ecparam -genkey -name prime256v1 -noout > /share/tesla_ble_mqtt/private.pem
       cat /share/tesla_ble_mqtt/private.pem
       echo "Generating the public key"
       openssl ec -in private.pem -pubout > /share/tesla_ble_mqtt/public.pem
       cat /share/tesla_ble_mqtt/public.pem
       echo "KEYS GENERATED. Next:
       1/ Remove any previously deployed BLE keys from vehicle before deploying this one
       2/ Wake the car up with your Tesla App
       3/ Push the button 'Deploy Key'";;

      deploy_key) 
       echo "Deploying public key to vehicle"  
       send_key;;

      *)
       echo "Invalid Configuration request. Topic: $topic Message: $msg";;
     esac;;
    
    tesla_ble/command)
     echo "Command $msg requested"
     case $msg in
       wake)
        echo "Waking Car"
        send_command "-domain vcsec $msg";;     
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
       charge-port-open)
        echo "Open Charge Port"
        send_command $msg;;   
       charge-port-close)
        echo "Close Charge Port"
        send_command $msg;;    
       climate-on)
        echo "Start Climate"
        send_command $msg;;
       climate-off)
        echo "Stop Climate"
        send_command $msg;;
       flash-lights)
        echo "Flash Lights"
        send_command $msg;;
       frunk-open)
        echo "Open Frunk"
        send_command $msg;;
       honk)
        echo "Honk Horn"
        send_command $msg;;
       ping)
        echo "Ping Car"
        send_command $msg;;
       lock)
        echo "Lock Car"
        send_command $msg;; 
       unlock)
        echo "Unlock Car"
        send_command $msg;;
       unlock)
        echo "Unlock Car"
        send_command $msg;;
       windows-close)
        echo "Close Windows"
        send_command $msg;;
       windows-vent)
        echo "Vent Windows"
        send_command $msg;; 
       product-info)
        echo "Get Product Info (experimental)"
        send_command $msg;;          
       session-info)
        echo "Get Session Info (experimental)"
        send_command $msg;;  
       *)
        echo "Invalid Command Request. Topic: $topic Message: $msg";;
      esac;;
      
    tesla_ble/charging-amps)
     echo "Set Charging Amps to $msg requested"
     # https://github.com/iainbullock/tesla_ble_mqtt_docker/issues/4
     if [ $msg -gt 4 ]; then
     echo "Set amps"
      send_command "charging-set-amps $msg"
     else
      echo "First Amp set"
      send_command "charging-set-amps $msg"
      sleep 1
      echo "Second Amp set"
      send_command "charging-set-amps $msg"
     fi;;

    tesla_ble/auto-seat-and-climate)
     echo "Start Auto Seat and Climate"
     send_command "auto-seat-and-climate LR on";;

    tesla_ble/charging-set-limit)
     echo "Set Charging Limit to $msg requested"
     send_command "charging-set-limit $msg";;    

    tesla_ble/climate-set-temp)
     echo "Set Climate Temp to $msg requested"
     send_command "climate-set-temp $msg";;    
     
    tesla_ble/heated_seat_left)
     echo "Set Seat heater to front-left $msg requested"
     send_command "seat-heater front-left $msg";;      
     
    tesla_ble/heated_seat_right)
     echo "Set Seat heater to front-right $msg requested"
     send_command "seat-heater front-right $msg";;      
     
    *)
     echo "Invalid MQTT topic. Topic: $topic Message: $msg";;
   esac
  done
}

listen_for_HA_start() {
 mosquitto_sub --nodelay -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t homeassistant/status -F "%t %p" | while read -r payload
  do
   topic=$(echo "$payload" | cut -d ' ' -f 1)
   msg=$(echo "$payload" | cut -d ' ' -f 2-)
   echo "Received HA Status message: $topic $msg"
   case $topic in

    homeassistant/status)
     case $msg in
       offline)
        echo "Home Assistant is stopping";;
       online)
        # https://github.com/iainbullock/tesla_ble_mqtt_docker/discussions/6
        echo "Home Assistant is starting, re-running MQTT auto-discovery"
        setup_auto_discovery;;
       *)
        echo "Invalid Command Request. Topic: $topic Message: $msg";;
     esac;;
    *)
     echo "Invalid MQTT topic. Topic: $topic Message: $msg";;
   esac
  done
}
