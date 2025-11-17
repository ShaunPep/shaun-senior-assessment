//
//  LocationService.swift
//  To-Do
//
//  Created by Shaun Peplar on 2025/11/15.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func locationDidChange(location: CLLocation)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private weak var delegate: LocationServiceDelegate!
    
    init(with delegate: LocationServiceDelegate) {
        super.init()
        
        self.delegate = delegate
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            getCurrentLocation()
            break
        @unknown default:
            break
        }
    }
    
    func getCurrentLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            delegate.locationDidChange(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Some Error: \(error.localizedDescription)")
    }
}
