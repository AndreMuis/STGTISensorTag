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
        
        if (state == .PoweredOn)
        {
            do
            {
                try self.centralManager.startScanningForSensorTags()
            }
            catch let error
            {
                print(error)
            }
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
        print("didDisconnectSensorTagPeripheral")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForAccelerometer accelerometer: STGAccelerometer)
    {
        // accelerometer.enable()
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForBarometricPressureSensor sensor: STGBarometricPressureSensor)
    {
        // sensor.enable()
    }

    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForGyroscope gyroscope: STGGyroscope)
    {
        // gyroscope.enable()
    }

    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForHumiditySensor humiditySensor: STGHumiditySensor)
    {
        // humiditySensor.enable()
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForMagnetometer magnetometer: STGMagnetometer)
    {
        // magnetometer.enable()
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForTemperatureSensor temperatureSensor: STGTemperatureSensor)
    {
        temperatureSensor.enable()
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateAcceleration acceleration: STGVector)
    {
        print("acceleration = \(acceleration)")
    }

    func sensorTag(sensorTag: STGSensorTag, didUpdateSmoothedAcceleration acceleration: STGVector)
    {
        print("smoothed acceleration = \(acceleration)")
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
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateTemperature temperature: Float)
    {
        print("temperature = \(temperature)")
    }
}




















