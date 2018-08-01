//
//  HKSCloudDefine.swift
//  HKSCloud
//
//  Created by softmobile on 2018/7/9.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

let kMainWidth = Double(UIScreen.main.bounds.size.width)
let kHKSCloudURL: String = "http://test1.hokhang.com/hksCloudService/getEventService.php"
var kNumber: Int = 3
var kMinimunCellNumber: Int = 1
var kMinimumCellSpace: double_t = 10.0

var kFeaturesTitle: Array<String> = [NSLocalizedString("Text:kHKSCloudNeighborhood", comment: ""),
                                     NSLocalizedString("Text:kHKSCloudCreditCard", comment: ""),
                                     NSLocalizedString("Text:kHKSCloudPersonal", comment: "")]

//Mark: Color
let kHKSCloudColor_Red: UIColor = UIColor(netHex: 0xe14242)
let kHKSCloudColor_White: UIColor = UIColor(netHex: 0xffffff)
let kHKSCloudColor_Yellow: UIColor = UIColor(netHex: 0xffff00)
let kHKSCloudColor_Orange: UIColor = UIColor(netHex: 0xf28500)


let kFile_FeaturesImages: [UIImage] = [UIImage(named: "neighborhood")!,
                                  UIImage(named: "creditCard")!,
                                  UIImage(named: "personal")!]

let kFile_MarqueeImages: [UIImage] = [UIImage(named: "event1")!,
                                 UIImage(named: "event2")!,
                                 UIImage(named: "event3")!]

// MARK: -Parameters
let kAppID: String = "119871"
let kNeighborhoodGroupCode: String = "01"
let kCreditCardGroupCode: String = "07"
let kPrimaryCategory: String = ""
let kSecondaryCategory: String = ""
let kIndex: String = "0"
let kLimit: String = "30"
let kOS: String = "IOS"
let kOSVersion: String = "5.0"
let kMacAddress: String = "290962c8bf7245c7c9e48aebcbe1276a"
let kLat: String = "25.047922"
let kLon: String = "121.517079"
let kDeviceName: String = "iPhone 7,1"
let kWidth: String = "320.000000"
let kHeight: String = "480.000000"
let kDeviceIdforVendor: String = "0AA675B9-41E0-4C41-8B7A-F1DBC6ACEEDB"










//m_jsonNeighborhood = JSON()
//m_jsonNeighborhood!["appId"].stringValue = "119871"
//m_jsonNeighborhood!["dataGroupCode"].stringValue = "01"
//m_jsonNeighborhood!["primaryCategory"].stringValue = ""
//m_jsonNeighborhood!["secondaryCategory"].stringValue = ""
//m_jsonNeighborhood!["index"].stringValue = "0"
//m_jsonNeighborhood!["limit"].stringValue = "30"
//m_jsonNeighborhood!["OS"].stringValue = "IOS"
//m_jsonNeighborhood!["OSVersion"].stringValue = "5.0"
//m_jsonNeighborhood!["macAddress"].stringValue = "290962c8bf7245c7c9e48aebcbe1276a"
//let characterSet = CharacterSet(charactersIn: "Optional()")
//if lat != "nil" {
//    m_jsonNeighborhood!["lat"].stringValue = lat.trimmingCharacters(in: characterSet)
//    m_jsonNeighborhood!["lon"].stringValue = lon.trimmingCharacters(in: characterSet)
//}else {
//    m_jsonNeighborhood!["lat"].stringValue = "25.047922"
//    m_jsonNeighborhood!["lon"].stringValue = "121.517079"
//}
//m_jsonNeighborhood!["deviceName"].stringValue = "iPhone 7,1"
//m_jsonNeighborhood!["width"].stringValue = "320.000000"
//m_jsonNeighborhood!["height"].stringValue = "480.000000"
//m_jsonNeighborhood!["deviceIdforVendor"].stringValue = "0AA675B9-41E0-4C41-8B7A-F1DBC6ACEEDB"




