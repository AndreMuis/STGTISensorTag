//
//  STGAccelerometer.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public class STGAccelerometer
{
    let serviceUUID : CBUUID
    var service : CBService?

    let dataCharacteristicUUID : CBUUID
    var dataCharacteristic : CBCharacteristic?
    
    let configurationCharacteristicUUID : CBUUID
    var configurationCharacteristic : CBCharacteristic?
    
    let periodCharacteristicUUID : CBUUID
    var periodCharacteristic : CBCharacteristic?
    
    weak var delegate : STGAccelerometerDelegate?
    
    var rollingAcceleration : STGVector

    init(delegate : STGAccelerometerDelegate)
    {
        self.delegate = delegate
        
        self.serviceUUID = CBUUID(string: STGConstants.Accelerometer.serviceUUIDString)
        self.service = nil
        
        self.dataCharacteristicUUID = CBUUID(string: STGConstants.Accelerometer.dataCharacteristicUUIDString)
        self.dataCharacteristic = nil
        
        self.configurationCharacteristicUUID = CBUUID(string: STGConstants.Accelerometer.configurationCharacteristicUUIDString)
        self.configurationCharacteristic = nil
        
        self.periodCharacteristicUUID = CBUUID(string: STGConstants.Accelerometer.periodCharacteristicUUIDString)
        self.periodCharacteristic = nil
        
        self.rollingAcceleration = STGVector(x: 0.0, y: 0.0, z: 0.0)
    }
    
    public func enable()
    {
        self.delegate?.accelerometer(self, updateEnabledStateTo: true)
    }
    
    public func disable()
    {
        self.delegate?.accelerometer(self, updateEnabledStateTo: false)
    }
    
    func characteristicUpdated(characteristic : CBCharacteristic)
    {
        print("characteristicUpdated")
        
        if characteristic.UUID == self.dataCharacteristicUUID
        {
            if let value = characteristic.value
            {
                let acceleration : STGVector = self.accelerationWithCharacteristicValue(value)
                self.delegate?.accelerometer(self, didUpdateAcceleration: acceleration)
            }
            
            //[self.sensorTagDelegate sensorTagDidUpdateSmoothedAcceleration: [self smoothedAccelerationWithCharacteristicValue: characteristic.value]];
        }
    }

    func accelerationWithCharacteristicValue(characteristicValue : NSData) -> STGVector
    {
        let byteCount = characteristicValue.length / sizeof(UInt8)
        
        var bytes = [UInt8](count: byteCount, repeatedValue: 0)
        
        characteristicValue.getBytes(&bytes, length: byteCount * sizeof(UInt8))

        let acceleration : STGVector = STGVector(x: Float(bytes[0]) / (256.0 / STGConstants.Accelerometer.range),
                                                 y: Float(bytes[1]) / (256.0 / STGConstants.Accelerometer.range),
                                                 z: Float(bytes[2]) / (256.0 / STGConstants.Accelerometer.range))
        
        return acceleration
    }
    

    /*
    
    - (void)updateWithPeriodInMilliseconds: (int)periodInMilliseconds
    {
    uint8_t periodData = (uint8_t)(periodInMilliseconds / 10);
    [self.sensorTagPeripheral writeValue: [NSData dataWithBytes: &periodData length: 1]
    forCharacteristic: self.periodCharacteristic
    type: CBCharacteristicWriteWithResponse];
    }
    
    - (STAcceleration *)smoothedAccelerationWithCharacteristicValue: (NSData *)characteristicValue
    {
    STAcceleration *acceleration = [self accelerationWithCharacteristicValue: characteristicValue];
    
    self.rollingAcceleration.xComponent = (acceleration.xComponent * STAccelerometerHighPassFilteringFactor) +
    (self.rollingAcceleration.xComponent * (1.0 - STAccelerometerHighPassFilteringFactor));
    
    self.rollingAcceleration.yComponent = (acceleration.yComponent * STAccelerometerHighPassFilteringFactor) +
    (self.rollingAcceleration.yComponent * (1.0 - STAccelerometerHighPassFilteringFactor));
    
    self.rollingAcceleration.zComponent = (acceleration.zComponent * STAccelerometerHighPassFilteringFactor) +
    (self.rollingAcceleration.zComponent * (1.0 - STAccelerometerHighPassFilteringFactor));
    
    acceleration.xComponent = acceleration.xComponent - self.rollingAcceleration.xComponent;
    acceleration.yComponent = acceleration.yComponent - self.rollingAcceleration.yComponent;
    acceleration.zComponent = acceleration.zComponent - self.rollingAcceleration.zComponent;
    
    return acceleration;
    }
    
    @end
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
}
