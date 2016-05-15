//
//  STGSimpleKeysState.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/14/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import UIKit

public enum STGSimpleKeysState : UInt8
{
    case NonePressed = 0
    case RightPressed = 1
    case LeftPressed = 2
    case BothPressed = 3
    
    public var desscription : String
    {
        get
        {
            switch self
            {
            case NonePressed:
                return "none pressed"
                
            case RightPressed:
                return "right pressed"
                
            case LeftPressed:
                return "left pressed"
                
            case BothPressed:
                return "both pressed"
            }
        }
    }

}
