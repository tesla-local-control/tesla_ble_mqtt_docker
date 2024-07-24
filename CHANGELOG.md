# Changelog

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
- CHG Removed: Setting ble\_mac\_list; obsoleted by BLE MAC address auto-detection
- CHG Removed: scan-bleln-macaddr, obsoleted by BLE MAC address auto-detection

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
