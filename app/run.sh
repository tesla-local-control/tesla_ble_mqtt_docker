#!/bin/ash
set -e

echo "tesla_ble_docker by Iain Bullock 2024 https://github.com/iainbullock/tesla_ble_docker"
echo "Inspiration by Raphael Murray https://github.com/raphmur"
echo "Instructions by Shankar Kumarasamy https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3"

echo "Configuration Options are:"
echo TESLA_VIN=$TESLA_VIN
echo SSH_PORT=$SSH_PORT

if [ ! -f private.pem ]; then
  echo "Private key not found, assuming this is the first run"
  echo "Generating the private key"
  openssl ecparam -genkey -name prime256v1 -noout > private.pem
  cat private.pem
  echo "Generating the public key"
  openssl ec -in private.pem -pubout > public.pem
  cat public.pem
fi

if [ -f public.pem ]; then
  echo "Public key found, sending to vehicle using BLE"
  tesla-control -ble add-key-request public.pem owner cloud_key
fi
