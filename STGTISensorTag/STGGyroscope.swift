//
//  STGGyroscope.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public class STGGyroscope
{
    weak var delegate : STGGyroscopeDelegate!

    var measurementPeriod : Int

    let serviceUUID : CBUUID
    var service : CBService?
    
    let dataCharacteristicUUID : CBUUID
    var dataCharacteristic : CBCharacteristic?
    
    let configurationCharacteristicUUID : CBUUID
    var configurationCharacteristic : CBCharacteristic?
    
    let periodCharacteristicUUID : CBUUID
    var periodCharacteristic : CBCharacteristic?

    init(delegate : STGGyroscopeDelegate)
    {
        self.delegate = delegate
       
        self.measurementPeriod = 0

        self.serviceUUID = CBUUID(string: STGConstants.Gyroscope.serviceUUIDString)
        self.service = nil
        
        self.dataCharacteristicUUID = CBUUID(string: STGConstants.Gyroscope.dataCharacteristicUUIDString)
        self.dataCharacteristic = nil
        
        self.configurationCharacteristicUUID = CBUUID(string: STGConstants.Gyroscope.configurationCharacteristicUUIDString)
        self.configurationCharacteristic = nil

        self.periodCharacteristicUUID = CBUUID(string: STGConstants.Gyroscope.periodCharacteristicUUIDString)
        self.periodCharacteristic = nil
    }
    
    public func enable(measurementPeriodInMilliseconds measurementPeriod : Int)
    {
        self.measurementPeriod = measurementPeriod
        
        self.delegate.gyroscopeEnable(self, measurementPeriod: measurementPeriod)
    }
    
    public func disable()
    {
        self.delegate.gyroscopeDisable(self)
    }

    func characteristicUpdated(characteristic : CBCharacteristic)
    {
        if let value = characteristic.value
        {
            if characteristic.UUID == self.dataCharacteristicUUID
            {
                let angularVelocity : STGVector = self.angularVelocityWithCharacteristicValue(value)
                
                self.delegate.gyroscope(self, didUpdateAngularVelocity: angularVelocity)
            }
        }
    }
    
    func angularVelocityWithCharacteristicValue(characteristicValue : NSData) -> STGVector
    {
        let bytes : [UInt8] = characteristicValue.unsignedIntegers
    
        let xRaw : Int16 = Int16(truncatingBitPattern: UInt32(bytes[0] & 0xff) | ((UInt32(bytes[1]) << 8) & 0xff00))
        var x : Float = -1.0 * ((Float(xRaw) / 65536.0) * STGConstants.Gyroscope.range)
        x = x.degreesToRadians
        
        let yRaw : Int16 = Int16(truncatingBitPattern: UInt32(bytes[2] & 0xff) | ((UInt32(bytes[3]) << 8) & 0xff00))
        var y : Float = -1.0 * ((Float(yRaw) / 65536.0) * STGConstants.Gyroscope.range)
        y = y.degreesToRadians

        let zRaw : Int16 = Int16(truncatingBitPattern: UInt32(bytes[4] & 0xff) | ((UInt32(bytes[5]) << 8) & 0xff00))
        var z : Float = (Float(zRaw) / 65536.0) * STGConstants.Gyroscope.range
        z = z.degreesToRadians
        
        let angularVelocity = STGVector(x: x, y: y, z: z)
        
        return angularVelocity
    }
}














