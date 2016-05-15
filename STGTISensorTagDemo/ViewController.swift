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
    @IBOutlet weak var centralManagerStateLabel: UILabel!
    @IBOutlet weak var connectionStatusLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    var centralManager : STGCentralManager!
    var sensorTag : STGSensorTag?
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.centralManager = STGCentralManager(delegate: self)
        self.sensorTag = nil
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.centralManagerStateLabel.text = self.centralManager.state?.desscription
        self.connectionStatusLabel.text = self.centralManager.connectionStatus?.rawValue
    }
    
    @IBAction func readRSSIButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag!.readRSSI()
        }
    }
    
    @IBAction func enableAccelerometerButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.accelerometer.enable(measurementPeriodInMilliseconds: 300, lowPassFilteringFactor: STGConstants.Accelerometer.lowPassFilteringFactor)
        }
    }
    
    @IBAction func disableAccelerometerButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.accelerometer.disable()
        }
    }
    
    @IBAction func enableBarometricPressureSensorButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.barometricPressureSensor.enable(measurementPeriodInMilliseconds: 300)
        }
    }
    
    @IBAction func disableBarometricPressureSensorButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.barometricPressureSensor.disable()
        }
    }
    
    @IBAction func enableGyroscopeButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.gyroscope.enable(measurementPeriodInMilliseconds: 300)
        }
    }
    
    @IBAction func disableGyroscopeButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.gyroscope.disable()
        }
    }
    
    @IBAction func enableHumiditySensorButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.humiditySensor.enable(measurementPeriodInMilliseconds: 300)
        }
    }
    
    @IBAction func disableHumiditySensorButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.humiditySensor.disable()
        }
    }
    
    @IBAction func enableMagnetometerButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.magnetometer.enable(measurementPeriodInMilliseconds: 300)
        }
    }
    
    @IBAction func disableMagnetometerButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.magnetometer.disable()
        }
    }
    
    @IBAction func enableSimpleKeysServiceButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.simpleKeysService.enable()
        }
    }
    
    @IBAction func disableSimpleKeysServiceButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.simpleKeysService.disable()
        }
    }
    
    @IBAction func enableTemperatureSensorButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.temperatureSensor.enable(measurementPeriodInMilliseconds: 300)
        }
    }
    
    @IBAction func disableTemperatureSensorButtonTapped(sender: AnyObject)
    {
        if self.sensorTag != nil
        {
            self.sensorTag?.temperatureSensor.disable()
        }
    }
    
    // MARK: STGCentralManagerDelegate
    
    func centralManagerDidUpdateState(state: STGCentralManagerState)
    {
        self.centralManagerStateLabel.text = state.desscription
        
        if (state == .PoweredOn)
        {
            self.centralManager.startScanningForSensorTags()
        }        
    }

    func centralManagerDidUpdateConnectionStatus(status: STGCentralManagerConnectionStatus)
    {
        self.connectionStatusLabel.text = status.rawValue
    }

    func centralManager(central: STGCentralManager, didConnectSensorTagPeripheral peripheral: CBPeripheral)
    {
        self.sensorTag = STGSensorTag(delegate: self, peripheral: peripheral)
        
        self.sensorTag!.discoverServices()
    }
    
    func centralManager(central: STGCentralManager, didDisconnectSensorTagPeripheral peripheral: CBPeripheral)
    {
        self.sensorTag = nil
    }
    
    func centralManager(central: STGCentralManager, didEncounterError error: NSError)
    {
        print(error)
    }

    // MARK: STGSensorTagDelegate

    func sensorTag(sensorTag: STGSensorTag, didUpdateRSSI rssi: NSNumber)
    {
        self.rssiLabel.text = rssi.stringValue
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForAccelerometer accelerometer: STGAccelerometer)
    {
        print("sensor tag discovered characteristics for accelerometer")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForBarometricPressureSensor sensor: STGBarometricPressureSensor)
    {
        print("sensor tag discovered characteristics for barometric pressure sensor")
    }

    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForGyroscope gyroscope: STGGyroscope)
    {
        print("sensor tag discovered characteristics for gyroscope")
    }

    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForHumiditySensor humiditySensor: STGHumiditySensor)
    {
        print("sensor tag discovered characteristics for humidity sensor")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForMagnetometer magnetometer: STGMagnetometer)
    {
        print("sensor tag discovered characteristics for magnetometer")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForSimpleKeysService simpleKeysService: STGSimpleKeysService)
    {
        print("sensor tag discovered characteristics for simple keys service")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didDiscoverCharacteristicsForTemperatureSensor temperatureSensor: STGTemperatureSensor)
    {
        print("sensor tag discovered characteristics for temperature sensor")
    }
    
    
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateAcceleration acceleration: STGVector)
    {
        print("acceleration = \(acceleration) g")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateSmoothedAcceleration acceleration: STGVector)
    {
        // print("smoothed acceleration = \(acceleration) g")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdatePressure pressure: Int)
    {
        print("pressure = \(pressure) millibars")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateAngularVelocity angularVelocity: STGVector)
    {
        print("angular velocity = \(angularVelocity) degrees / sec")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateRelativeHumidity relativeHumidity: Float)
    {
        print("relative humidity = \(relativeHumidity)%")
    }
    
    func sensorTag(sensorTag : STGSensorTag, didUpdateMagneticFieldStrength magneticFieldStrength : STGVector)
    {
        print("magnetic field strength = \(magneticFieldStrength) microteslas")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateSimpleKeysState state: STGSimpleKeysState?)
    {
        if let someState = state
        {
            print("simple keys state = \(someState.desscription)")
        }
    }
    
    func sensorTag(sensorTag: STGSensorTag, didUpdateAmbientTemperature temperature: Float)
    {
        print("ambient temperature = \(temperature) degrees Celsius")
    }
    
    func sensorTag(sensorTag: STGSensorTag, didEncounterError error: NSError)
    {
        print(error)
    }
    
    // MARK:
}




















