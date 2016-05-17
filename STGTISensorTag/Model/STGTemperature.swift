//
//  STGTemperature.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/16/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import UIKit

public struct STGTemperature
{
    public let celsius : Float
    
    public var fahrenheit : Float
    {
        let result : Float = (9.0 / 5.0) * self.celsius + 32.0
        
        return result
    }
    
    init(celsius : Float)
    {
        self.celsius = celsius
    }
}
