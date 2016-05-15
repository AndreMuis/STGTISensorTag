//
//  STGCentralManagerState.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/10/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public typealias STGCentralManagerState = CBCentralManagerState

public extension STGCentralManagerState
{
    var desscription : String
    {
        get
        {
            switch self
            {
            case Unknown:
                return "Unknown"
                
            case Resetting:
                return "Resetting"

            case Unsupported:
                return "Unsupported"
            
            case Unauthorized:
                return "Unauthorized"
            
            case PoweredOff:
                return "Powered Off"
            
            case PoweredOn:
                return "Powered On"
            }
        }
    }
}