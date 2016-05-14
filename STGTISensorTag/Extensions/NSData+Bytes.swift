//
//  NSData+Bytes.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/13/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import UIKit

extension NSData
{
    var unsignedIntegers : [UInt8]
    {
        let byteCount = self.length / sizeof(UInt8)
        
        var bytes = [UInt8](count: byteCount, repeatedValue: 0)
        
        self.getBytes(&bytes, length: byteCount * sizeof(UInt8))
    
        return bytes
    }

    var signedIntegers : [Int8]
    {
        let byteCount = self.length / sizeof(Int8)
        
        var bytes = [Int8](count: byteCount, repeatedValue: 0)
        
        self.getBytes(&bytes, length: byteCount * sizeof(Int8))
        
        return bytes
    }
}
