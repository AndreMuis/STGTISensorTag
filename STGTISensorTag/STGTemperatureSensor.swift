//
//  STGTemperatureSensor.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public class STGTemperatureSensor
{
    weak var delegate : STGTemperatureSensorDelegate?

    let serviceUUID : CBUUID
    var service : CBService?
    
    let dataCharacteristicUUID : CBUUID
    var dataCharacteristic : CBCharacteristic?
    
    let configurationCharacteristicUUID : CBUUID
    var configurationCharacteristic : CBCharacteristic?
    
    let periodCharacteristicUUID : CBUUID
    var periodCharacteristic : CBCharacteristic?

    init(delegate : STGTemperatureSensorDelegate)
    {
        self.delegate = delegate
        
        self.serviceUUID = CBUUID(string: STGConstants.TemperatureSensor.serviceUUIDString)
        self.service = nil
        
        self.dataCharacteristicUUID = CBUUID(string: STGConstants.TemperatureSensor.dataCharacteristicUUIDString)
        self.dataCharacteristic = nil
        
        self.configurationCharacteristicUUID = CBUUID(string: STGConstants.TemperatureSensor.configurationCharacteristicUUIDString)
        self.configurationCharacteristic = nil
        
        self.periodCharacteristicUUID = CBUUID(string: STGConstants.TemperatureSensor.configurationCharacteristicUUIDString)
        self.periodCharacteristic = nil
    }
    
    public func enable()
    {
        self.delegate?.temperatureSensor(self, updateEnabledStateTo: true)
    }
    
    public func disable()
    {
        self.delegate?.temperatureSensor(self, updateEnabledStateTo: false)
    }
    
    func characteristicUpdated(characteristic : CBCharacteristic)
    {
        if let value = characteristic.value
        {
            if characteristic.UUID == self.dataCharacteristicUUID
            {
                let temperature : Float = self.temperatureWithCharacteristicValue(value)
                
                self.delegate?.temperatureSensor(self, didUpdateTemperature: temperature)
            }
        }
    }

    func temperatureWithCharacteristicValue(characteristicValue : NSData) -> Float
    {
        let bytes : [UInt8] = characteristicValue.unsignedIntegers
        
        let temperatureRaw : Int16 = Int16(truncatingBitPattern: UInt32(bytes[2] & 0xff) | ((UInt32(bytes[3]) << 8) & 0xff00))
        
        let tempertaure : Float = Float(temperatureRaw) / 128.0
        
        return tempertaure
    }
}























