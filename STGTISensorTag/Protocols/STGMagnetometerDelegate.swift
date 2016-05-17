//
//  STGMagnetometerDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/13/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGMagnetometerDelegate : class
{
    func magnetometerEnable(magnetometer : STGMagnetometer, measurementPeriod period : Int)
    func magnetometerDisable(magnetometer : STGMagnetometer)

    func magnetometer(magnetometer : STGMagnetometer, didUpdateMagneticField magneticField : STGVector)
}
