//
//  STGBarometricPressureSensor.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public class STGBarometricPressureSensor
{
    weak var delegate : STGBarometricPressureSensorDelegate!
    
    var measurementPeriod : Int

    let serviceUUID : CBUUID
    var service : CBService?

    let dataCharacteristicUUID : CBUUID
    var dataCharacteristic : CBCharacteristic?

    let configurationCharacteristicUUID : CBUUID
    var configurationCharacteristic : CBCharacteristic?

    let calibrationCharacteristicUUID : CBUUID
    var calibrationCharacteristic : CBCharacteristic?

    let periodCharacteristicUUID : CBUUID
    var periodCharacteristic : CBCharacteristic?

    var calibrationValue1 : UInt16?
    var calibrationValue2 : UInt16?
    var calibrationValue3 : UInt16?
    var calibrationValue4 : UInt16?
    var calibrationValue5 : Int16?
    var calibrationValue6 : Int16?
    var calibrationValue7 : Int16?
    var calibrationValue8 : Int16?
    
    init(delegate : STGBarometricPressureSensorDelegate)
    {
        self.delegate = delegate
        
        self.measurementPeriod = 0
        
        self.serviceUUID = CBUUID(string: STGConstants.BarometricPressureSensor.serviceUUIDString)
        self.service = nil
    
        self.dataCharacteristicUUID = CBUUID(string: STGConstants.BarometricPressureSensor.dataCharacteristicUUIDString)
        self.dataCharacteristic = nil
        
        self.configurationCharacteristicUUID = CBUUID(string: STGConstants.BarometricPressureSensor.configurationCharacteristicUUIDString)
        self.configurationCharacteristic = nil

        self.calibrationCharacteristicUUID = CBUUID(string: STGConstants.BarometricPressureSensor.calibrationCharacteristicUUIDString)
        self.calibrationCharacteristic = nil

        self.periodCharacteristicUUID = CBUUID(string: STGConstants.BarometricPressureSensor.periodCharacteristicUUIDString)
        self.periodCharacteristic = nil
    }
    
    public func enable(measurementPeriodInMilliseconds measurementPeriod : Int)
    {
        self.measurementPeriod = measurementPeriod
        
        self.delegate.barometricPressureSensorGetCalibrationValues(self)
    }
    
    public func disable()
    {
        self.delegate.barometricPressureSensorDisable(self)
    }
    
    func characteristicUpdated(characteristic : CBCharacteristic)
    {
        if let value = characteristic.value
        {
            if characteristic.UUID == self.calibrationCharacteristicUUID
            {
                self.getCalibrationValuesFromCharacteristicValue(value)
                
                self.delegate.barometricPressureSensorEnable(self, measurementPeriod: self.measurementPeriod)
            }
            else if characteristic.UUID == self.dataCharacteristicUUID
            {
                let pressure : Int = self.pressureWithCharacteristicValue(value)
             
                self.delegate.barometricPressureSensor(self, didUpdateBarometricPressure: pressure)
            }
        }
    }
    
    func getCalibrationValuesFromCharacteristicValue(characteristicValue : NSData)
    {
        let bytes : [UInt8] = characteristicValue.unsignedIntegers
        
        self.calibrationValue1 = UInt16(bytes[0] & 0xff) | ((UInt16(bytes[1]) << 8) & 0xff00)
        self.calibrationValue2 = UInt16(bytes[2] & 0xff) | ((UInt16(bytes[3]) << 8) & 0xff00)
        self.calibrationValue3 = UInt16(bytes[4] & 0xff) | ((UInt16(bytes[5]) << 8) & 0xff00)
        self.calibrationValue4 = UInt16(bytes[6] & 0xff) | ((UInt16(bytes[7]) << 8) & 0xff00)
        
        self.calibrationValue5 = Int16(truncatingBitPattern: UInt32(bytes[8] & 0xff) | ((UInt32(bytes[9]) << 8) & 0xff00))
        self.calibrationValue6 = Int16(truncatingBitPattern: UInt32(bytes[10] & 0xff) | ((UInt32(bytes[11]) << 8) & 0xff00))
        self.calibrationValue7 = Int16(truncatingBitPattern: UInt32(bytes[12] & 0xff) | ((UInt32(bytes[13]) << 8) & 0xff00))
        self.calibrationValue8 = Int16(truncatingBitPattern: UInt32(bytes[14] & 0xff) | ((UInt32(bytes[15]) << 8) & 0xff00))
    }
    
    func pressureWithCharacteristicValue(characteristicValue : NSData) -> Int
    {
        var pressureInMillibars : Int = 0
        
        if let value3 = self.calibrationValue3,
            let value4 = self.calibrationValue4,
            let value5 = self.calibrationValue5,
            let value6 = self.calibrationValue6,
            let value7 = self.calibrationValue7,
            let value8 = self.calibrationValue8
        {
            let bytes : [UInt8] = characteristicValue.unsignedIntegers
         
            let temperature : Int = Int(UInt16(bytes[0] & 0xff) | ((UInt16(bytes[1]) << 8) & 0xff00))
            
            let denominator : Int64 = (1 << 34)
            let S : Int64 = Int64(value3) + (Int64(value4) * Int64(temperature)) / Int64(1 << 17) + (Int64(value5) * Int64(temperature * temperature)) / denominator
            
            let O : Int = Int(value6) * (1 << 14) + (Int(value7) * temperature) / (1 << 3) + (Int(value8) * (temperature * temperature)) / (1 << 19)
            
            let rawPressure : Int = Int(UInt16(bytes[2] & 0xff) | ((UInt16(bytes[3]) << 8) & 0xff00))
            
            pressureInMillibars = Int((((S * Int64(rawPressure)) + Int64(O)) / (1 << 14)) / 100)
        }
        
        return pressureInMillibars
    }
}
















