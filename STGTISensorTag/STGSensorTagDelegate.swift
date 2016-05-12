//
//  STGSensorTagDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

public protocol STGSensorTagDelegate : class
{
    func sensorTag(sensorTag : STGSensorTag, didDiscoverCharacteristicsForAccelerometer accelerometer : STGAccelerometer)
    func sensorTag(sensorTag : STGSensorTag, didUpdateAcceleration acceleration : STGVector)
}












