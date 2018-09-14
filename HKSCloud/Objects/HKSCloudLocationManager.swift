//
//  HKSCloudLocationManager.swift
//  HKSCloud
//
//  Created by softmobile on 2018/7/31.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class HKSCloudLocationManager: CLLocationManager, CLLocationManagerDelegate {
    
    static let shared: HKSCloudLocationManager = HKSCloudLocationManager()
    var m_callback: ((CLLocation) -> Void)?
    
    private override init() {
        super.init()
        self.delegate = self
        self.requestWhenInUseAuthorization()
    }
    
    var bStartFindLocation: Bool = false {
        didSet {
            if bStartFindLocation {
                self.startUpdatingLocation()
            } else {
                self.stopUpdatingLocation()
            }
        }
    }
    
    func getCurrent(location: @escaping (CLLocation)->Void) {
        checkLocationEnabled(enabled: {[unowned self] () in
            self.requestWhenInUseAuthorization()
            self.m_callback = location
            self.bStartFindLocation = true
            }, askToOpen: {() in
                DispatchQueue.main.async(){
                    let alertController = UIAlertController(title: kAlertTitle, message: kAlertMessage, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: kAlertOk, style: .default, handler: nil)
                    alertController.addAction(okAction)
                    UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
                    
                }
                location(CLLocation.init(latitude: kLat, longitude: kLon))
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, true == bStartFindLocation else {
            return
        }
        bStartFindLocation = false
        if (CLLocationManager.locationServicesEnabled() == false) {
            requestWhenInUseAuthorization()
        }
        m_callback?(location)
        
        m_callback = nil
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            bStartFindLocation = false
        case .authorizedAlways, .authorizedWhenInUse:
            bStartFindLocation = true
        }
    }
    
    func checkLocationEnabled(enabled: @escaping ()->Void,
                              askToOpen: @escaping ()->Void) {
        if CLLocationManager.locationServicesEnabled() == false {
            requestWhenInUseAuthorization()
            return
        }
        if CLLocationManager.locationServicesEnabled() {
            requestWhenInUseAuthorization()
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                requestWhenInUseAuthorization()
            case .restricted, .denied:
                self.requestWhenInUseAuthorization()
                askToOpen()
            case .authorizedAlways, .authorizedWhenInUse:
                enabled()
            }
        }
    }
}
