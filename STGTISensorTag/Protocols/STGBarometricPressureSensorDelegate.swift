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
    
    func barometricPressureSensor(sensor : STGBarometricPressureSensor, updateEnabledStateTo enabled : Bool)
}
