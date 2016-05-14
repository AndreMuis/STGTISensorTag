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
    weak var delegate : STGMagnetometerDelegate?

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
        
        self.serviceUUID = CBUUID(string: STGConstants.Magnetometer.serviceUUIDString)
        self.service = nil
        
        self.dataCharacteristicUUID = CBUUID(string: STGConstants.Magnetometer.dataCharacteristicUUIDString)
        self.dataCharacteristic = nil
        
        self.configurationCharacteristicUUID = CBUUID(string: STGConstants.Magnetometer.configurationCharacteristicUUIDString)
        self.configurationCharacteristic = nil
        
        self.periodCharacteristicUUID = CBUUID(string: STGConstants.Magnetometer.configurationCharacteristicUUIDString)
        self.periodCharacteristic = nil
    }
    
    public func enable()
    {
        self.delegate?.magnetometer(self, updateEnabledStateTo: true)
    }
    
    public func disable()
    {
        self.delegate?.magnetometer(self, updateEnabledStateTo: false)
    }

    func characteristicUpdated(characteristic : CBCharacteristic)
    {
        if let value = characteristic.value
        {
            if characteristic.UUID == self.dataCharacteristicUUID
            {
                let magneticFieldStrength : STGVector = self.magneticFieldStrengthWithCharacteristicValue(value)
                
                self.delegate?.magnetometer(self, didUpdateMagneticFieldStrength: magneticFieldStrength)
            }
        }
    }

    func magneticFieldStrengthWithCharacteristicValue(characteristicValue : NSData) -> STGVector
    {
        let bytes : [UInt8] = characteristicValue.unsignedIntegers;
        
        let rawX : Int16 = Int16(truncatingBitPattern: UInt32(bytes[0] & 0xff) | ((UInt32(bytes[1]) << 8) & 0xff00))
        let x : Float = ((Float(rawX) * 1.0) / (65536 / STGConstants.Magnetometer.range)) * -1
        
        let rawY : Int16 = Int16(truncatingBitPattern: UInt32(bytes[2] & 0xff) | ((UInt32(bytes[3]) << 8) & 0xff00))
        let y : Float = ((Float(rawY) * 1.0) / (65536 / STGConstants.Magnetometer.range)) * -1
        
        let rawZ : Int16 = Int16(truncatingBitPattern: UInt32(bytes[4] & 0xff) | ((UInt32(bytes[5]) << 8) & 0xff00))
        let z : Float = ((Float(rawZ) * 1.0) / (65536 / STGConstants.Magnetometer.range))

        let magneticFieldStrength : STGVector = STGVector(x: x, y: y, z: z)
        
        return magneticFieldStrength
    }
}





















