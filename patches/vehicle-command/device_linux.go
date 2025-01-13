// Credit to https://github.com/BogdanDIA
// Source https://github.com/BogdanDIA/tesla-ble
// Discussion: https://github.com/tesla-local-control/tesla_ble_mqtt_core/issues/125

package ble

import (
  "github.com/go-ble/ble"
  "github.com/go-ble/ble/linux"
  "github.com/go-ble/ble/linux/hci/cmd"
  "os"
  "strconv"
  "time"
)

const bleTimeout = 20 * time.Second
//const bleDevice = 0

// TODO: Depending on the model and state, BLE advertisements come every 20ms or every 150ms.

var scanParams = cmd.LESetScanParameters{
  LEScanType:           1,    // Active scanning
  LEScanInterval:       0x0010, // 10ms
  LEScanWindow:         0x0010, // 10ms
  OwnAddressType:       0,    // Static
  ScanningFilterPolicy: 0,    // Change from 0x02 to 0, Basic filtered
}

var createConnection = cmd.LECreateConnection{
  LEScanInterval:        0x0010,    // 0x0004 - 0x4000; N * 0.625 msec
  LEScanWindow:          0x0010,    // 0x0004 - 0x4000; N * 0.625 msec
  InitiatorFilterPolicy: 0x00,      // White list is not used
  PeerAddressType:       0x00,      // Public Device Address
  PeerAddress:           [6]byte{}, //
  OwnAddressType:        0x00,      // Public Device Address
  ConnIntervalMin:       0x0006,    // 0x0006 - 0x0C80; N * 1.25 msec
  ConnIntervalMax:       0x0006,    // 0x0006 - 0x0C80; N * 1.25 msec
  ConnLatency:           0x0000,    // 0x0000 - 0x01F3; N * 1.25 msec
  SupervisionTimeout:    0x0048,    // 0x000A - 0x0C80; N * 10 msec
  MinimumCELength:       0x0000,    // 0x0000 - 0xFFFF; N * 0.625 msec
  MaximumCELength:       0x0000,    // 0x0000 - 0xFFFF; N * 0.625 msec
}

func newDevice() (ble.Device, error) {
  bleDevice, err := strconv.Atoi(os.Getenv("HCINUM"))

  if err != nil{
    bleDevice = -1
  }

  device, err := linux.NewDevice(ble.OptDeviceID(bleDevice), ble.OptListenerTimeout(bleTimeout), ble.OptDialerTimeout(bleTimeout), ble.OptScanParams(scanParams), ble.OptConnParams(createConnection))

  if err != nil {
    return nil, err
  }

  return device, nil
}
