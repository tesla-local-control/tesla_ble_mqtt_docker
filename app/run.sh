#!/bin/ash
set -e

# read options
cp -n /app/config.sh /data
. /data/config.sh

# Exit if options not setup
if [ $OPTIONS_COMPLETE != 1 ]; then
  echo "Configuration options not set in /data/config.sh, exiting"
  exit 0
fi

echo "Configuration Options are:"
echo VIN=$VIN
