#!/bin/ash

listen_to_mqtt() {
 echo "Listening to MQTT"
 mosquitto_sub --nodelay -E -c -i tesla_ble_mqtt -q 1 -h $MQTT_IP -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PWD -t tesla_ble/+ -t homeassistant/status -F "%t %p" | while read -r payload
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
       echo "Keys generated, ready to deploy to vehicle. Remove any previously deployed BLE keys from vehicle before deploying this one";;
      deploy_key) 
       echo "Deploying public key to vehicle"  
        tesla-control -ble add-key-request public.pem owner cloud_key;;
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
       auto-seat-and-climate)
        echo "Start Auto Seat and Climate"
        send_command $msg;;          
       climate-off)
        echo "Stop Climate"
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
     echo First Amp set
     send_command "charging-set-amps $msg"
     sleep 1
     echo Second Amp set
     send_command "charging-set-amps $msg";;

    tesla_ble/climate-set-temp)
     echo "Set Climate Temp to $msg requested"
     send_command "climate-set-temp $msg";;    
     
    tesla_ble/seat-heater)
     echo "Set Seat Heater to $msg requested"
     send_command "seat-heater $msg";;      
     
    homeassistant/status)
     # https://github.com/iainbullock/tesla_ble_mqtt_docker/discussions/6
     echo "Home Assistant is stopping or starting, re-running auto-discovery setup"
     setup_auto_discovery;;
     
    *)
     echo "Invalid MQTT topic. Topic: $topic Message: $msg";;
   esac
  done
}

