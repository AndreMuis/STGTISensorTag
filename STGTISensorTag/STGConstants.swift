//
//  STGConstants.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/9/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

public struct STGConstants
{
    static let advertisementDataLocalNameKey : String = "kCBAdvDataLocalName"
    static let advertisementDataLocalNameValue : String = "SensorTag"
    
    public static let rssiMinimum : Float = -100.0;
    public static let rssiMaximum : Float = 0.0;

    static let defaultSensorEnableByte : UInt8 = 0x01
    static let defaultSensorDisableByte : UInt8 = 0x00

    public static let defaultSensorMeasurementPeriodInMilliseconds : Int = 1000

    static let errorDomain : String = "com.AndreMuis.STGTISensorTag"
    
    public struct Accelerometer
    {
        static let serviceUUIDString : String = "F000AA10-0451-4000-B000-000000000000"

        static let dataCharacteristicUUIDString : String = "F000AA11-0451-4000-B000-000000000000"
        static let configurationCharacteristicUUIDString : String = "F000AA12-0451-4000-B000-000000000000"
        static let periodCharacteristicUUIDString : String = "F000AA13-0451-4000-b000-000000000000"
        
        static let range : Float = 4.0
        public static let lowPassFilteringFactor : Float = 0.2
    }
    
    public struct BarometricPressureSensor
    {
        static let serviceUUIDString : String = "F000AA40-0451-4000-B000-000000000000"

        static let dataCharacteristicUUIDString : String = "F000AA41-0451-4000-B000-000000000000"
        static let configurationCharacteristicUUIDString : String = "F000AA42-0451-4000-B000-000000000000"
        static let calibrationCharacteristicUUIDString : String = "F000AA43-0451-4000-B000-000000000000"
        static let periodCharacteristicUUIDString : String = "F000AA44-0451-4000-B000-000000000000"

        static let calibrationByte : UInt8 = 0x02
    }

    public struct Gyroscope
    {
        static let serviceUUIDString : String = "F000AA50-0451-4000-B000-000000000000"

        static let dataCharacteristicUUIDString : String = "F000AA51-0451-4000-B000-000000000000"
        static let configurationCharacteristicUUIDString : String = "F000AA52-0451-4000-B000-000000000000"
        static let periodCharacteristicUUIDString : String = "F000AA53-0451-4000-B000-000000000000"
        
        static let enableByte : UInt8 = 0x07
        static let range : Float = 500.0
    }
    
    public struct HumiditySensor
    {
        static let serviceUUIDString : String = "F000AA20-0451-4000-B000-000000000000"
        
        static let dataCharacteristicUUIDString : String = "F000AA21-0451-4000-B000-000000000000"
        static let configurationCharacteristicUUIDString : String = "F000AA22-0451-4000-B000-000000000000"
        static let periodCharacteristicUUIDString : String = "F000AA23-0451-4000-B000-000000000000"
    }
    
    public struct Magnetometer
    {
        static let serviceUUIDString : String = "F000AA30-0451-4000-B000-000000000000"

        static let dataCharacteristicUUIDString : String = "F000AA31-0451-4000-B000-000000000000"
        static let configurationCharacteristicUUIDString : String = "F000AA32-0451-4000-B000-000000000000"
        static let periodCharacteristicUUIDString : String = "F000AA33-0451-4000-B000-000000000000"

        static let range : Float = 2000.0
        public static let magneticFieldStrengthMinimum : Float = 0.0;
        public static let magneticFieldStrengthMaximum : Float = 300.0;
    }
    
    public struct SimpleKeysService
    {
        static let serviceUUIDString : String = "FFE0"

        static let dataCharacteristicUUIDString : String = "FFE1"
    }

    public struct TemperatureSensor
    {
        static let serviceUUIDString : String = "F000AA00-0451-4000-B000-000000000000"

        static let dataCharacteristicUUIDString : String = "F000AA01-0451-4000-B000-000000000000"
        static let configurationCharacteristicUUIDString : String = "F000AA02-0451-4000-B000-000000000000"
        static let periodCharacteristicUUIDString : String = "F000AA03-0451-4000-B000-000000000000"
    }
}





















