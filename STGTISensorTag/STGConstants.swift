//
//  STGConstants.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/9/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

struct STGConstants
{
    static let advertisementDataLocalNameKey : String = "kCBAdvDataLocalName"
    static let advertisementDataLocalNameValue : String = "SensorTag"
    
    static let sensorEnableValue : UInt8 = 0x01
    static let sensorDisableValue : UInt8 = 0x00

    struct Accelerometer
    {
        static let serviceUUIDString : String = "F000AA10-0451-4000-B000-000000000000"

        static let dataCharacteristicUUIDString : String = "F000AA11-0451-4000-B000-000000000000"
        static let configurationCharacteristicUUIDString : String = "F000AA12-0451-4000-B000-000000000000"
        static let periodCharacteristicUUIDString : String = "F000AA13-0451-4000-b000-000000000000"
        
        static let range : Float = 4.0
        static let periodInMilliseconds : Int = 100
        static let highPassFilteringFactor : Float = 0.2
    }
    
    struct BarometricPressureSensor
    {
        static let serviceUUIDString : String = "F000AA40-0451-4000-B000-000000000000"
    }

    struct Gyroscope
    {
        static let serviceUUIDString : String = "F000AA50-0451-4000-B000-000000000000"
    }
    
    struct HumiditySensor
    {
        static let serviceUUIDString : String = "F000AA20-0451-4000-B000-000000000000"
    }
    
    struct Magnetometer
    {
        static let serviceUUIDString : String = "F000AA30-0451-4000-B000-000000000000"
    }
    
    struct TemperatureSensor
    {
        static let serviceUUIDString : String = "F000AA00-0451-4000-B000-000000000000"
    }
}
