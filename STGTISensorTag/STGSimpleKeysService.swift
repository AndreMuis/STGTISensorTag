//
//  STGSimpleKeysService.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/14/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public class STGSimpleKeysService
{
    weak var delegate : STGSimpleKeysServiceDelegate?
    
    let serviceUUID : CBUUID
    var service : CBService?
    
    let dataCharacteristicUUID : CBUUID
    var dataCharacteristic : CBCharacteristic?
    
    init(delegate : STGSimpleKeysServiceDelegate)
    {
        self.delegate = delegate
        
        self.serviceUUID = CBUUID(string: STGConstants.SimpleKeysService.serviceUUIDString)
        self.service = nil
        
        self.dataCharacteristicUUID = CBUUID(string: STGConstants.SimpleKeysService.dataCharacteristicUUIDString)
        self.dataCharacteristic = nil
    }
    
    public func enable()
    {
        self.delegate?.simpleKeysServiceEnable(self)
    }
    
    public func disable()
    {
        self.delegate?.simpleKeysServiceDisable(self)
    }

    func characteristicUpdated(characteristic : CBCharacteristic)
    {
        if let value = characteristic.value
        {
            if characteristic.UUID == self.dataCharacteristicUUID
            {
                let state : STGSimpleKeysState? = self.simpleKeysStateWithCharacteristicValue(value)
                
                self.delegate?.simpleKeysService(self, didUpdateState: state)
            }
        }
    }

    func simpleKeysStateWithCharacteristicValue(characteristicValue : NSData) -> STGSimpleKeysState?
    {
        let bytes : [UInt8] = characteristicValue.unsignedIntegers
        
        let simpleKeysState = STGSimpleKeysState(rawValue: bytes[0])
        
        return simpleKeysState
    }

}















