function validateEnvVars() {
  exitOnError=0

  VIN_PATTERN='^([A-HJ-NPR-Z0-9]{17})(\|[A-HJ-NPR-Z0-9]{17})*$'
  INT0PLUS_PATTERN='^[0-9]+$'
  INT1PLUS_PATTERN='^[1-9][0-9]*$'
  FLOAT_PATTERN='[0-9]*\.?[0-9]+'
  # Hostname & IPv4 Address
  MQTT_SERVER_PATTERN='^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\b|\b([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$'

  if ! echo $VIN_LIST | grep -Eq "$VIN_PATTERN"; then
    log_fatal "Fatal; VIN_LIST:$VIN_LIST is not compliant, please check this setting"
    exitOnError=1
  fi

  if ! echo $PRESENCE_DETECTION_LOOP_DELAY | grep -Eq "$INT0PLUS_PATTERN"; then
    log_fatal "Fatal; PRESENCE_DETECTION_LOOP_DELAY:$PRESENCE_DETECTION_LOOP_DELAY is not compliant, please check this setting"
    exitOnError=1
  fi

  if ! echo $PRESENCE_DETECTION_TTL | grep -Eq "$INT0PLUS_PATTERN"; then
    log_fatal "Fatal; PRESENCE_DETECTION_TTL:$PRESENCE_DETECTION_TTL is not compliant, please check this setting"
    exitOnError=1
  fi

  if ! echo $MQTT_SERVER | grep -Eq "$MQTT_SERVER_PATTERN"; then
    log_fatal "Fatal; MQTT_SERVER:$MQTT_SERVER is not compliant, please check this setting"
    exitOnError=1
  fi

  if ! echo $MQTT_PORT | grep -Eq "$INT1PLUS_PATTERN"; then
    log_fatal "Fatal; MQTT_PORT:$MQTT_PORT is not compliant, please check this setting"
    exitOnError=1
  fi

  if [ "$DEBUG" != 'true' ] && [ "$DEBUG" != 'false' ]; then
    log_fatal "Fatal; DEBUG:$DEBUG is not compliant, please check this setting"
    exitOnError=1
  fi

  if [ "$TEMPERATURE_UNIT_FAHRENHEIT" != 'true' ] && [ "$TEMPERATURE_UNIT_FAHRENHEIT" != 'false' ]; then
    log_fatal "Fatal; TEMPERATURE_UNIT_FAHRENHEIT:$TEMPERATURE_UNIT_FAHRENHEIT is not compliant, please check this setting"
    exitOnError=1
  fi

  if ! echo $MAX_CURRENT | grep -Eq "$INT0PLUS_PATTERN"; then
    log_fatal "Fatal; MAX_CURRENT:$MAX_CURRENT is not compliant, please check this setting"
    exitOnError=1
  fi


  if [ $exitOnError -eq 0 ]; then
    :
  else
    touch /data/.exitOnError
    exit 99
  fi

}


export COLOR=${COLOR:=true}
# Source Logging Library
. /app/liblog.sh

validateEnvVars
