//
//  STGCentralManager.swift
//  STGTISensorTag
//
//  Created by Andre Muis on 5/9/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth

public class STGCentralManager : NSObject, CBCentralManagerDelegate
{
    weak var delegate : STGCentralManagerDelegate!
    var centralManager : CBCentralManager!
    public var state : STGCentralManagerState!
    
    public var connectionStatus : STGCentralManagerConnectionStatus!
    {
        willSet(newStatus)
        {
            self.delegate.centralManagerDidUpdateConnectionStatus(newStatus!)
        }
    }
    
    var peripheral : CBPeripheral?

    public init(delegate : STGCentralManagerDelegate)
    {
        super.init()

        self.delegate = delegate
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        self.state = STGCentralManagerState.Unknown
        self.connectionStatus = STGCentralManagerConnectionStatus.None
        self.peripheral = nil
    }

    public func startScanningForSensorTags()
    {
        self.centralManager.scanForPeripheralsWithServices(nil, options: nil)
        
        self.connectionStatus = .Scanning
    }
    
    public func stopScanningForSensorTags()
    {
        self.centralManager.stopScan()
        
        self.connectionStatus = .None
    }
    
    // MARK: CBCentralManagerDelegate
    
    public func centralManagerDidUpdateState(central: CBCentralManager)
    {
        self.state = central.state
        
        self.delegate.centralManagerDidUpdateState(central.state as STGCentralManagerState)
    }
    
    public func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber)
    {
        if let localName = advertisementData[STGConstants.advertisementDataLocalNameKey] as? String
        {
            if localName == STGConstants.advertisementDataLocalNameValue
            {
                self.peripheral = peripheral
                self.centralManager.connectPeripheral(peripheral, options: nil)
                
                self.connectionStatus = .Connecting
            }
        }
    }

    public func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral)
    {
        self.centralManager.stopScan()

        self.connectionStatus = .Connected

        self.delegate.centralManager(self, didConnectSensorTagPeripheral: peripheral)
    }
    
    public func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?)
    {
        self.peripheral = nil
        
        self.centralManager.scanForPeripheralsWithServices(nil, options: nil)
        
        self.connectionStatus = .Scanning
        
        if let someError = error
        {
            self.delegate.centralManager(self, didEncounterError: someError)
        }
        else
        {
            self.delegate.centralManager(self, didDisconnectSensorTagPeripheral: peripheral)
        }
    }

    public func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?)
    {
        self.peripheral = nil
        
        self.centralManager.scanForPeripheralsWithServices(nil, options: nil)

        self.connectionStatus = .Scanning

        if let someError = error
        {
            self.delegate.centralManager(self, didEncounterError: someError)
        }
    }
    
    // MARK:
}









    
    
    
    
    
    
    
