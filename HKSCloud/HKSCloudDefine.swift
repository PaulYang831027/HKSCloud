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

let kMainWidth = UIScreen.main.bounds.size.width
let kMapURL: String = "http://maps.google.com/maps?q="
let kPhoneURL: String = "tel://"
let kHKSCloudURL: String = "http://test1.hokhang.com/hksCloudService/getEventService.php"
let kNotice: String = "\n\n 注意事項：\n"
let kFromNow: String = "即日起 ~ "
let kKm :String = "km"

let kLatDelta: Double = 0.005
let kLonDelta: Double = 0.005
let kMinimumLineSpacing: CGFloat = 40.0
var kMinimumCellSpace: double_t = 10.0

var kChangeRow: Int = 15
var kNumber: Int = 3
var kMinimunCellNumber: Int = 1
var kFeaturesCount: Int = 2

var kFeaturesTitle: Array<String> = [NSLocalizedString("Text:kHKSCloudNeighborhood", comment: ""),
                                     NSLocalizedString("Text:kHKSCloudCreditCard", comment: ""),
                                     NSLocalizedString("Text:kHKSCloudPersonal", comment: "")]

//Mark: Color
let kHKSCloudColor_Red: UIColor = UIColor(netHex: 0xe14242)
let kHKSCloudColor_White: UIColor = UIColor(netHex: 0xffffff)
let kHKSCloudColor_Yellow: UIColor = UIColor(netHex: 0xffff00)
let kHKSCloudColor_Orange: UIColor = UIColor(netHex: 0xf28500)

//Mark: Image
let kFile_FeaturesImages: [UIImage] = [UIImage(named: "neighborhood")!,
                                  UIImage(named: "creditCard")!,
                                  UIImage(named: "personal")!]

let kFile_MarqueeImages: [UIImage] = [UIImage(named: "event1")!,
                                 UIImage(named: "event2")!,
                                 UIImage(named: "event3")!]

let kNoImage: UIImage = UIImage(named: "nopic")!

// MARK: -Parameters
let kAppID: String = "119871"
let kNeighborhoodGroupCode: String = "01"
let kCreditCardGroupCode: String = "07"
let kPrimaryCategory: String = ""
let kSecondaryCategory: String = ""
let kLimit: Int = 60
let kOS: String = "IOS"
let kOSVersion: String = "5.0"
let kMacAddress: String = (UIDevice.current.identifierForVendor?.uuidString)!
let kLat: Double = 25.047922
let kLon: Double = 121.517079
let kDeviceName: String = String(describing: UIDevice.current)
let kWidth: String = String(describing: UIScreen.main.bounds.size.width)
let kHeight: String = String(describing: UIScreen.main.bounds.size.height)
let kDeviceIdforVendor: String = String(describing: UIDevice.current.identifierForVendor)

// MARK: -Alert
let kAlertTitle: String = "定位權限已關閉,使用預設台北車站"
let kAlertMessage: String = "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟"
let kAlertOk: String = "確認"

//MARK: -UserDefault
let kUdKey_Neiborhood: String = "NeiborhoodData"
let kUdKey_CreditCard: String = "CreditCardData"







