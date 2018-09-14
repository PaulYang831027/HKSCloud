//
//  HKSCloudGoogleMapViewController.swift
//  HKSCloud
//
//  Created by softmobile on 2018/8/7.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit
import GoogleMaps

class HKSCloudGoogleMapViewController: UIViewController {
    @IBOutlet var m_vGoogleMap: GMSMapView!
    var m_dLat: Double? = nil
    var m_dLon: Double? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let m_camera = GMSCameraPosition.camera(withLatitude: m_dLat!, longitude: m_dLon!, zoom: 20.0)
        m_vGoogleMap.camera = m_camera
        
        let m_mark = GMSMarker()
        m_mark.position = CLLocationCoordinate2D(latitude: m_dLat!, longitude: m_dLon!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
