//
//  STGTemperatureSensor.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

class STGTemperatureSensor
{
    let serviceUUID : CBUUID
    var service : CBService?
    
    init()
    {
        self.serviceUUID = CBUUID(string: STGConstants.TemperatureSensor.serviceUUIDString)
        self.service = nil
        
    }
}
