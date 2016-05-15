//
//  STGSensorTagError.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/15/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

enum STGSensorTagError : ErrorType
{
    case UnexpectedServiceDiscovered
    
    var code : Int
    {
        switch self
        {
        case .UnexpectedServiceDiscovered:
            return 1
            
        default:
            return 0
        }
    }
}
