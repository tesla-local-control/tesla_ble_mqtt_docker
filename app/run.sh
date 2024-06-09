#!/bin/ash
set -e

echo "tesla_ble_docker by Iain Bullock 2024 https://github.com/iainbullock/tesla_ble_docker"
echo "Inspiration by Raphael Murray https://github.com/raphmur"
echo "Instructions by Shankar Kumarasamy https://shankarkumarasamy.blog/2024/01/28/tesla-developer-api-guide-ble-key-pair-auth-and-vehicle-commands-part-3"

echo -e "Configuration Options are:"
echo TESLA_VIN=$TESLA_VIN
echo SSH_PORT=$SSH_PORT

generate_tesla_keypair() {
  echo -e "Generating the private key"
  openssl ecparam -genkey -name prime256v1 -noout > private.pem
  cat private.pem
  echo -e "Generating the public key"
  openssl ec -in private.pem -pubout > public.pem
  cat public.pem
}

if [ ! -f /data/private.pem ]; then
  echo -e "Private key not found, assuming this is the first run"
  generate_tesla_keypair
fi


