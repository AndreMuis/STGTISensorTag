//
//  STGFloat+Format.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/16/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

public extension Float
{
    func format(f: String) -> String
    {
        return String(format: "%\(f)f", self)
    }
}
