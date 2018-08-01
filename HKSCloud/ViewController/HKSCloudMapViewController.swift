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
    
    var m_dbMapLat: double_t?
    var m_dbMapLon: double_t?
    var m_strMaptitle: String?
    var m_locationManager : CLLocationManager!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_locationManager = CLLocationManager();
        m_locationManager.delegate = self;
        //詢問使用者是否同意給APP定位功能
        m_locationManager.requestWhenInUseAuthorization();
        //開始接收目前位置資訊
        m_locationManager.startUpdatingLocation();
        // 允許縮放地圖
        m_mvShop.isZoomEnabled = true
        // 地圖預設顯示的範圍大小 (數字越小越精確)
        let latDelta = 0.005
        let longDelta = 0.005
        let currentLocationSpan:MKCoordinateSpan =
            MKCoordinateSpanMake(latDelta, longDelta)
        let center:CLLocation = CLLocation(
            latitude: m_dbMapLat!, longitude: m_dbMapLon!)
        let currentRegion:MKCoordinateRegion =
            MKCoordinateRegion(
                center: center.coordinate,
                span: currentLocationSpan)
        m_mvShop.setRegion(currentRegion, animated: true)
        
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(
            latitude: m_dbMapLat!,
            longitude: m_dbMapLon!).coordinate
        objectAnnotation.title = m_strMaptitle
        m_mvShop.addAnnotation(objectAnnotation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus()
            == .notDetermined {
            // 取得定位服務授權
            m_locationManager.requestWhenInUseAuthorization()
            
            // 開始定位自身位置
            m_locationManager.startUpdatingLocation()
        }
            // 使用者已經拒絕定位自身位置權限
        else if CLLocationManager.authorizationStatus()
            == .denied {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController(
                title: "定位權限已關閉",
                message:
                "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.present(
                alertController,
                animated: true, completion: nil)
        }
            // 使用者已經同意定位自身位置權限
        else if CLLocationManager.authorizationStatus()
            == .authorizedWhenInUse {
            // 開始定位自身位置
            m_locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //因為ＧＰＳ功能很耗電,所以被敬執行時關閉定位功能
        m_locationManager.stopUpdatingLocation();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
