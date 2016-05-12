//
//  STGAccelerometerDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGAccelerometerDelegate : class
{
    func accelerometer(accelerometer : STGAccelerometer, updateEnabledStateTo enabled : Bool)

    func accelerometer(accelerometer : STGAccelerometer, didUpdateAcceleration acceleration : STGVector)
}
