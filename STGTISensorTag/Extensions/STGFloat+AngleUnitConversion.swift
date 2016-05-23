//
//  STGFloat+AngleUnits.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/22/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

public extension Float
{
    var degreesToRadians : Float
    {
        return self * (Float(M_PI) / 180.0)
    }
}
