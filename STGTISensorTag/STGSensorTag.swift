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
        self.temperatureSensor = STGTemperatureSensor(delegate: self)
    }

    public func discoverServices()
    {
        self.peripheral.delegate = self;
        self.peripheral.discoverServices(nil)
    }

    // MARK: CBPeripheralDelegate
    
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
    
    // MARK: STGAccelerometerDelegate
    
    func accelerometer(accelerometer: STGAccelerometer, updateEnabledStateTo enabled: Bool)
    {
        self.updateSensorEnabledState(self.accelerometer.configurationCharacteristic, enabled: enabled)

        self.updateSensorNotificationsEnabledState(self.accelerometer.dataCharacteristic, enabled: enabled)

        self.updateSensorMeasurementPeriod(self.accelerometer.periodCharacteristic, periodInMilliseconds: STGConstants.Accelerometer.measurementPeriodInMilliseconds)
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
    
    func barometricPressureSensor(sensor: STGBarometricPressureSensor, updateEnabledStateTo enabled: Bool)
    {
        self.updateSensorEnabledState(self.barometricPressureSensor.configurationCharacteristic, enabled: enabled)
        
        self.updateSensorNotificationsEnabledState(self.barometricPressureSensor.dataCharacteristic, enabled: enabled)
    }
    
    // MARK: STGGyroscopeDelegate
    
    func gyroscope(gyroscope: STGGyroscope, updateEnabledStateTo enabled: Bool)
    {
        self.writeByte(self.gyroscope.configurationCharacteristic, byte: STGConstants.Gyroscope.enableByte)
        
        self.updateSensorNotificationsEnabledState(self.gyroscope.dataCharacteristic, enabled: enabled)
    }

    func gyroscope(gyroscope: STGGyroscope, didUpdateAngularVelocity angularVelocity: STGVector)
    {
        self.delegate.sensorTag(self, didUpdateAngularVelocity: angularVelocity)
    }
    
    // MARK: STGHumiditySensorDelegate

    func humiditySensor(humiditySensor: STGHumiditySensor, updateEnabledStateTo enabled: Bool)
    {
        self.updateSensorEnabledState(self.humiditySensor.configurationCharacteristic, enabled: enabled)
        
        self.updateSensorNotificationsEnabledState(self.humiditySensor.dataCharacteristic, enabled: enabled)
    }
    
    func humiditySensor(humiditySensor: STGHumiditySensor, didUpdateRelativeHumidity relativeHumidity: Float)
    {
        self.delegate.sensorTag(self, didUpdateRelativeHumidity: relativeHumidity)
    }
    
    // MARK: STGMagnetometerDelegate
    
    func magnetometer(magnetometer: STGMagnetometer, updateEnabledStateTo enabled: Bool)
    {
        self.updateSensorEnabledState(self.magnetometer.configurationCharacteristic, enabled: enabled)
        
        self.updateSensorNotificationsEnabledState(self.magnetometer.dataCharacteristic, enabled: enabled)
    }
    
    func magnetometer(magnetometer: STGMagnetometer, didUpdateMagneticFieldStrength magneticFieldStrength: STGVector)
    {
        self.delegate.sensorTag(self, didUpdateMagneticFieldStrength: magneticFieldStrength)
    }

    // MARK: STGTemperatureSensorDelegate
    
    func temperatureSensor(temperatureSensor: STGTemperatureSensor, updateEnabledStateTo enabled: Bool)
    {
        self.updateSensorEnabledState(self.temperatureSensor.configurationCharacteristic, enabled: enabled)
        
        self.updateSensorNotificationsEnabledState(self.temperatureSensor.dataCharacteristic, enabled: enabled)
    }
    
    func temperatureSensor(temperatureSensor: STGTemperatureSensor, didUpdateTemperature temperature: Float)
    {
        self.delegate.sensorTag(self, didUpdateTemperature: temperature)
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

        case self.temperatureSensor.serviceUUID:
            self.temperatureSensor.characteristicUpdated(characteristic)

        default:
            break
        }
    }
    
}















