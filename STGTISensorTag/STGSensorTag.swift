//
//  STGSensorTag.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public class STGSensorTag :
    NSObject,
    CBPeripheralDelegate,
    STGAccelerometerDelegate,
    STGBarometricPressureSensorDelegate,
    STGGyroscopeDelegate,
    STGHumiditySensorDelegate,
    STGMagnetometerDelegate,
    STGSimpleKeysServiceDelegate,
    STGTemperatureSensorDelegate
{
    weak var delegate : STGSensorTagDelegate!
    
    var peripheral : CBPeripheral!
 
    public var accelerometer : STGAccelerometer!
    var barometricPressureSensor : STGBarometricPressureSensor!
    var buttonSensor : STGButtonSensor!
    var gyroscope : STGGyroscope!
    var humiditySensor : STGHumiditySensor!
    var magnetometer : STGMagnetometer!
    var rssiSensor : STGRSSISensor!
    var simpleKeysService : STGSimpleKeysService!
    var temperatureSensor : STGTemperatureSensor!

    public init(delegate : STGSensorTagDelegate, peripheral: CBPeripheral)
    {
        super.init()
        
        self.delegate = delegate
        
        self.peripheral = peripheral
    
        self.accelerometer = STGAccelerometer(delegate: self)
        self.barometricPressureSensor = STGBarometricPressureSensor(delegate: self)
        self.buttonSensor = STGButtonSensor()
        self.gyroscope = STGGyroscope(delegate: self)
        self.humiditySensor = STGHumiditySensor(delegate: self)
        self.magnetometer = STGMagnetometer(delegate: self)
        self.rssiSensor = STGRSSISensor()
        self.simpleKeysService = STGSimpleKeysService(delegate: self)
        self.temperatureSensor = STGTemperatureSensor(delegate: self)
    }

    public func readRSSI()
    {
        self.peripheral.readRSSI()
    }
    
    public func discoverServices()
    {
        self.peripheral.delegate = self;
        self.peripheral.discoverServices(nil)
    }

    // MARK: CBPeripheralDelegate
    
    public func peripheralDidUpdateRSSI(peripheral: CBPeripheral, error: NSError?)
    {
        if error == nil
        {
            self.delegate.sensorTag(self, didUpdateRSSI: peripheral.RSSI)
        }
    }

    public func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?)
    {
        if error == nil
        {
            if let services = peripheral.services
            {
                for service : CBService in services
                {
                    peripheral.discoverCharacteristics(nil, forService: service)
                }
            }
        }
    }
    
    public func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?)
    {
        if error == nil
        {
            if let characteristics = service.characteristics
            {
                switch service.UUID
                {
                case self.accelerometer.serviceUUID:
                    self.accelerometer.service = service
                    
                    self.accelerometer.dataCharacteristic = characteristics.filter({$0.UUID == self.accelerometer.dataCharacteristicUUID}).first
                    self.accelerometer.configurationCharacteristic = characteristics.filter({$0.UUID == self.accelerometer.configurationCharacteristicUUID}).first
                    self.accelerometer.periodCharacteristic = characteristics.filter({$0.UUID == self.accelerometer.periodCharacteristicUUID}).first
                    
                    self.delegate.sensorTag(self, didDiscoverCharacteristicsForAccelerometer: self.accelerometer)
                    
                case self.barometricPressureSensor.serviceUUID:
                    self.barometricPressureSensor.service = service

                    self.barometricPressureSensor.dataCharacteristic = characteristics.filter({$0.UUID == self.barometricPressureSensor.dataCharacteristicUUID}).first
                    self.barometricPressureSensor.configurationCharacteristic = characteristics.filter({$0.UUID == self.barometricPressureSensor.configurationCharacteristicUUID}).first
                    self.barometricPressureSensor.calibrationCharacteristic = characteristics.filter({$0.UUID == self.barometricPressureSensor.calibrationCharacteristicUUID}).first
                    self.barometricPressureSensor.periodCharacteristic = characteristics.filter({$0.UUID == self.barometricPressureSensor.periodCharacteristicUUID}).first
                    
                    self.delegate.sensorTag(self, didDiscoverCharacteristicsForBarometricPressureSensor: self.barometricPressureSensor)

                case self.gyroscope.serviceUUID:
                    self.gyroscope.service = service
                
                    self.gyroscope.dataCharacteristic = characteristics.filter({$0.UUID == self.gyroscope.dataCharacteristicUUID}).first
                    self.gyroscope.configurationCharacteristic = characteristics.filter({$0.UUID == self.gyroscope.configurationCharacteristicUUID}).first
                    self.gyroscope.periodCharacteristic = characteristics.filter({$0.UUID == self.gyroscope.periodCharacteristicUUID}).first

                    self.delegate.sensorTag(self, didDiscoverCharacteristicsForGyroscope: self.gyroscope)
                
                case self.humiditySensor.serviceUUID:
                    self.humiditySensor.service = service
                
                    self.humiditySensor.dataCharacteristic = characteristics.filter({$0.UUID == self.humiditySensor.dataCharacteristicUUID}).first
                    self.humiditySensor.configurationCharacteristic = characteristics.filter({$0.UUID == self.humiditySensor.configurationCharacteristicUUID}).first
                    self.humiditySensor.periodCharacteristic = characteristics.filter({$0.UUID == self.humiditySensor.periodCharacteristicUUID}).first
                    
                    self.delegate.sensorTag(self, didDiscoverCharacteristicsForHumiditySensor: self.humiditySensor)

                case self.magnetometer.serviceUUID:
                    self.magnetometer.service = service
                
                    self.magnetometer.dataCharacteristic = characteristics.filter({$0.UUID == self.magnetometer.dataCharacteristicUUID}).first
                    self.magnetometer.configurationCharacteristic = characteristics.filter({$0.UUID == self.magnetometer.configurationCharacteristicUUID}).first
                    self.magnetometer.periodCharacteristic = characteristics.filter({$0.UUID == self.magnetometer.periodCharacteristicUUID}).first
                    
                    self.delegate.sensorTag(self, didDiscoverCharacteristicsForMagnetometer: self.magnetometer)

                case self.simpleKeysService.serviceUUID:
                    self.simpleKeysService.service = service
                    
                    self.simpleKeysService.dataCharacteristic = characteristics.filter({$0.UUID == self.simpleKeysService.dataCharacteristicUUID}).first
                    
                    self.delegate.sensorTag(self, didDiscoverCharacteristicsForSimpleKeysService: self.simpleKeysService)

                case self.temperatureSensor.serviceUUID:
                    self.temperatureSensor.service = service
                
                    self.temperatureSensor.dataCharacteristic = characteristics.filter({$0.UUID == self.temperatureSensor.dataCharacteristicUUID}).first
                    self.temperatureSensor.configurationCharacteristic = characteristics.filter({$0.UUID == self.temperatureSensor.configurationCharacteristicUUID}).first
                    self.temperatureSensor.periodCharacteristic = characteristics.filter({$0.UUID == self.temperatureSensor.periodCharacteristicUUID}).first
                    
                    self.delegate.sensorTag(self, didDiscoverCharacteristicsForTemperatureSensor: self.temperatureSensor)

                default:
                    break
                }
            }
        }
    }
    
    public func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?)
    {
        switch characteristic.service.UUID
        {
        case self.accelerometer.serviceUUID:
            self.accelerometer.characteristicUpdated(characteristic)
            
        case self.barometricPressureSensor.serviceUUID:
            self.barometricPressureSensor.characteristicUpdated(characteristic)
            
        case self.gyroscope.serviceUUID:
            self.gyroscope.characteristicUpdated(characteristic)
            
        case self.humiditySensor.serviceUUID:
            self.humiditySensor.characteristicUpdated(characteristic)
            
        case self.magnetometer.serviceUUID:
            self.magnetometer.characteristicUpdated(characteristic)
            
        case self.simpleKeysService.serviceUUID:
            self.simpleKeysService.characteristicUpdated(characteristic)

        case self.temperatureSensor.serviceUUID:
            self.temperatureSensor.characteristicUpdated(characteristic)
            
        default:
            break
        }
    }
    
    // MARK: STGAccelerometerDelegate
    
    func accelerometerEnable(accelerometer: STGAccelerometer, measurementPeriod period: Int)
    {
        self.updateSensorEnabledState(self.accelerometer.configurationCharacteristic, enabled: true)
        
        self.updateSensorMeasurementPeriod(self.accelerometer.periodCharacteristic, periodInMilliseconds: period)

        self.updateSensorNotificationsEnabledState(self.accelerometer.dataCharacteristic, enabled: true)
    }
    
    func accelerometerDisable(accelerometer: STGAccelerometer)
    {
        self.updateSensorEnabledState(self.accelerometer.configurationCharacteristic, enabled: false)
    }

    func accelerometer(accelerometer : STGAccelerometer, didUpdateAcceleration acceleration : STGVector)
    {
        self.delegate.sensorTag(self, didUpdateAcceleration: acceleration)
    }

    func accelerometer(accelerometer : STGAccelerometer, didUpdateSmoothedAcceleration acceleration : STGVector)
    {
        self.delegate.sensorTag(self, didUpdateSmoothedAcceleration: acceleration)
    }

    // MARK: STGBarometricPressureSensorDelegate

    func barometricPressureSensorGetCalibrationValues(sensor: STGBarometricPressureSensor)
    {
        self.writeByte(self.barometricPressureSensor.configurationCharacteristic, byte: STGConstants.BarometricPressureSensor.calibrationByte)

        if let characteristic = self.barometricPressureSensor.calibrationCharacteristic
        {
            self.peripheral.readValueForCharacteristic(characteristic)
        }
    }
    
    func barometricPressureSensorEnable(sensor: STGBarometricPressureSensor, measurementPeriod period: Int)
    {
        self.updateSensorEnabledState(self.barometricPressureSensor.configurationCharacteristic, enabled: true)
    
        self.updateSensorMeasurementPeriod(self.barometricPressureSensor.periodCharacteristic, periodInMilliseconds: period)
        
        self.updateSensorNotificationsEnabledState(self.barometricPressureSensor.dataCharacteristic, enabled: true)
    }
    
    func barometricPressureSensorDisable(sensor: STGBarometricPressureSensor)
    {
        self.updateSensorEnabledState(self.barometricPressureSensor.configurationCharacteristic, enabled: false)
    }
    
    func barometricPressureSensor(sensor: STGBarometricPressureSensor, didUpdatePressure pressure: Int)
    {
        self.delegate.sensorTag(self, didUpdatePressure: pressure)
    }
    
    // MARK: STGGyroscopeDelegate
    
    func gyroscopeEnable(gyroscope: STGGyroscope, measurementPeriod period: Int)
    {
        self.writeByte(self.gyroscope.configurationCharacteristic, byte: STGConstants.Gyroscope.enableByte)
        
        self.updateSensorMeasurementPeriod(self.gyroscope.periodCharacteristic, periodInMilliseconds: period)

        self.updateSensorNotificationsEnabledState(self.gyroscope.dataCharacteristic, enabled: true)
    }

    func gyroscopeDisable(gyroscope: STGGyroscope)
    {
        self.updateSensorEnabledState(self.gyroscope.configurationCharacteristic, enabled: false)
    }
    
    func gyroscope(gyroscope: STGGyroscope, didUpdateAngularVelocity angularVelocity: STGVector)
    {
        self.delegate.sensorTag(self, didUpdateAngularVelocity: angularVelocity)
    }
    
    // MARK: STGHumiditySensorDelegate

    func humiditySensorEnable(humiditySensor: STGHumiditySensor, measurementPeriod period: Int)
    {
        self.updateSensorEnabledState(self.humiditySensor.configurationCharacteristic, enabled: true)
        
        self.updateSensorMeasurementPeriod(self.humiditySensor.periodCharacteristic, periodInMilliseconds: period)

        self.updateSensorNotificationsEnabledState(self.humiditySensor.dataCharacteristic, enabled: true)
    }
    
    func humiditySensorDisable(humiditySensor: STGHumiditySensor)
    {
        self.updateSensorEnabledState(self.humiditySensor.configurationCharacteristic, enabled: false)
    }
    
    func humiditySensor(humiditySensor: STGHumiditySensor, didUpdateRelativeHumidity relativeHumidity: Float)
    {
        self.delegate.sensorTag(self, didUpdateRelativeHumidity: relativeHumidity)
    }
    
    // MARK: STGMagnetometerDelegate
    
    func magnetometerEnable(magnetometer: STGMagnetometer, measurementPeriod period: Int)
    {
        self.updateSensorEnabledState(self.magnetometer.configurationCharacteristic, enabled: true)
        
        self.updateSensorMeasurementPeriod(self.magnetometer.periodCharacteristic, periodInMilliseconds: period)

        self.updateSensorNotificationsEnabledState(self.magnetometer.dataCharacteristic, enabled: true)
    }
    
    func magnetometerDisable(magnetometer: STGMagnetometer)
    {
        self.updateSensorEnabledState(self.magnetometer.configurationCharacteristic, enabled: false)
    }
    
    func magnetometer(magnetometer: STGMagnetometer, didUpdateMagneticFieldStrength magneticFieldStrength: STGVector)
    {
        self.delegate.sensorTag(self, didUpdateMagneticFieldStrength: magneticFieldStrength)
    }

    // MARK: STGSimpleKeysServiceDelegate

    func simpleKeysServiceEnable(simpleKeysService: STGSimpleKeysService)
    {
        self.updateSensorNotificationsEnabledState(self.simpleKeysService.dataCharacteristic, enabled: true)
    }
    
    func simpleKeysServiceDisable(simpleKeysService: STGSimpleKeysService)
    {
        self.updateSensorNotificationsEnabledState(self.simpleKeysService.dataCharacteristic, enabled: false)
    }
    
    func simpleKeysService(simpleKeysService: STGSimpleKeysService, didUpdateState state: STGSimpleKeysState?)
    {
        self.delegate.sensorTag(self, didUpdateSimpleKeysState: state)
    }
    
    // MARK: STGTemperatureSensorDelegate
    
    func temperatureSensorEnable(temperatureSensor: STGTemperatureSensor, measurementPeriod period: Int)
    {
        self.updateSensorEnabledState(self.temperatureSensor.configurationCharacteristic, enabled: true)
        
        self.updateSensorMeasurementPeriod(self.temperatureSensor.periodCharacteristic, periodInMilliseconds: period)

        self.updateSensorNotificationsEnabledState(self.temperatureSensor.dataCharacteristic, enabled: true)
    }
    
    func temperatureSensorDisable(temperatureSensor: STGTemperatureSensor)
    {
        self.updateSensorEnabledState(self.temperatureSensor.configurationCharacteristic, enabled: false)
    }
    
    func temperatureSensor(temperatureSensor: STGTemperatureSensor, didUpdateAmbientTemperature temperature: Float)
    {
        self.delegate.sensorTag(self, didUpdateAmbientTemperature: temperature)
    }
    
    // MARK:

    func updateSensorEnabledState(configurationCharacteristic : CBCharacteristic?, enabled : Bool)
    {
        let byte : UInt8
        
        if (enabled == true)
        {
            byte = STGConstants.sensorEnableByte
        }
        else
        {
            byte = STGConstants.sensorDisableByte
        }
        
        self.writeByte(configurationCharacteristic, byte: byte)
    }

    func writeByte(configurationCharacteristic : CBCharacteristic?, byte : UInt8)
    {
        if let characteristic : CBCharacteristic = configurationCharacteristic
        {
            let value : NSData = NSData(bytes: [byte] as [UInt8], length: 1)
            
            self.peripheral.writeValue(value, forCharacteristic: characteristic, type: .WithResponse)
        }
    }
    
    func updateSensorNotificationsEnabledState(dataCharacteristic : CBCharacteristic?, enabled : Bool)
    {
        if let characteristic : CBCharacteristic = dataCharacteristic
        {
            self.peripheral.setNotifyValue(enabled, forCharacteristic: characteristic)
        }
    }
    
    func updateSensorMeasurementPeriod(periodCharacteristic : CBCharacteristic?, periodInMilliseconds : Int)
    {
        if let characteristic : CBCharacteristic = periodCharacteristic
        {
            let period : UInt8  = UInt8(periodInMilliseconds / 10)
         
            let periodValue : NSData = NSData(bytes: [period] as [UInt8], length: 1)
        
            self.peripheral.writeValue(periodValue, forCharacteristic: characteristic, type: .WithResponse)
        }
    }
}















