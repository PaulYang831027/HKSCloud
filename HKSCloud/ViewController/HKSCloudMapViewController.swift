//
//  HKSCloudMapViewController.swift
//  HKSCloud
//
//  Created by softmobile on 2018/7/25.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HKSCloudMapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var m_mvShop: MKMapView!
    @IBOutlet var m_btnGoogleMap: UIButton!
    @IBOutlet var m_btnPhone: UIButton!
    @IBAction func showGoogleMap(_ sender: Any) {
        openMapURL()
    }
    @IBAction func call(_ sender: Any) {
        guard let number = URL(string: kPhoneURL + m_strMapPhone!) else { return }
        UIApplication.shared.open(number)
    }
    
    var m_dbMapLat: double_t?
    var m_dbMapLon: double_t?
    var m_strMapTitle: String?
    var m_strMapAddr: String!
    var m_strMapPhone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAddr()
        checkPhone()
        setShopRegion()
        addObjectAnnotation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addObjectAnnotation() {
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(
            latitude: m_dbMapLat!,
            longitude: m_dbMapLon!).coordinate
        objectAnnotation.title = m_strMapTitle
        objectAnnotation.subtitle = m_strMapAddr! + "\n " + m_strMapPhone!
        m_mvShop.addAnnotation(objectAnnotation)
    }
    
    func setShopRegion() {
        // 允許縮放地圖
        m_mvShop.isZoomEnabled = true
        // 地圖預設顯示的範圍大小 (數字越小越精確)
        let latDelta = kLatDelta
        let longDelta = kLonDelta
        let currentLocationSpan:MKCoordinateSpan =
            MKCoordinateSpanMake(latDelta, longDelta)
        let center:CLLocation = CLLocation(
            latitude: m_dbMapLat!, longitude: m_dbMapLon!)
        let currentRegion:MKCoordinateRegion =
            MKCoordinateRegion(
                center: center.coordinate,
                span: currentLocationSpan)
        m_mvShop.setRegion(currentRegion, animated: true)
    }
    
    func checkPhone() {
        if (m_strMapPhone != ""){
            m_btnPhone.isHidden = false
            m_btnPhone.setTitle(m_strMapPhone, for: .normal)
        }
    }
    
    func checkAddr() {
        if (m_strMapAddr != nil) {
            m_btnGoogleMap.isHidden = false
            m_btnGoogleMap.setTitle(m_strMapTitle, for: .normal)
        }
    }
    
    func openMapURL() {
        let address: String = m_strMapTitle!
        let urlString = kMapURL + "\(address)"
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL.init(string: escapedString!)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }

}
