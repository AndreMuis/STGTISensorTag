//
//  STGMagnetometer.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public class STGMagnetometer
{
    weak var delegate : STGMagnetometerDelegate!

    var measurementPeriod : Int

    let serviceUUID : CBUUID
    var service : CBService?
    
    let dataCharacteristicUUID : CBUUID
    var dataCharacteristic : CBCharacteristic?
    
    let configurationCharacteristicUUID : CBUUID
    var configurationCharacteristic : CBCharacteristic?
    
    let periodCharacteristicUUID : CBUUID
    var periodCharacteristic : CBCharacteristic?
    
    init(delegate : STGMagnetometerDelegate)
    {
        self.delegate = delegate
        
        self.measurementPeriod = 0

        self.serviceUUID = CBUUID(string: STGConstants.Magnetometer.serviceUUIDString)
        self.service = nil
        
        self.dataCharacteristicUUID = CBUUID(string: STGConstants.Magnetometer.dataCharacteristicUUIDString)
        self.dataCharacteristic = nil
        
        self.configurationCharacteristicUUID = CBUUID(string: STGConstants.Magnetometer.configurationCharacteristicUUIDString)
        self.configurationCharacteristic = nil
        
        self.periodCharacteristicUUID = CBUUID(string: STGConstants.Magnetometer.periodCharacteristicUUIDString)
        self.periodCharacteristic = nil
    }
    
    public func enable(measurementPeriodInMilliseconds measurementPeriod : Int)
    {
        self.measurementPeriod = measurementPeriod
        
        self.delegate.magnetometerEnable(self, measurementPeriod: measurementPeriod)
    }
    
    public func disable()
    {
        self.delegate.magnetometerDisable(self)
    }

    func characteristicUpdated(characteristic : CBCharacteristic)
    {
        if let value = characteristic.value
        {
            if characteristic.UUID == self.dataCharacteristicUUID
            {
                let magneticField : STGVector = self.magneticFieldWithCharacteristicValue(value)
                
                self.delegate.magnetometer(self, didUpdateMagneticField: magneticField)
            }
        }
    }

    func magneticFieldWithCharacteristicValue(characteristicValue : NSData) -> STGVector
    {
        let bytes : [UInt8] = characteristicValue.unsignedIntegers
        
        let xRaw : Int16 = Int16(truncatingBitPattern: UInt32(bytes[0] & 0xff) | ((UInt32(bytes[1]) << 8) & 0xff00))
        let x : Float = -1.0 * (Float(xRaw) / 65536.0) * STGConstants.Magnetometer.range
        
        let yRaw : Int16 = Int16(truncatingBitPattern: UInt32(bytes[2] & 0xff) | ((UInt32(bytes[3]) << 8) & 0xff00))
        let y : Float = -1.0 * (Float(yRaw) / 65536.0) * STGConstants.Magnetometer.range
        
        let zRaw : Int16 = Int16(truncatingBitPattern: UInt32(bytes[4] & 0xff) | ((UInt32(bytes[5]) << 8) & 0xff00))
        let z : Float = (Float(zRaw) / 65536.0) * STGConstants.Magnetometer.range

        let magneticField : STGVector = STGVector(x: x, y: y, z: z)
        
        return magneticField
    }
}





















