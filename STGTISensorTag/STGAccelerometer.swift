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
    weak var delegate : STGAccelerometerDelegate!

    var measurementPeriod : Int
    var lowPassFilteringFactor : Float
    
    let serviceUUID : CBUUID
    var service : CBService?

    let dataCharacteristicUUID : CBUUID
    var dataCharacteristic : CBCharacteristic?
    
    let configurationCharacteristicUUID : CBUUID
    var configurationCharacteristic : CBCharacteristic?
    
    let periodCharacteristicUUID : CBUUID
    var periodCharacteristic : CBCharacteristic?
    
    var oldSmoothedAcceleration : STGVector

    init(delegate : STGAccelerometerDelegate)
    {
        self.delegate = delegate
    
        self.measurementPeriod = 0
        self.lowPassFilteringFactor = 0.0
        
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
    
    public func enable(measurementPeriodInMilliseconds measurementPeriod : Int, lowPassFilteringFactor : Float)
    {
        self.measurementPeriod = measurementPeriod
        self.lowPassFilteringFactor = lowPassFilteringFactor
        
        self.delegate.accelerometerEnable(self, measurementPeriod: measurementPeriod)
    }
    
    public func disable()
    {
        self.delegate.accelerometerDisable(self)
    }
    
    func characteristicUpdated(characteristic : CBCharacteristic)
    {
        if characteristic.UUID == self.dataCharacteristicUUID
        {
            if let value = characteristic.value
            {
                let acceleration : STGVector = self.accelerationWithCharacteristicValue(value)
                self.delegate.accelerometer(self, didUpdateAcceleration: acceleration)
                
                let smoothedAcceleration : STGVector = self.smoothedAccelerationWithCharacteristicValue(value)
                self.delegate.accelerometer(self, didUpdateSmoothedAcceleration: smoothedAcceleration)
            }
        }
    }

    func accelerationWithCharacteristicValue(characteristicValue : NSData) -> STGVector
    {
        let bytes : [Int8] = characteristicValue.signedIntegers

        let acceleration : STGVector = STGVector(x: -1.0 * (Float(bytes[0]) / 64.0) * STGConstants.Accelerometer.range,
                                                 y: -1.0 * (Float(bytes[1]) / 64.0) * STGConstants.Accelerometer.range,
                                                 z: -1.0 * (Float(bytes[2]) / 64.0) * STGConstants.Accelerometer.range)
        
        return acceleration
    }
    
    func smoothedAccelerationWithCharacteristicValue(characteristicValue : NSData) -> STGVector
    {
        let acceleration : STGVector  = self.accelerationWithCharacteristicValue(characteristicValue)
        
        var smoothedAcceleration : STGVector = STGVector(x: 0.0, y: 0.0, z: 0.0)
        
        smoothedAcceleration.x = self.lowPassFilteringFactor * acceleration.x + (1.0 - self.lowPassFilteringFactor) * self.oldSmoothedAcceleration.x
        smoothedAcceleration.y = self.lowPassFilteringFactor * acceleration.y + (1.0 - self.lowPassFilteringFactor) * self.oldSmoothedAcceleration.y
        smoothedAcceleration.z = self.lowPassFilteringFactor * acceleration.z + (1.0 - self.lowPassFilteringFactor) * self.oldSmoothedAcceleration.z
        
        self.oldSmoothedAcceleration = smoothedAcceleration
        
        return smoothedAcceleration
    }
}






















