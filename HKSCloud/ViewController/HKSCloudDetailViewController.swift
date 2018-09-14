//
//  HKSCloudDetailViewController.swift
//  HKSCloud
//
//  Created by softmobile on 2018/7/23.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class HKSCloudDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var m_vHKSCloudDetail: UIView!
    @IBOutlet var m_svHKSCloudDetail: UIScrollView!
    @IBOutlet var m_cvHKSCloudDetail: UICollectionView!
    
    let kCellIdentifier_HKSCloudDetail = "detailCell"
    var m_eventJSON: JSON?
    var m_strEndDate: String.SubSequence!
    var m_aryEventUrl: String = ""
    var m_strCouponUrl: String = ""
    var m_data: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCellNib()
        self.edgesForExtendedLayout = []
        m_data = m_eventJSON!["event"]
        if let flowLayout = m_cvHKSCloudDetail.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return m_data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cvCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier_HKSCloudDetail, for: indexPath) as! HKSCloudDetailViewControllerCell
        cvCell.delegate = self
        cvCell.m_lbDetailName.text = m_data[indexPath.row]["title"].rawString()
        cvCell.m_lbEventContent.text = m_data[indexPath.row]["detail"].stringValue +
            kNotice + m_data[indexPath.row]["note"].stringValue
        m_strEndDate = m_data[indexPath.row]["endDate"].stringValue.prefix(10)
        cvCell.m_lbEventDate.text = (kFromNow + m_strEndDate)
        m_aryEventUrl = m_data[indexPath.row]["eventPic"][0]["url"].stringValue
        m_strCouponUrl = m_data[indexPath.row]["coupon"][0]["url"].stringValue
        
        let m_strImageUrl = m_eventJSON!["logo"].string
        if (m_strImageUrl != "") {
            let url = URL(string: m_strImageUrl!)
            cvCell.m_ivShop.kf.setImage(with: url)
        } else {
            cvCell.m_ivShop.image = kNoImage
        }
        
        if (m_aryEventUrl == "") {
            cvCell.m_cstrHaveImage.isActive = false
            cvCell.m_cstrNoImage.isActive = true
        } else {
            cvCell.m_cstrHaveImage.isActive = true
            cvCell.m_cstrNoImage.isActive = false
            let url = URL(string: m_aryEventUrl)
            cvCell.m_ivEvent.kf.setImage(with: url)
        }
        
        if (m_strCouponUrl == "") {
            cvCell.m_cstrHaveCoupon.isActive = false
            cvCell.m_cstrNoCoupon.isActive = true
        } else {
            cvCell.m_cstrHaveCoupon.isActive = true
            cvCell.m_cstrNoCoupon.isActive = false
            let url = URL(string: m_aryEventUrl)
            cvCell.m_ivCoupon.kf.setImage(with: url)
        }

        return cvCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kMinimumLineSpacing
    }
    
    func initCellNib() {
        let cellNib = UINib(nibName: "HKSCloudDetailViewControllerCell", bundle: nil)
        self.m_cvHKSCloudDetail.register(cellNib, forCellWithReuseIdentifier: kCellIdentifier_HKSCloudDetail)
    }
}

extension HKSCloudDetailViewController: sendEventSelectedDelegate {
    func sendEventSelected(index: UICollectionViewCell) {
        let vc = HKSCloudWebViewController.init(nibName: "HKSCloudWebViewController", bundle: nil)
        guard let selectCount = m_cvHKSCloudDetail.indexPath(for: index)?.item else {
            return
        }
        vc.m_strEventUrl = m_data[selectCount]["website"].stringValue
        print(vc.m_strEventUrl)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
