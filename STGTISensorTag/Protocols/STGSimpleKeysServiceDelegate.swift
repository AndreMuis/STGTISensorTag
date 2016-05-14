//
//  STGSimpleKeysServiceDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/14/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

protocol STGSimpleKeysServiceDelegate : class
{
    func simpleKeysServiceEnable(simpleKeysService : STGSimpleKeysService)
    func simpleKeysServiceDisable(simpleKeysService : STGSimpleKeysService)

    func simpleKeysService(simpleKeysService : STGSimpleKeysService, didUpdateState state: STGSimpleKeysState?)
}
