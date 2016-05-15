//
//  STGSensorTagDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

public protocol STGSensorTagDelegate : class
{
    func sensorTag(sensorTag : STGSensorTag, didUpdateRSSI rssi : NSNumber)
    
    func sensorTag(sensorTag : STGSensorTag, didDiscoverCharacteristicsForAccelerometer accelerometer : STGAccelerometer)
    func sensorTag(sensorTag : STGSensorTag, didDiscoverCharacteristicsForBarometricPressureSensor sensor : STGBarometricPressureSensor)
    func sensorTag(sensorTag : STGSensorTag, didDiscoverCharacteristicsForGyroscope gyroscope : STGGyroscope)
    func sensorTag(sensorTag : STGSensorTag, didDiscoverCharacteristicsForHumiditySensor humiditySensor : STGHumiditySensor)
    func sensorTag(sensorTag : STGSensorTag, didDiscoverCharacteristicsForMagnetometer magnetometer : STGMagnetometer)
    func sensorTag(sensorTag : STGSensorTag, didDiscoverCharacteristicsForSimpleKeysService simpleKeysService : STGSimpleKeysService)
    func sensorTag(sensorTag : STGSensorTag, didDiscoverCharacteristicsForTemperatureSensor temperatureSensor : STGTemperatureSensor)
    
    func sensorTag(sensorTag : STGSensorTag, didUpdateAcceleration acceleration : STGVector)
    func sensorTag(sensorTag : STGSensorTag, didUpdateSmoothedAcceleration acceleration : STGVector)

    func sensorTag(sensorTag : STGSensorTag, didUpdatePressure pressure : Int)

    func sensorTag(sensorTag : STGSensorTag, didUpdateAngularVelocity angularVelocity : STGVector)
    
    func sensorTag(sensorTag : STGSensorTag, didUpdateRelativeHumidity relativeHumidity : Float)
    
    func sensorTag(sensorTag : STGSensorTag, didUpdateMagneticFieldStrength magneticFieldStrength : STGVector)

    func sensorTag(sensorTag : STGSensorTag, didUpdateSimpleKeysState state: STGSimpleKeysState?)

    func sensorTag(sensorTag : STGSensorTag, didUpdateAmbientTemperature temperature : Float)

    func sensorTag(sensorTag : STGSensorTag, didEncounterError error : NSError)
}












