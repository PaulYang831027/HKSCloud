//
//  ViewController.swift
//  HKSCloud
//
//  Created by softmobile on 2018/6/25.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class HKSCloudViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate,CLLocationManagerDelegate {
    
    //HKSCloud未使用功能
    @IBOutlet var m_btnRestanrant: UIButton!
    @IBOutlet var m_btnBrand: UIButton!
    @IBOutlet var m_btnCoffee: UIButton!
    @IBOutlet var m_btnDepartmentStore: UIButton!
    @IBOutlet var m_btnCoupon: UIButton!
    @IBOutlet var m_btnMarket: UIButton!
    @IBOutlet var m_btnMovie: UIButton!
    @IBOutlet var m_btnMakeup: UIButton!
    
    //HKSCloud畫面
    @IBOutlet var m_vHKSCloud: UIView!
    @IBOutlet var m_aivLoading: UIActivityIndicatorView!
    @IBOutlet var m_ivMarquee: UIImageView!
    @IBOutlet var m_cvHKSCloud: UICollectionView!
    @IBOutlet var m_clHKSCloud: UICollectionViewFlowLayout!
    @IBOutlet var m_vMask: UIView!
    
    let kCellIdentifier_HKSCloud = "HKSCloudCell"
    let m_userDefault = UserDefaults.standard
    
    var m_jsonNeighborhood: JSON?
    var m_jsonCreditCard: JSON?
    var m_lat: Double?
    var m_lon: Double?
	
    // MARK: - Life Cycles
    override func viewDidLoad() {
        self.initCellNib()
        self.m_cvHKSCloud.isHidden = false
        self.initBtnBorder()
        self.marqueeImages()
        self.stopLoading()
        self.removeUserDefault()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func  viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - CollectionView
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellTotalWidth = Double(kMainWidth) - (double_t(kNumber) + 1.0) * kMinimumCellSpace
        let cellWidth = cellTotalWidth / double_t(kNumber)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kNumber
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cvCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier_HKSCloud, for: indexPath) as! HKSCloudCollectionViewCell
        
        cvCell.m_lbName.text = kFeaturesTitle[indexPath.item]
        cvCell.cellLayout(m_test: kNumber)
        cvCell.m_ivFeatures.image = kFile_FeaturesImages[indexPath.item]
        
        return cvCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (indexPath.item < kFeaturesCount) {
            
            let cvCell = collectionView.cellForItem(at: indexPath) as! HKSCloudCollectionViewCell
            
            if (0 == indexPath.item) {
                
                if let Neiborhood = self.m_userDefault.string(forKey: kUdKey_Neiborhood) {
                    HKSCloudLocationManager.shared.getCurrent { (location) in
                    }
                    
                    m_jsonNeighborhood = getJSON(key: Neiborhood)
                    changePage(json: m_jsonNeighborhood!, datagroup: kNeighborhoodGroupCode)
                } else {
                    loadNeighborhood()
                }
            } else if (1 == indexPath.item) {
                if let CreditCard = self.m_userDefault.string(forKey: kUdKey_CreditCard) {
        
                    m_jsonCreditCard = getJSON(key: CreditCard)
                    changePage(json: m_jsonCreditCard!, datagroup: kCreditCardGroupCode)
                }else {
                    loadCredit()
                }
            }
        }
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    }
    
    // MARK: - Init Methods
    func initBackgroundColor() {
        self.m_vHKSCloud.backgroundColor = kHKSCloudColor_Orange
        self.m_cvHKSCloud.backgroundColor = kHKSCloudColor_Orange
    }
    
    func initBtnBorder() {
        self.m_btnRestanrant.layer.borderWidth = 1.0
        self.m_btnRestanrant.layer.borderColor = UIColor.black.cgColor
        self.m_btnBrand.layer.borderWidth = 1.0
        self.m_btnBrand.layer.borderColor = UIColor.black.cgColor
        self.m_btnCoffee.layer.borderWidth = 1.0
        self.m_btnCoffee.layer.borderColor = UIColor.black.cgColor
        self.m_btnDepartmentStore.layer.borderWidth = 1.0
        self.m_btnDepartmentStore.layer.borderColor = UIColor.black.cgColor
        self.m_btnCoupon.layer.borderWidth = 1.0
        self.m_btnCoupon.layer.borderColor = UIColor.black.cgColor
        self.m_btnMarket.layer.borderWidth = 1.0
        self.m_btnMarket.layer.borderColor = UIColor.black.cgColor
        self.m_btnMovie.layer.borderWidth = 1.0
        self.m_btnMovie.layer.borderColor = UIColor.black.cgColor
        self.m_btnMakeup.layer.borderWidth = 1.0
        self.m_btnMakeup.layer.borderColor = UIColor.black.cgColor
    }
    
    func getJSON(key: String)->JSON {
        if  key != "" {
            if let json = key.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                return try! JSON(data: json)
            } else {
                return JSON("nil")
            }
        } else {
            return JSON("nil")
        }
    }
    
    func initCellNib() {
        let cellNib = UINib(nibName: "HKSCloudCollectionViewCell", bundle: nil)
        self.m_cvHKSCloud.register(cellNib, forCellWithReuseIdentifier: kCellIdentifier_HKSCloud)
    }
    
    func marqueeImages() {
        m_ivMarquee.animationImages = kFile_MarqueeImages
        m_ivMarquee.animationDuration = 4.0
        m_ivMarquee.startAnimating()
    }
    
    func removeUserDefault() {
        self.m_userDefault.removeObject(forKey: "NeiborhoodData")
        self.m_userDefault.removeObject(forKey: kUdKey_CreditCard)
    }
    
    func saveJSON(json: JSON, userDefaultName: String) {
        self.m_userDefault.set(json.rawString(), forKey: userDefaultName)
        self.m_userDefault.synchronize()
    }
    
    func stopLoading() {
        self.m_aivLoading.stopAnimating()
        self.m_cvHKSCloud.isHidden = false
        self.m_vMask.isHidden = true
    }
    
    func startLoading() {
        self.m_aivLoading.startAnimating()
        self.m_cvHKSCloud.isHidden = true
        self.m_vMask.isHidden = false
    }
    
    func changePage(json: JSON, datagroup: String) {
        let secondController = HKSCloudNeighborhoodViewController()
        secondController.m_json = json
        secondController.m_strDatagroup = datagroup
        self.navigationController?.pushViewController(secondController, animated: true)
    }
    
    func makeSureLocation(location: CLLocation) {
        m_lat = location.coordinate.latitude
        m_lon = location.coordinate.longitude
        locationNil()
    }
    
    func locationNil() {
        if m_lat == nil {
            m_lat = kLat
            m_lon = kLon
        }
    }
    
    func loadCredit() {
        startLoading()
        locationNil()
        HKSCloudHttpClient.eventSearch(dataGroup: kCreditCardGroupCode, lat: self.m_lat!, lon: self.m_lon!, callback: { (content) in
            
            self.stopLoading()
            self.saveJSON(json: content, userDefaultName: kUdKey_CreditCard)
            self.changePage(json: content, datagroup: kCreditCardGroupCode)
        })
    }
    
    func loadNeighborhood() {
        startLoading()
        HKSCloudLocationManager.shared.getCurrent { (location) in
            print(location.coordinate)
            self.makeSureLocation(location: location)
            HKSCloudHttpClient.eventSearch(dataGroup: kNeighborhoodGroupCode, lat: self.m_lat!, lon: self.m_lon!, callback: { (content) in
                self.stopLoading()
                self.saveJSON(json: content, userDefaultName: kUdKey_Neiborhood)
                self.changePage(json: content, datagroup: kNeighborhoodGroupCode)
            })
        }
    }
}
