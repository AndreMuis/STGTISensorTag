//
//  STGSensorTag.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public class STGSensorTag : NSObject, CBPeripheralDelegate, STGAccelerometerDelegate
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
        self.barometricPressureSensor = STGBarometricPressureSensor()
        self.buttonSensor = STGButtonSensor()
        self.gyroscope = STGGyroscope()
        self.humiditySensor = STGHumiditySensor()
        self.magnetometer = STGMagnetometer()
        self.rssiSensor = STGRSSISensor()
        self.temperatureSensor = STGTemperatureSensor()
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
                    
                    print("didDiscoverCharacteristicsForService")
                    
                    self.delegate.sensorTag(self, didDiscoverCharacteristicsForAccelerometer: self.accelerometer)
                    
                case self.barometricPressureSensor.serviceUUID:
                    self.barometricPressureSensor.service = service

                case self.gyroscope.serviceUUID:
                    self.gyroscope.service = service
                
                case self.humiditySensor.serviceUUID:
                    self.humiditySensor.service = service
                
                case self.magnetometer.serviceUUID:
                    self.magnetometer.service = service
                
                case self.temperatureSensor.serviceUUID:
                    self.temperatureSensor.service = service
                
                default:
                    break
                }
            }
        }
    }
    
    // MARK:
    
    func accelerometer(accelerometer: STGAccelerometer, updateEnabledStateTo enabled: Bool)
    {
        self.updateSensorEnabledState(self.accelerometer.configurationCharacteristic, enabled: enabled)

        self.updateSensorNotificationsEnabledState(self.accelerometer.dataCharacteristic, enabled: enabled)
    }
    
    func accelerometer(accelerometer : STGAccelerometer, didUpdateAcceleration acceleration : STGVector)
    {
        self.delegate.sensorTag(self, didUpdateAcceleration: acceleration)
    }

    func updateSensorEnabledState(configurationCharacteristic : CBCharacteristic?, enabled : Bool)
    {
        let sensorValue : UInt8
        
        if (enabled == true)
        {
            sensorValue = STGConstants.sensorEnableValue
        }
        else
        {
            sensorValue = STGConstants.sensorDisableValue
        }
        
        let enabledValue : NSData = NSData(bytes: [sensorValue] as [UInt8], length: 1)

        if let characteristic : CBCharacteristic = configurationCharacteristic
        {
            print("updateSensorEnabledState")
            
            self.peripheral.writeValue(enabledValue, forCharacteristic: characteristic, type: .WithResponse)
        }
    }
    
    func updateSensorNotificationsEnabledState(dataCharacteristic : CBCharacteristic?, enabled : Bool)
    {
        if let characteristic : CBCharacteristic = dataCharacteristic
        {
            print("updateSensorNotificationsEnabledState")
            
            self.peripheral.setNotifyValue(enabled, forCharacteristic: characteristic)
        }
    }

    public func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?)
    {
        print("didUpdateValueForCharacteristic")
        
        switch characteristic.service.UUID
        {
        case self.accelerometer.serviceUUID:
            self.accelerometer.characteristicUpdated(characteristic)
            
        default:
            break
        }
        
        
    }
    
}




/*
 
    if (error == nil)
    {
        for (CBCharacteristic *characteristic in service.characteristics)
        {
            if ([characteristic.UUID isEqual: self.accelerometer.dataCharacteristicUUID] == YES)
            {
                self.accelerometer.dataCharacteristic = characteristic;
            }
            else if ([characteristic.UUID isEqual: self.accelerometer.configurationCharacteristicUUID] == YES)
            {
                self.accelerometer.configurationCharacteristic = characteristic;
            }
            else if ([characteristic.UUID isEqual: self.accelerometer.periodCharacteristicUUID] == YES)
            {
                self.accelerometer.periodCharacteristic = characteristic;
            }
            else if ([characteristic.UUID isEqual: self.buttonSensor.dataCharacteristicUUID] == YES)
            {
                self.buttonSensor.dataCharacteristic = characteristic;
            }
            else if ([characteristic.UUID isEqual: self.gyroscope.dataCharacteristicUUID] == YES)
            {
                self.gyroscope.dataCharacteristic = characteristic;
            }
            else if ([characteristic.UUID isEqual: self.gyroscope.configurationCharacteristicUUID] == YES)
            {
                self.gyroscope.configurationCharacteristic = characteristic;
            }
            if ([characteristic.UUID isEqual: self.magnetometer.dataCharacteristicUUID] == YES)
            {
                self.magnetometer.dataCharacteristic = characteristic;
            }
            else if ([characteristic.UUID isEqual: self.magnetometer.configurationCharacteristicUUID] == YES)
            {
                self.magnetometer.configurationCharacteristic = characteristic;
            }
            else if ([characteristic.UUID isEqual: self.magnetometer.periodCharacteristicUUID] == YES)
            {
                self.magnetometer.periodCharacteristic = characteristic;
            }
            else if ([characteristic.UUID isEqual: self.temperatureSensor.dataCharacteristicUUID] == YES)
            {
                self.temperatureSensor.dataCharacteristic = characteristic;
            }
            else if ([characteristic.UUID isEqual: self.temperatureSensor.configurationCharacteristicUUID] == YES)
            {
                self.temperatureSensor.configurationCharacteristic = characteristic;
            }
        }
        
        [self enableSensors];
    }
    else
    {
        NSLog(@"An error occurred while discovering characteristics: Error = %@", error);
    }
    }
    
    - (void)peripheral: (CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic: (CBCharacteristic *)characteristic error: (NSError *)error
{
    if (error)
    {
        NSLog(@"Error updating notification state: %@", [error localizedDescription]);
    }
    }
    
 
    - (void)peripheralDidUpdateRSSI: (CBPeripheral *)peripheral error: (NSError *)error
{
    if (error != nil)
    {
        NSLog(@"Error updating RSSI. Error = %@", [error localizedDescription]);
    }
    
    [self.rssiSensor sensorTagPeripheralDidUpdateRSSI];
    }
    
    - (void)enableSensors
        {
            if (self.accelerometer.configured == YES)
            {
                self.accelerometer.enabled = YES;
                [self.accelerometer updateWithPeriodInMilliseconds: STAccelerometerPeriodInMilliseconds];
            }
            
            if (self.buttonSensor.configured == YES)
            {
                self.buttonSensor.enabled = YES;
            }
            
            if (self.gyroscope.configured == YES)
            {
                self.gyroscope.enabled = YES;
            }
            
            if (self.magnetometer.configured == YES)
            {
                self.magnetometer.enabled = YES;
                [self.magnetometer updateWithPeriodInMilliseconds: STMagnetometerPeriodInMilliseconds];
            }
            
            if (self.rssiSensor.configured == YES)
            {
                self.rssiSensor.enabled = YES;
            }
            
            if (self.temperatureSensor.configured == YES)
            {
                self.temperatureSensor.enabled = YES;
            }
            
            [self.delegate sensorTagDidEnableSensors];
        }
        
        - (void)disableSensors
            {
                if (self.accelerometer.configured == YES)
                {
                    self.accelerometer.enabled = NO;
                }
                
                if (self.buttonSensor.configured == YES)
                {
                    self.buttonSensor.enabled = NO;
                }
                
                if (self.gyroscope.configured == YES)
                {
                    self.gyroscope.enabled = NO;
                }
                
                if (self.magnetometer.configured == YES)
                {
                    self.magnetometer.enabled = NO;
                }
                
                if (self.rssiSensor.configured == YES)
                {
                    self.rssiSensor.enabled = NO;
                }    
                
                if (self.temperatureSensor.configured == YES)
                {
                    self.temperatureSensor.enabled = NO;
                }
                
                [self.delegate sensorTagDidDisableSensors];
}

@end
*/














