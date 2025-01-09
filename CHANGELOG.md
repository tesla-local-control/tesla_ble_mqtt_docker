# Changelog

## 0.4.0b-dev

- RELEASE NEW Feature: Automatic Polling is now possible for state

- NEW Feature: The following new states / entities are added:
   - Switches: Polling 
   - Numbers: Polling Interval
   - Buttons: Force Update buttons for individual state categories 

- NEW Feature: Environment variable NO_POLL_SECTIONS is provided to disable updating of various state categories during polling. This speeds up state updates, though less state entities are updated by the polling. The entities can still be manually updated by pressing the Force Update button for the relevent state category

- Changes:
   - 'Force Data Update' Button is renamed to 'Force Update All'
   - Errors which occur whilst reading state will not automatically prevent the next state or state category being read. This will fix an issue reported in #135 below where a user doesn't have a Heated Steering Wheel. This previously prevented any states after this one from being read

- Fixes:
   - All my sensor entities are "unknown" #131 (_core)
   - Any potential to "read state" via bluetooth? #115 (_core)

## 0.3.1

- NEW Feature: The following new states / entities are added:
   - Sensors: Charger Voltage; Charger Range Added; Charge Speed mph; Passenger Temp Setting, Odometer
   - Binary_Sensors: Front Defroster; Rear Defroster; Wiper Heater; Side Mirror Heater; Doors Open
   - Selects: Heated Seat Rear Left; Heated Seat Rear Right

- Fixes:
   - Temp units incorrect for new Inside Temp and Outside Temp #135 (_core)

## 0.3.0

- MAJOR NEW Feature: Read car state using BLE

### Changes

- NEW Feature: The following new states / entities are available, more to follow in future releases:
   - Sensors: Battery Level (State of Charge); Battery Range; Charge Energy Added; Charger Current; Charger Power; Inside Temp; Outside Temp; Tyre Pressures
   - Binary_Sensors: Battery Heater On; Frunk Open; Windows Open; Door Lock
   - Switches: Charger; Climate; Sentry Mode
   - Numbers: Charging Current; Charging SOC Limit; Climate Temp
   - Covers: Charge Port; Trunk
   - Selects: Heated Seat Front Left; Heated Seat Front Right
   - Buttons: Force Data Update

- NEW Feature: Status / type of charge cable is reported as a sensor

- Fixes:
   - Error for setting climate temp #61 (_docker)
   - Error 'Icons should be specified in the form "prefix:name" for dictionary value @ data['icon']' when processing MQTT discovery message topic #124 (_core)
   - Getting more information over BLE is now possible. #66 (_docker)
   - Fetch limited vehicle info over BLE #25 (_core)
   - Any potential to "read state" via bluetooth? #115 (_core)
   - read SoC possible? #124 (-addon)
   - Read state of charge cable connected? #117 (-addon)

## 0.2.2

### Changed

- NEW Feature: Try to wake car if command fails with "Error: context deadline exceeded"
- NEW Feature: Added maximum allowable setting to limit the current slider in HA entities

#### Contributors - Thank you!
- @g4rb4g3 Clear logging on charging current setting

## 0.2.1

### <p>**WARNING WARNING WARNING**<br>
Upgrading from 0.0.10 or previous? DO NOT UPGRADE PRIOR TO READ THE 0.1.0 UPGRADE INSTRUCTIONS.</p>

### Changed

- NEW Feature: Allow to set temperature unit F|C via bool

## 0.2.0

### <p>**WARNING WARNING WARNING**<br>
Upgrading from 0.0.10 or previous? DO NOT UPGRADE PRIOR TO READ THE 0.1.0 UPGRADE INSTRUCTIONS.</p>

### <p>**BREAKING CHANGE**<br>
On/off and Open/Close entities have been grouped under switches and covers.</p>
/!\ It will affect your current Home Assistant MQTT entities (if you use them)

   | Old Entity Name   | New Entity Name          |
   |:------------------|:-------------------------|
   | windows-close     | windows (open/close)     |
   | windows-vent      | "                        |
   | charging-start    | charger (start/stop)     |
   | charging-stop     | "                        |
   | charge-port-open  | charge-port (open/close) |
   | charge-port-close | "                        |
   | climate-on        | climate (on/off)         |
   | climate-off       | "                        |
   | trunk-open        | trunk (open/close)       |
   | trunk-close       | "                        |


### Changed

- NEW Feature: Car's BLE MAC address is now auto-detected
- NEW Feature: Info Bluetooth Adapter, view in add-on's Log tab
- NEW Feature: Added more car specific commands; see below for the list
- NEW Feature: Migrated buttons to covers and switches
- NEW: Icons were added in the UI!
- CHG: Increased tesla-control command-timeout from 5s to 20s
- CHG: Removed Setting ble\_mac\_list; obsoleted by BLE MAC address auto-detection
- CHG: Removed scan-bleln-macaddr, obsoleted by BLE MAC address auto-detection

- Added commands

   | Commands   | Note    |
   |:------------------|:---------------|
   | autosecure-modelx     | Model X     |
   | auto-seat-and-climate | |
   | body-controller-state | |
   | drive     |     |
   | flash-lights     |      |
   | frunk-open     |      |
   | honk     |      |
   | lock     |      |
   | media-toggle-playback     |      |
   | tonneau-close     | Cybertruck     |
   | tonneau-open     | Cybertruck     |
   | tonneau-stop     | Cybertruck     |
   | trunk-close     |      |
   | trunk-move     |      |
   | trunk-open     |      |
   | unlock     |      |

## 0.1.2

### Changed

- CHG: Fix allow empty setting BLE MAC addr (Docker standalone)

## 0.1.1

### Changed

- CHG: Fix upgrade forcing to redeploy the key to the car

## 0.1.0

### Changed

<p>WARNING WARNING WARNING<br>
DO NOT UPGRADE PRIOR TO READ THE BELOW UPGRADE INSTRUCTIONS, SEE AFTER LIST OF CHANGES<br>
WARNING WARNING WARNING</p>

- NEW Feature: Support for unlimited cars (VINs + MAC Addrs)
- NEW Setting: BLE Proximity Detection TTL; helps reduce false negative presence with sporadic BLE advertisement (0 to disable)
- NEW Feature: Added "debug" entity which sends only one charge amps command: Issue [#19](https://github.com/tesla-local-control/tesla_ble_mqtt_core/issues/19)
- NEW Feature: Device's cards and buttons are made visible based on logic that takes into account the state of generated keys, sent and accepted public key by the vehicle.
- NEW Setting: Presence Detection Loop Delay (how often to check the presence of your car(s))
- NEW Setting: Toggle to enable/disable Home Assistant Features (Standalone version only)
- CHG: Improved presence detection reliability (using car's MAC addr and BLE Local Name)
- CHG: Added retry functionality on MQTT publish failure (service/network issue)
- CHG: Rename entities for consistency & better wording (see table below)
- CHG: Code Quality Linting (shellcheck & shfmt) [ @epenet ]
- CHG: Support bashio::log w/ timestamp (HA add-on)
- CHG: Reduce logging; Improved colors consistency; More to be removed in next release
- CHG: Add bluez-deprecated pkg (ciptool hciattach hciconfig hcidump hcitool meshctl rfcomm sdptool)
- CHG: Refactor MQTT listener; removed blocking event
- WARNING: [BLE device possible overheating](https://github.com/tesla-local-control/tesla-local-control-addon/issues/27) causing performance issues

#### Upgrade Instructions & **BREAKING CHANGES**
- **Before update** save your configuration values (VIN, MAC address and MQTT values)
- You will need to adjust your configuration
- Now supports **list** of VINS and MAC addresses.
- Paste your current vin to vin_list, if you own more than 1 Tesla add them all!
- Paste your current mac_addr to mac_addr_list (optional for presence detection)
- Paste your MQTT values
- Existing **entities** from v0.0.10f will not be affected with a few exceptions***

#### Entities renamed

<p>For consistency, moving foward entity name uses only alphadigits and as a seperator - (no more _).<br>
/!\ It will affect your current Home Assistant MQTT entities (if you use them)></p>

   | Old Entity Name   | New Entity Name          |
   |:------------------|:-------------------------|
   | auto_seat-climate | auto-seat-and-climate    |
   | flash_lights      | flash-lights             |
   | heated_seat_left  | heater-seat-front-left*  |
   | heated_seat_right | heater-seat-front-right* |
   | sw_heater         | steering-wheel-heater    |
   \* in preparation "someday" for rear seats

#### Contributors - Thank you!
- @epenet Code Quality Linting

## 0.0.10

### Changed

- Toggle to enable/disable car presence detection
- Added multi-level & multi-color logs
- Initial core component release (git submodule)

### Changed

## 0.0.9

### Changed

- Fixed useless tesla-control retries

## 0.0.8b

### Changed

- The project has moved to an open source organisation "tesla-local-control". Please update the repo in HA to: https://github.com/tesla-local-control/tesla-local-control-addon

## 0.0.8a

### Changed

- Updated doc for MAC addresses config

## 0.0.8

### Changed

- [Standalone] Fix broken deployment introduced in 0.0.7
- [Standalone] Add colored logging based on log level

## 0.0.7a

### Changed

WARNING: broken for standalone deployment, stay on 0.0.6
OK for HA Addon

- logging msg adjustments & fix logic for log.debug
- logging add logic for log.debug to properly work

## 0.0.7

### Changed

WARNING: broken for standalone deployment, stay on 0.0.6
OK for HA Addon

- Bump to latest updates from tesla_ble_mqtt_docker
- Improve HA logging and error management
- Add FR translation
- Fix auto climate command

## 0.0.6

### Changed

- Fix typo
- Harmonize docs

## 0.0.5

### Changed

- Fix extension stopping at first MQTT listening
- Update logging and documentation
- Improve pairing procedure doc and logging
- Improve HA entities classification
- Cleanup

## 0.0.4

### Changed

- Fix periodicity of BLE discovery (to cope with HA limits)
- Fix set-amps for current above 5A

## 0.0.3

### Changed

- Bump sh content to match iainbullock's developments in separate github: https://github.com/iainbullock/tesla_ble_mqtt_docker
- Enable presence discovery in home-assistant directly

## 0.0.2

### Changed

- Bump sh content to v1.0.14 https://github.com/iainbullock/tesla_ble_mqtt_docker


## 0.0.1

### Changed

- Initial dev version based on https://github.com/iainbullock/tesla_ble_mqtt_docker
- WARN: standalone not tested
