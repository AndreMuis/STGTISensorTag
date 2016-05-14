//
//  STGTemperatureSensorDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/13/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGTemperatureSensorDelegate : class
{
    func temperatureSensor(temperatureSensor : STGTemperatureSensor, updateEnabledStateTo enabled : Bool)
    
    func temperatureSensor(temperatureSensor : STGTemperatureSensor, didUpdateTemperature temperature : Float)
}
