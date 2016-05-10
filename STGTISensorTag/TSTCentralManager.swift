//
//  TSTCentralManager.swift
//  TSTTISensorTag
//
//  Created by Andre Muis on 5/9/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

//@interface TSTCentralManager () <CBCentralManagerDelegate>

//@property (readonly, strong, nonatomic) id<TSTCentralManagerDelegate> delegate;

//@property (readonly, strong, nonatomic) CBCentralManager *centralManager;


class TSTCentralManager : NSObject, CBCentralManagerDelegate
{
    var centralManager : CBCentralManager!
    
    override init()
    {
        super.init()

        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(central: CBCentralManager)
    {
        // [self.delegate sensorTagManagerDidUpdateState: [central stateAsString]];
        
        if central.state == CBCentralManagerState.PoweredOn
        {
            self.centralManager.scanForPeripheralsWithServices(nil, options: nil)
            
            print("scanning")
            // [self.delegate sensorTagManagerDidUpdateConnectionStatus: STConnectionStatusScanning];
        }
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber)
    {
        if let localName = advertisementData[TSTConstants.advertisementDataLocalNameKey] as? String
        {
            if localName == TSTConstants.advertisementDataLocalNameValue
            {
                self.centralManager.connectPeripheral(peripheral, options: nil)
                
                print("connecting")
                // [self.delegate sensorTagManagerDidUpdateConnectionStatus: STConnectionStatusConnecting];
            }
            else
            {
                print("Advertisement data local name \(localName) not equal to \(TSTConstants.advertisementDataLocalNameValue)")
            }
        }
        else
        {
            print("Local name key \(TSTConstants.advertisementDataLocalNameKey) not found in advertisement data: \(advertisementData)")
        }
    }

    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral)
    {
        self.centralManager.stopScan()
            
        print("connected")
        // [self.delegate sensorTagManagerDidUpdateConnectionStatus: STConnectionStatusConnected];
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?)
    {
        if let someError = error
        {
            print("Central manager disconnected sensor tag. Error = \(someError)")
        }
        
        self.centralManager.scanForPeripheralsWithServices(nil, options: nil)
        
        // [self.delegate sensorTagManagerDidUpdateConnectionStatus: STConnectionStatusScanning];
    }

    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?)
    {
        if let someError = error
        {
            print("Central manager failed to connect to sensor tag. Error = \(someError)")
        }
        
        self.centralManager.scanForPeripheralsWithServices(nil, options: nil)
        
        // [self.delegate sensorTagManagerDidUpdateConnectionStatus: STConnectionStatusScanning];
    }
}



    
    
    
    
    
    
    
    
    
    
    
    
    
