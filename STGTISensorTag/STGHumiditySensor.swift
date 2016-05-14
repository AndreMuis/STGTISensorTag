//
//  STGHumiditySensor.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public class STGHumiditySensor
{
    weak var delegate : STGHumiditySensorDelegate?

    let serviceUUID : CBUUID
    var service : CBService?
    
    let dataCharacteristicUUID : CBUUID
    var dataCharacteristic : CBCharacteristic?
    
    let configurationCharacteristicUUID : CBUUID
    var configurationCharacteristic : CBCharacteristic?
    
    let periodCharacteristicUUID : CBUUID
    var periodCharacteristic : CBCharacteristic?
    
    init(delegate : STGHumiditySensorDelegate)
    {
        self.delegate = delegate

        self.serviceUUID = CBUUID(string: STGConstants.HumiditySensor.serviceUUIDString)
        self.service = nil
    
        self.dataCharacteristicUUID = CBUUID(string: STGConstants.HumiditySensor.dataCharacteristicUUIDString)
        self.dataCharacteristic = nil
        
        self.configurationCharacteristicUUID = CBUUID(string: STGConstants.HumiditySensor.configurationCharacteristicUUIDString)
        self.configurationCharacteristic = nil
        
        self.periodCharacteristicUUID = CBUUID(string: STGConstants.HumiditySensor.periodCharacteristicUUIDString)
        self.periodCharacteristic = nil
    }

    public func enable()
    {
        self.delegate?.humiditySensor(self, updateEnabledStateTo: true)
    }
    
    public func disable()
    {
        self.delegate?.humiditySensor(self, updateEnabledStateTo: false)
    }

    func characteristicUpdated(characteristic : CBCharacteristic)
    {
        if let value = characteristic.value
        {
            if characteristic.UUID == self.dataCharacteristicUUID
            {
                let relativeHumidity : Float = self.relativeHumidityWithCharacteristicValue(value)
                
                self.delegate?.humiditySensor(self, didUpdateRelativeHumidity: relativeHumidity)
            }
        }
    }

    func relativeHumidityWithCharacteristicValue(characteristicValue : NSData) -> Float
    {
        let bytes : [UInt8] = characteristicValue.unsignedIntegers
        
        let rawHumidity : UInt16 = UInt16(bytes[2] & 0xff) | ((UInt16(bytes[3]) << 8) & 0xff00)
        
        let relativeHumidity : Float = -6.0 + 125.0 * (Float(rawHumidity) / 65535.0)
        
        return relativeHumidity
    }
}















