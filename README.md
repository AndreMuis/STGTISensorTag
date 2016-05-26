# STGTISensorTag
Use the STGTISensorTag framework to connect any Apple device to a TI SensorTag and read measurement data from its many sensors.

## Sensors

- [x] Accelerometer - acceleration acting on SensorTag in g's
- [x] Gyroscope - angular velocity of SensorTag in rad/sec 
- [x] Temperature Sensor - ambient temperature in &#8457;
- [x] Magnetometer - local magnetic field strength in microteslas
- [x] Humidity Sensor - relative humidity in %
- [x] Barometric Pressure Sensor - atmospheric pressure in millibars

## Other readings

- [x] RSSI - signal strength in dB
- [x] Simple Keys Service - which key on SensorTag is pressed

### Installation via CocoaPods

In your Podfile:

```ruby
platform :ios, '9.0'
use_frameworks!

pod 'STGTISensorTag', '1.0.3'
```

## Usage

Import STGTISensorTag framework:

```swift
import STGTISensorTag
```

Create an instance of STGCentralManager:

```swift
self.centralManager = STGCentralManager(delegate: self)
```

If the central manager's state is found to be "powered on" then start scanning for SensorTags: 

```swift
func centralManagerDidUpdateState(state: STGCentralManagerState)
{
  if (state == STGCentralManagerState.PoweredOn)
  {
    self.centralManager.startScanningForSensorTags()
  }        
}
```

After a SensorTag is discovered and connected create a STGSensorTag instance and start discovering the SensorTag's services:

```swift
func centralManager(central: STGCentralManager, didConnectSensorTagPeripheral peripheral: CBPeripheral)
{
  self.sensorTag = STGSensorTag(delegate: self, peripheral: peripheral)
        
  self.sensorTag!.discoverServices()
}
```

As characteristics are discovered for different sensors enable them as needed to read their measurement data:

```swift
func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForGyroscope gyroscope: STGGyroscope)
{
  self.sensorTag!.gyroscope.enable(measurementPeriodInMilliseconds: 300)
}
```

Measurement data is then ready to be used:

```swift
func sensorTag(sensorTag: STGSensorTag, didUpdateAngularVelocity angularVelocity: STGVector)
{
  print("angular velocity = \(angularVelocity) rads / sec")
}
```


