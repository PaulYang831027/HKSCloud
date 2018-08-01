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
    var m_jsonData: JSON?
    var m_aryNeighborhoodImageUrl: Array<String> = []
    var m_aryCreditCardImageUrl: Array<String> = []
    var m_bNeighborhoodSuccess: Bool = false
    var m_bCreditCardSuccess: Bool = false
    var m_lat: double_t?
    var m_lon: double_t?
    var m_locationManager : CLLocationManager!;
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        self.initCellNib()
        self.m_cvHKSCloud.isHidden = false
        self.initBtnBorder()
        self.marqueeImages()
        self.openLocation()
        self.initView()
        //self.removeUserDefault()
        //print(m_lat)

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
        let cellTotalWidth = kMainWidth - (double_t(kNumber) + 1.0) * kMinimumCellSpace
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
        
        if (indexPath.item < 2) {
            let cvCell = collectionView.cellForItem(at: indexPath) as! HKSCloudCollectionViewCell
            let secondController = HKSCloudNeighborhoodViewController()
            
            if (0 == indexPath.item) {
                
                if let Neiborhood = self.m_userDefault.string(forKey: "NeiborhoodData") {
                    m_jsonNeighborhood = getJSON(key: Neiborhood)
                    secondController.m_json = m_jsonNeighborhood
                    m_bNeighborhoodSuccess = true
                }else {
                    requastJSONData(dataGroup: "01")
                }
            } else if (1 == indexPath.item) {
                secondController.m_json = m_jsonCreditCard
                if let CreditCard = self.m_userDefault.string(forKey: "CreditCardData") {
                    m_jsonCreditCard = getJSON(key: CreditCard)
                    secondController.m_json = m_jsonCreditCard
                    m_bCreditCardSuccess = true
                }else {
                    requastJSONData(dataGroup: "07")
                }
            }
            if indexPath.item == 1 && m_bCreditCardSuccess == true {
                self.navigationController?.pushViewController(secondController, animated: true)
            }
            if indexPath.item == 0 && m_bNeighborhoodSuccess == true{
                self.navigationController?.pushViewController(secondController, animated: true)
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
        self.m_userDefault.removeObject(forKey: "CreditCardData")
    }
    
    func openLocation() {
        m_locationManager = CLLocationManager();
        m_locationManager.delegate = self;
        //詢問使用者是否同意給APP定位功能
        m_locationManager.requestWhenInUseAuthorization();
        //開始接收目前位置資訊
        m_locationManager.startUpdatingLocation();
        m_lat = m_locationManager.location?.coordinate.latitude
        m_lon = m_locationManager.location?.coordinate.longitude
    }
    
    func loadingAPI() {
        
    }
    
    func loadAPIFinish() {
//        if (self.m_bNeighborhoodSuccess == true && self.m_bCreditCardSuccess == true) {
//            self.m_aivLoading.stopAnimating()
//            self.m_vMask.isHidden = true
//            self.m_cvHKSCloud.isHidden = false
//        }
    }
    
    func  requastJSONData(dataGroup: String) {
        HTTPClient.getEventService(primaryCategory: <#T##String#>)
        m_jsonData = JSON()
        m_jsonData!["appId"].stringValue = kAppID
        m_jsonData!["dataGroupCode"].stringValue = kNeighborhoodGroupCode
        m_jsonData!["primaryCategory"].stringValue = kPrimaryCategory
        m_jsonData!["secondaryCategory"].stringValue = kSecondaryCategory
        m_jsonData!["index"].stringValue = kIndex
        m_jsonData!["limit"].stringValue = kLimit
        m_jsonData!["OS"].stringValue = kOS
        m_jsonData!["OSVersion"].stringValue = kOSVersion
        m_jsonData!["macAddress"].stringValue = kMacAddress
        m_jsonData!["deviceName"].stringValue = kDeviceName
        m_jsonData!["width"].stringValue = kWidth
        m_jsonData!["height"].stringValue = kHeight
        m_jsonData!["deviceIdforVendor"].stringValue = kDeviceIdforVendor
        
        let characterSet = CharacterSet(charactersIn: "Optional()")
        if String(describing: m_lat) != "nil" {
            m_jsonData!["lat"].stringValue = String(describing: m_lat).trimmingCharacters(in: characterSet)
            m_jsonData!["lon"].stringValue = String(describing: m_lon).trimmingCharacters(in: characterSet)
        } else {
            m_jsonData!["lat"].stringValue = kLat
            m_jsonData!["lon"].stringValue = kLon
        }
        
        let url = URL.init(string: kHKSCloudURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        Alamofire.request(url!, parameters: m_jsonData?.dictionary).responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                do {
                    self.m_jsonData = try JSON(data: response.data!)
                    print(self.m_jsonData)
//                    if let result = self.m_jsonCreditCard!["branch"].array {
//                        for data in result {
//                            self.m_aryCreditCardImageUrl.append(data["logo"].stringValue)
//                        }
//                    }
                    
                } catch {
                    print("error: \(String(describing: response.error))")
                }

            } else {
                print("error: \(String(describing: response.error))")
            }
            if dataGroup == kCreditCardGroupCode {
                print("信用卡優惠完成")
                self.m_bCreditCardSuccess = true
                self.m_jsonCreditCard = self.m_jsonData
                self.m_userDefault.set(self.m_jsonCreditCard?.rawString(), forKey: "CreditCardData")
                self.m_userDefault.set(self.m_aryCreditCardImageUrl, forKey: "CreditCardImageUrl")
            } else if dataGroup == kNeighborhoodGroupCode {
                print("附近優惠完成")
                self.m_bNeighborhoodSuccess = true
                self.m_jsonNeighborhood = self.m_jsonData
                self.m_userDefault.set(self.m_jsonData?.rawString(), forKey: "NeiborhoodData")
                self.m_userDefault.set(self.m_aryNeighborhoodImageUrl, forKey: "NeiborhoodImageUrl")
            }
            self.m_userDefault.synchronize()
        })
    }
    
    func initView() {
        m_vMask.isHidden = true
        m_aivLoading.stopAnimating()
        m_cvHKSCloud.isHidden = false
    }
}

class HTTPClient {
    
    
//    private func...
    func postReq() {
        
    }
}

extension JSON {
    func addCommonData() {
        self["width"].string = UIScreen.main.bounds.width
    }
}

extension HTTPClient {
    //public func
    
    static func getEventService(primaryCategory:String) {
        var value = JSON()
        
        value.addCommonData()
        
        value = self.addCommonData(value)
        
        self.postReq()
    }
}
