//
//  STGCentralManagerDelegate.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/10/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public protocol STGCentralManagerDelegate
{
    func centralManagerDidUpdateState(state: STGCentralManagerState)

    func centralManagerDidUpdateConnectionStatus(status: STGCentralManagerConnectionStatus)
    
    func centralManager(central: STGCentralManager, didConnectPeripheral peripheral: CBPeripheral)

    func centralManager(central: STGCentralManager, didDisconnectPeripheral peripheral: CBPeripheral)
}
