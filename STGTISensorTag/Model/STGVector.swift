//
//  STGVector.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

public struct STGVector : CustomStringConvertible
{
    public var x : Float
    public var y : Float
    public var z : Float
    
    public var magnitude : Float
    {
        return sqrt(x * x + y * y + z * z)
    }
    
    public var description : String
    {
        return "<\(self.x), \(self.y), \(self.z)>"
    }
}
