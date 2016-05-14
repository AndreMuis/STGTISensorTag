//
//  STGGyroscopeDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/13/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGGyroscopeDelegate : class
{
    func gyroscopeEnable(gyroscope : STGGyroscope, measurementPeriod period : Int)
    func gyroscopeDisable(gyroscope : STGGyroscope)

    func gyroscope(gyroscope : STGGyroscope, didUpdateAngularVelocity angularVelocity : STGVector)
}
