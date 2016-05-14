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
    
    var oldSmoothedAcceleration : STGVector

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
        
        self.oldSmoothedAcceleration = STGVector(x: 0.0, y: 0.0, z: 0.0)
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
        if characteristic.UUID == self.dataCharacteristicUUID
        {
            if let value = characteristic.value
            {
                let acceleration : STGVector = self.accelerationWithCharacteristicValue(value)
                self.delegate?.accelerometer(self, didUpdateAcceleration: acceleration)
                
                let smoothedAcceleration : STGVector = self.smoothedAccelerationWithCharacteristicValue(value)
                self.delegate?.accelerometer(self, didUpdateSmoothedAcceleration: smoothedAcceleration)
            }
        }
    }

    func accelerationWithCharacteristicValue(characteristicValue : NSData) -> STGVector
    {
        let bytes : [UInt8] = characteristicValue.unsignedIntegers

        let acceleration : STGVector = STGVector(x: Float(bytes[0]) / (256.0 / STGConstants.Accelerometer.range),
                                                 y: Float(bytes[1]) / (256.0 / STGConstants.Accelerometer.range),
                                                 z: Float(bytes[2]) / (256.0 / STGConstants.Accelerometer.range))
        
        return acceleration
    }
    
    func smoothedAccelerationWithCharacteristicValue(characteristicValue : NSData) -> STGVector
    {
        let filteringFactor : Float = STGConstants.Accelerometer.lowPassFilteringFactor

        let acceleration : STGVector  = self.accelerationWithCharacteristicValue(characteristicValue)
        
        var smoothedAcceleration : STGVector = STGVector(x: 0.0, y: 0.0, z: 0.0)
        
        smoothedAcceleration.x = filteringFactor * acceleration.x + (1.0 - filteringFactor) * self.oldSmoothedAcceleration.x
        smoothedAcceleration.y = filteringFactor * acceleration.y + (1.0 - filteringFactor) * self.oldSmoothedAcceleration.y
        smoothedAcceleration.z = filteringFactor * acceleration.z + (1.0 - filteringFactor) * self.oldSmoothedAcceleration.z
        
        self.oldSmoothedAcceleration = smoothedAcceleration
        
        return smoothedAcceleration
    }
}






















