//
//  LocationManager.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func didUpdate(zipCode: String)
    func didFail(error: NSError)
}

class LocationManager: NSObject {
    static let sharedInstance=LocationManager()
    private var locationManager: CLLocationManager
    weak var delegate: LocationManagerDelegate?
    
    private override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }    
}

extension LocationManager: CLLocationManagerDelegate {
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
        manager.stopUpdatingLocation()
        self.delegate?.didFail(error: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            manager.stopUpdatingLocation()
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(currentLocation) { (placemarks: [CLPlacemark]?, error) in
                if let error = error  {
                    self.delegate?.didFail(error: error as NSError)
                }
                if let placemark = placemarks?.first {
                    if let zipcode = placemark.postalCode {
                        self.delegate?.didUpdate(zipCode: zipcode)
                    }
                }
            }
        }
    }
}
