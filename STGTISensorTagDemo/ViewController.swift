//
//  ViewController.swift
//  STGTISensorTagDemo
//
//  Created by Andre Muis on 5/11/16.
//  Copyright © 2016 Andre Muis. All rights reserved.
//

import CoreBluetooth
import UIKit

import STGTISensorTag

class ViewController: UIViewController, STGCentralManagerDelegate, STGSensorTagDelegate
{
    var centralManager : STGCentralManager!
    var sensorTag : STGSensorTag!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.centralManager = STGCentralManager(delegate: self)
        self.sensorTag = nil
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func centralManagerDidUpdateState(state: STGCentralManagerState)
    {
        print("STGCentralManagerState = \(state.desscription)")
        
        do
        {
            try self.centralManager.startScanningForSensorTags()
        }
        catch let error
        {
            print(error)
        }
    }
    
    func centralManagerDidUpdateConnectionStatus(status: STGCentralManagerConnectionStatus)
    {
        print("STGCentralManagerConnectionStatus = \(status.rawValue)")
    }
    
    func centralManager(central: STGCentralManager, didConnectSensorTagPeripheral peripheral: CBPeripheral)
    {
        print("didConnectSensorTagPeripheral")
        
        self.sensorTag = STGSensorTag(delegate: self, peripheral: peripheral)
        
        self.sensorTag.discoverServices()
    }
    
    func centralManager(central: STGCentralManager, didDisconnectSensorTagPeripheral peripheral: CBPeripheral)
    {
        self.sensorTag = nil

        print("didDisconnectSensorTagPeripheral")
    }
    
    func centralManager(central: STGCentralManager, didEncounterError error: NSError)
    {
        print(error)
    }
    
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForAccelerometer accelerometer: STGAccelerometer)
    {
        // accelerometer.enable(measurementPeriodInMilliseconds: 300, lowPassFilteringFactor: STGConstants.Accelerometer.lowPassFilteringFactor)
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForBarometricPressureSensor sensor: STGBarometricPressureSensor)
    {
        // sensor.enable(measurementPeriodInMilliseconds: 300)
    }

    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForGyroscope gyroscope: STGGyroscope)
    {
        // gyroscope.enable(measurementPeriodInMilliseconds: 300)
    }

    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForHumiditySensor humiditySensor: STGHumiditySensor)
    {
        // humiditySensor.enable(measurementPeriodInMilliseconds: 300)
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForMagnetometer magnetometer: STGMagnetometer)
    {
        // magnetometer.enable(measurementPeriodInMilliseconds: 300)
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForSimpleKeysService simpleKeysService: STGSimpleKeysService)
    {
        // simpleKeysService.enable()
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForTemperatureSensor temperatureSensor: STGTemperatureSensor)
    {
        temperatureSensor.enable(measurementPeriodInMilliseconds: 300)
        
        self.sensorTag.readRSSI()
    }
    
    
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateRSSI rssi: NSNumber?)
    {
        print("RSSI = \(rssi)")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateAcceleration acceleration: STGVector)
    {
        print("acceleration = \(acceleration)")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateSmoothedAcceleration acceleration: STGVector)
    {
        // print("smoothed acceleration = \(acceleration)")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdatePressure pressure: Int)
    {
        print("pressure = \(pressure)")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateAngularVelocity angularVelocity: STGVector)
    {
        print("angular velocity = \(angularVelocity)")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateRelativeHumidity relativeHumidity: Float)
    {
        print("relative humidity = \(relativeHumidity)")
    }
    
    func sensorTag(sensorTag : STGSensorTag, didUpdateMagneticFieldStrength magneticFieldStrength : STGVector)
    {
        print("magnetic field strength = \(magneticFieldStrength)")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateSimpleKeysState state: STGSimpleKeysState?)
    {
        print("simple keys state = \(state) ")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateAmbientTemperature temperature: Float)
    {
        print("ambient temperature = \(temperature)")
    }
    

    func sensorTag(sensorTag: STGSensorTag, didEncounterError error: NSError)
    {
        print(error)
    }
}




















