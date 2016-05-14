//
//  STGBarometricPressureSensorDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/12/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGBarometricPressureSensorDelegate : class
{
    func barometricPressureSensorGetCalibrationValues(sensor: STGBarometricPressureSensor)
        
    func barometricPressureSensorEnable(sensor : STGBarometricPressureSensor, measurementPeriod period : Int)
    func barometricPressureSensorDisable(sensor : STGBarometricPressureSensor)
    
    func barometricPressureSensor(sensor : STGBarometricPressureSensor, didUpdatePressure pressure : Int)
}
