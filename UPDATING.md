# Updating to a new version or using the development version

## Updating to a new version
Here's how using the command line. It is assumed you are using images from DockerHub. All previous settings and enrolled keys are preserved:

    - Stop the Docker stack, and remove the container
    ```
    docker compose down
    docker rm tesla_ble_mqtt
    ```
    - Change to the directory where your docker-compose.yml and stack.env is located
    ```
    cd Directory/Where/Your_docker-compose.yml_Is
    ```
    - A new version may introduce features which require changes to the environment variables (in stack.env or docker-compose.yml). Check the CHANGELOG.md for the new version, and make changes to these files as required
    - Optional, but it is recommended that you delete the Home Assistant MQTT device for your car(s), see below
    - Pull in the new Docker image and restart the stack
    ```
    docker compose up -d
    ```
    - Check the version is as expected in the Docker logs or on the Home Assistant MQTT device page

## Using the development version
Here's how using the command line. It is assumed you are using images from DockerHub. All previous settings and enrolled keys are preserved:

    - Stop the Docker stack
    ```
    docker compose down
    ```
    - Change to the directory where your docker-compose.yml and stack.env is located
    ```
    cd Directory/Where/Your_docker-compose.yml_Is
    ```
    - The dev version may introduce features which require changes to the environment variables (in stack.env or docker-compose.yml). Check the CHANGELOG.md for the dev version (this will usually be in the #iain-dev branch on GitHub https://github.com/tesla-local-control/tesla_ble_mqtt_docker/blob/iain-dev/CHANGELOG.md), and make changes to these files as required
    - In docker-compose.yml, change the line:
    ```
    image: "iainbullock/tesla_ble_mqtt:latest"
    ```
    to
    ```
    image: "iainbullock/tesla_ble_mqtt:dev"
    ```
    - Optional, but it is recommended that you delete the Home Assistant MQTT device for your car(s), see below
    - Pull in the new Docker image and restart the stack
    ```
    docker compose up -d
    ```
    - Check the version is as expected in the Docker logs or on the Home Assistant MQTT device page

## Deleting the Home Assistant MQTT device for your car(s)
Some HA entities may be removed or renamed in new or development versions. To remove / update these, it is recommend you follow this. You don't need to do this if the new version only adds new entities, and doesn't remove or rename existing ones. You can tell by reading the CHANGELOG.md. Note if you have customised any entities like changing units, icons, decimal precision, enabling those disabled by default, etc., these changes will be lost when you follow this processes. If you've done a lot of customisation, you might not want to do this, you should instead make any renames or deletions manually.
    - Go into HA->Settings->Devices&Services
    - Find and click MQTT integration
    - In the Integration entries panel, click 'xx devices' where xx will be how many MQTT devices you have on your system
    - In the list of devices, find and click your car 'Tesla_BLE_XXXXXXXXXX'
    - In this panel you will see the version number of this project:

    - Click the three dots to the right of 'MQTT INFO'
    - Click Delete
    - Repeat for any other cars you might have
    - After restarting the container:
        - Check the version number of the project is as expected
        - If you want polling, check the 'State Polling' switch is on, and adjust to 'Polling Internal' slider to what you need (660 is recommended) 
        - Press the 'Force Update All' button
        - Repeat for any other cars you might have