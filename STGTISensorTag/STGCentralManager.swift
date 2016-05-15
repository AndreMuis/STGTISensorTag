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
    var peripheral : CBPeripheral?
    
    public init(delegate : STGCentralManagerDelegate)
    {
        super.init()

        self.delegate = delegate
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        self.peripheral = nil
    }

    public func startScanningForSensorTags() throws
    {
        do
        {
            try validateState()
        }
        catch let error
        {
            throw error
        }
        
        self.centralManager.scanForPeripheralsWithServices(nil, options: nil)
        
        self.delegate.centralManagerDidUpdateConnectionStatus(.Scanning)
    }
    
    public func stopScanningForSensorTags() throws
    {
        do
        {
            try validateState()
        }
        catch let error
        {
            throw error
        }
        
        self.centralManager.stopScan()
        
        self.delegate.centralManagerDidUpdateConnectionStatus(.None)
    }
    
    func validateState() throws
    {
        switch self.centralManager.state
        {
        case .Unknown:
            fallthrough
            
        case .Resetting:
            fallthrough
            
        case .Unsupported:
            fallthrough
            
        case .Unauthorized:
            fallthrough
            
        case .PoweredOff:
            throw STGCentralManagerError.NotInPoweredOnState
            
        case .PoweredOn:
            break
        }
    }

    // MARK: CBCentralManagerDelegate
    
    public func centralManagerDidUpdateState(central: CBCentralManager)
    {
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
                
                self.delegate.centralManagerDidUpdateConnectionStatus(.Connecting)
            }
        }
    }

    public func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral)
    {
        self.centralManager.stopScan()

        self.delegate.centralManagerDidUpdateConnectionStatus(.Connected)

        self.delegate.centralManager(self, didConnectSensorTagPeripheral: peripheral)
    }
    
    public func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?)
    {
        self.peripheral = nil
        
        self.centralManager.scanForPeripheralsWithServices(nil, options: nil)
        
        self.delegate.centralManagerDidUpdateConnectionStatus(.Scanning)
        
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

        self.delegate.centralManagerDidUpdateConnectionStatus(.Scanning)

        if let someError = error
        {
            self.delegate.centralManager(self, didEncounterError: someError)
        }
    }
    
    // MARK:
}









    
    
    
    
    
    
    
