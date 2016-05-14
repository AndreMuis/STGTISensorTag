//
//  STGHumiditySensorDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/13/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGHumiditySensorDelegate : class
{
    func humiditySensorEnable(humiditySensor : STGHumiditySensor, measurementPeriod period : Int)
    func humiditySensorDisable(humiditySensor : STGHumiditySensor)
    
    func humiditySensor(humiditySensor : STGHumiditySensor, didUpdateRelativeHumidity relativeHumidity : Float)
}
