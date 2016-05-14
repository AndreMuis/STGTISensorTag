//
//  STGAccelerometerDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGAccelerometerDelegate : class
{
    func accelerometerEnable(accelerometer : STGAccelerometer, measurementPeriod period : Int)
    func accelerometerDisable(accelerometer : STGAccelerometer)
    
    func accelerometer(accelerometer : STGAccelerometer, didUpdateAcceleration acceleration : STGVector)
    func accelerometer(accelerometer : STGAccelerometer, didUpdateSmoothedAcceleration acceleration : STGVector)
}
