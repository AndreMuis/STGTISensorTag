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

    var measurementPeriod : Int

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
        
        self.measurementPeriod = 0

        self.serviceUUID = CBUUID(string: STGConstants.TemperatureSensor.serviceUUIDString)
        self.service = nil
        
        self.dataCharacteristicUUID = CBUUID(string: STGConstants.TemperatureSensor.dataCharacteristicUUIDString)
        self.dataCharacteristic = nil
        
        self.configurationCharacteristicUUID = CBUUID(string: STGConstants.TemperatureSensor.configurationCharacteristicUUIDString)
        self.configurationCharacteristic = nil
        
        self.periodCharacteristicUUID = CBUUID(string: STGConstants.TemperatureSensor.periodCharacteristicUUIDString)
        self.periodCharacteristic = nil
    }
    
    public func enable(measurementPeriodInMilliseconds measurementPeriod : Int)
    {
        self.measurementPeriod = measurementPeriod
        
        self.delegate?.temperatureSensorEnable(self, measurementPeriod: measurementPeriod)
    }
    
    public func disable()
    {
        self.delegate?.temperatureSensorDisable(self)
    }
    
    func characteristicUpdated(characteristic : CBCharacteristic)
    {
        if let value = characteristic.value
        {
            if characteristic.UUID == self.dataCharacteristicUUID
            {
                let ambientTemperature : Float = self.ambientTemperatureWithCharacteristicValue(value)
                
                self.delegate?.temperatureSensor(self, didUpdateAmbientTemperature: ambientTemperature)
            }
        }
    }

    func ambientTemperatureWithCharacteristicValue(characteristicValue : NSData) -> Float
    {
        let bytes : [UInt8] = characteristicValue.unsignedIntegers
        
        let temperatureRaw : Int16 = Int16(truncatingBitPattern: UInt32(bytes[2] & 0xff) | ((UInt32(bytes[3]) << 8) & 0xff00))
        
        let tempertaure : Float = Float(temperatureRaw) / 128.0
        
        return tempertaure
    }
}























