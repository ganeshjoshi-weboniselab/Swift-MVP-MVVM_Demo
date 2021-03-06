//
//  GPSLocationHandler.swift
//  SPMVPDemo
//
//  Created by webonise on 04/10/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit

import CoreLocation

protocol LocationServiceDelegate
{
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
}

class GPSLocationHandler: NSObject, CLLocationManagerDelegate
{
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var delegate: LocationServiceDelegate?
    
    class var sharedInstance: GPSLocationHandler
    {
        struct Static
        {
            static var onceToken: dispatch_once_t = 0
            
            static var instance: GPSLocationHandler? = nil
        }
        
        dispatch_once(&Static.onceToken)
        {
            Static.instance = GPSLocationHandler()
        }
        
        return Static.instance!
    }
    
    override init()
    {
        super.init()
        
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager
        else
        {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .NotDetermined
        {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        locationManager.distanceFilter = 200 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        locationManager.delegate = self
    }
    
    func startUpdatingLocation()
    {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation()
    {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        guard let location = locations.last else
        {
            return
        }
        
        // singleton for get last location
        self.lastLocation = location
        
        // use for real time update location
        updateLocation(location)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        // do on error
        updateLocationDidFailWithError(error)
    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation)
    {
        guard let delegate = self.delegate
        else
        {
            return
        }
        
        delegate.tracingLocation(currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError)
    {
        
        guard let delegate = self.delegate
        else
        {
            return
        }
        
        delegate.tracingLocationDidFailWithError(error)
    }
}
