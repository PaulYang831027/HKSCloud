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

class HKSCloudDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var m_vHKSCloudDetail: UIView!
    @IBOutlet var m_svHKSCloudDetail: UIScrollView!
    @IBOutlet var m_cvHKSCloudDetail: UICollectionView!
    
    var m_eventJSON: JSON?
    var m_iSelectShop:Int!
    var m_shopImage: [UIImage]?
    var m_strStartDate: String.SubSequence!
    var m_strEndDate: String.SubSequence!
    var m_aryEventUrl: String = ""
    var data: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "HKSCloudDetailViewControllerCell", bundle: nil)
        self.m_cvHKSCloudDetail.register(cellNib, forCellWithReuseIdentifier: "detailCell")
        self.edgesForExtendedLayout = []
        data = m_eventJSON!["branch"][m_iSelectShop]["event"]
        if let flowLayout = m_cvHKSCloudDetail.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return m_eventJSON!["branch"][m_iSelectShop]["event"].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cvCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! HKSCloudDetailViewControllerCell
        cvCell.m_lbDetailName.text = m_eventJSON!["branch"][m_iSelectShop]["event"][indexPath.row]["title"].stringValue
        cvCell.m_lbEventContent.text = m_eventJSON!["branch"][m_iSelectShop]["event"][indexPath.row]["detail"].stringValue
        
        m_strEndDate = m_eventJSON!["branch"][m_iSelectShop]["event"][indexPath.row]["endDate"].string!.prefix(10)
        cvCell.m_lbEventDate.text = ("即日起 ~ " + m_strEndDate)
        m_aryEventUrl = m_eventJSON!["branch"][m_iSelectShop]["event"][indexPath.row]["eventPic"][0]["url"].string!
        
        Alamofire.request(m_eventJSON!["branch"][m_iSelectShop]["logo"].string!).responseData { (response) in
            if let urlData = response.data {
                cvCell.m_ivShop.image = UIImage.init(data: urlData)
            }
        }
        
        if (m_aryEventUrl == "") {
            cvCell.m_cstrHaveImage.isActive = false
            cvCell.m_cstrNoImage.isActive = true
        } else {
            Alamofire.request(m_aryEventUrl).responseData { (response) in
                if let urlData = response.data {
                    cvCell.m_cstrHaveImage.isActive = true
                    cvCell.m_cstrNoImage.isActive = false
                    cvCell.m_ivEvent.image = UIImage.init(data: urlData)
                }
            }
        }

        return cvCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
}
