//
//  STGGyroscopeDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/13/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGGyroscopeDelegate : class
{
    func gyroscope(gyroscope : STGGyroscope, updateEnabledStateTo enabled : Bool)

    func gyroscope(gyroscope : STGGyroscope, didUpdateAngularVelocity angularVelocity : STGVector)
}
