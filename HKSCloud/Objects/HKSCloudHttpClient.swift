//
//  HKSCloudHttpClient.swift
//  HKSCloud
//
//  Created by softmobile on 2018/8/1.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias APICallback = (JSON)-> Void

class HKSCloudHttpClient: NSObject {
    
    static let shared = HKSCloudHttpClient()
    
    static func eventSearch(dataGroup: String, lat: Double, lon: Double, index: Int? = 0, callback: @escaping APICallback) {
        let parameters: Parameters = ["appId": kAppID,
                                      "dataGroupCode": dataGroup,
                                      "primaryCategory":kPrimaryCategory,
                                      "secondaryCategory": kSecondaryCategory,
                                      "index": index as Any,
                                      "limit": kLimit,
                                      "OS": kOS,
                                      "OSVersion": kOSVersion,
                                      "macAddress": kMacAddress,
                                      "deviceName": kDeviceName,
                                      "width": kWidth,
                                      "height": kHeight,
                                      "deviceIdforVendor": kDeviceIdforVendor,
                                      "lat": lat,
                                      "lon": lon]
        let url = URL.init(string: kHKSCloudURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)

        HKSCloudHttpClient.shared.apiRequest(url: url!, parameters: parameters, callback: callback)
    }
    // MARK: - Common
    func apiRequest(url: URL, parameters: Parameters? = nil, callback: @escaping APICallback) {
        print("Loading")
        Alamofire.request(url, parameters: parameters).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    callback((try? JSON(data: data)) ?? JSON())
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

