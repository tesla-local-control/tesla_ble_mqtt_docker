#!/bin/ash

listen_to_mqtt() {
 echo "Listening to MQTT"
 mosquitto_sub --nodelay -E -c -i tesla_ble_mqtt -q 1 -h $MQTT_IP -p $MQTT_PORT -u "${MQTT_USER}" -P "${MQTT_PWD}" -t tesla_ble_mqtt/+/+ -F "%t %p" | while read -r payload
  do
   topic=${payload%% *}
   msg=${payload#* } 
   topic_stripped=${topic#*/}
   vin=${topic_stripped%/*}
   cmnd=${topic_stripped#*/}
   echo "Received MQTT message $topic $msg VIN: $vin COMMAND: $cmnd"

   case $cmnd in
    config)
     echo "Configuration $msg requested"
     case $msg in
      generate_keys)
       echo "Generating the private key"
       openssl ecparam -genkey -name prime256v1 -noout > /share/tesla_ble_mqtt/$vin_private.pem
       cat /share/tesla_ble_mqtt/$vin_private.pem
       echo "Generating the public key"
       openssl ec -in /share/tesla_ble_mqtt/$vin_private.pem -pubout > /share/tesla_ble_mqtt/$vin_public.pem
       cat /share/tesla_ble_mqtt/$vin_public.pem
       echo "KEYS GENERATED. Next:
       1/ Remove any previously deployed BLE keys from vehicle before deploying this one
       2/ Wake the car up with your Tesla App
       3/ Push the button 'Deploy Key'";;

      deploy_key) 
       echo "Deploying public key to vehicle"  
       send_key $vin;;

      scan_bluetooth)
       echo "Scanning Bluetooth"
       scan_bluetooth;;

      *)
       echo "Invalid Configuration request. Topic: $topic Message: $msg";;
     esac;;
    
    command)
     echo "Command $msg requested"
     case $msg in
       wake)
        echo "Waking Car"
        send_command $vin "-domain vcsec $msg";;     
       trunk-open)
        echo "Opening Trunk"
        send_command $vin $msg;;
       trunk-close)
        echo "Closing Trunk"
        send_command $vin $msg;;
       charging-start)
        echo "Start Charging"
        send_command $vin $msg;; 
       charging-stop)
        echo "Stop Charging"
        send_command $vin $msg;;         
       charge-port-open)
        echo "Open Charge Port"
        send_command $vin $msg;;   
       charge-port-close)
        echo "Close Charge Port"
        send_command $vin $msg;;    
       climate-on)
        echo "Start Climate"
        send_command $vin $msg;;
       climate-off)
        echo "Stop Climate"
        send_command $vin $msg;;
       flash-lights)
        echo "Flash Lights"
        send_command $vin $msg;;
       frunk-open)
        echo "Open Frunk"
        send_command $vin $msg;;
       honk)
        echo "Honk Horn"
        send_command $vin $msg;;
       ping)
        echo "Ping Car"
        send_command $vin $msg;;
       lock)
        echo "Lock Car"
        send_command $vin $msg;; 
       unlock)
        echo "Unlock Car"
        send_command $vin $msg;;
       unlock)
        echo "Unlock Car"
        send_command $vin $msg;;
       windows-close)
        echo "Close Windows"
        send_command $vin $msg;;
       windows-vent)
        echo "Vent Windows"
        send_command $vin $msg;; 
       product-info)
        echo "Get Product Info (experimental)"
        send_command $vin $msg;;          
       session-info)
        echo "Get Session Info (experimental)"
        send_command $vin $msg;;  
       *)
        echo "Invalid Command Request. Topic: $topic Message: $msg";;
      esac;;
      
    charging-amps)
     echo "Set Charging Amps to $msg requested"
     # https://github.com/iainbullock/tesla_ble_mqtt_docker/issues/4
     if [ $msg -gt 4 ]; then
     echo "Set amps"
      send_command $vin "charging-set-amps $msg"
     else
      echo "First Amp set"
      send_command $vin "charging-set-amps $msg"
      sleep 1
      echo "Second Amp set"
      send_command $vin "charging-set-amps $msg"
     fi;;

    auto-seat-and-climate)
     echo "Start Auto Seat and Climate"
     send_command $vin "auto-seat-and-climate LR on";;

    charging-set-limit)
     echo "Set Charging Limit to $msg requested"
     send_command $vin "charging-set-limit $msg";;    

    climate-set-temp)
     echo "Set Climate Temp to $msg requested"
     send_command $vin "climate-set-temp $msg";;    
     
    heated_seat_left)
     echo "Set Seat heater to front-left $msg requested"
     send_command $vin "seat-heater front-left $msg";;      
     
    heated_seat_right)
     echo "Set Seat heater to front-right $msg requested"
     send_command $vin "seat-heater front-right $msg";;      
     
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
        if [ " $TESLA_VIN" ]; then
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
	fi;;	
       *)
        echo "Invalid Command Request. Topic: $topic Message: $msg";;
     esac;;
    *)
     echo "Invalid MQTT topic. Topic: $topic Message: $msg";;
   esac
  done
}
