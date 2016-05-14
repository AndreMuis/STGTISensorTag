//
//  STGMagnetometerDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/13/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGMagnetometerDelegate : class
{
    func magnetometer(magnetometer : STGMagnetometer, updateEnabledStateTo enabled : Bool)
    
    func magnetometer(magnetometer : STGMagnetometer, didUpdateMagneticFieldStrength magneticFieldStrength : STGVector)
}
