//
//  STGTemperatureSensorDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/13/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGTemperatureSensorDelegate : class
{
    func temperatureSensorEnable(temperatureSensor : STGTemperatureSensor, measurementPeriod period : Int)
    func temperatureSensorDisable(temperatureSensor : STGTemperatureSensor)

    func temperatureSensor(temperatureSensor : STGTemperatureSensor, didUpdateAmbientTemperature temperature : Float)
}
