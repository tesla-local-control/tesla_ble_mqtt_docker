<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->

## 0.0.11

### Breaking change & Upgrade Instruction
- **BREAKING CHANGE - save config before update**: Now supports **list** of VINS and MAC addresses. You will need to adjust configuration. Existing **entities** from v0.0.10f will not be affected.
- Cut & Paste your current vin to vin_list
- Cut & Paste your current mac_addr to mac_addr_list

### Changed
- NEW Feature: Support for unlimited cars (VINs + MAC Addrs)
- NEW Feature: Added a TTL for car presence, when gone the sensor in HA stays ON until the TTL expires
- NEW Feature: Added "debug" entity which sends only one charge amps command: Issue [#19](https://github.com/tesla-local-control/tesla_ble_mqtt_core/issues/19)
- NEW Setting: BLE Proximity Detection TTL (Detection is on by default; set to 0 to disable)
- NEW Setting: Presence Detection Loop Delay (how often to check the presence of your car(s))
- NEW Setting: Toggle to enable/disable Home Assistant Features (Standalone version only)
- CHG: Improved presence detection reliability (using car's MAC addr and BLE Local Name)
- CHG: Support bashio::log w/ timestamp (HA add-on)
- CHG: Reduce logging; Improved colors consistency; More to be removed once code is considered stable
- CHG: Add bluez-deprecated pkg (ciptool hciattach hciconfig hcidump hcitool meshctl rfcomm sdptool)
- WARNING: [BLE device possible overheating](https://github.com/tesla-local-control/tesla-local-control-addon/issues/27) causing performance issues


## 0.0.10

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
