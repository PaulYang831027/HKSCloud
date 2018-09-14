//
//  HKSCloudDetailViewControllerCell.swift
//  HKSCloud
//
//  Created by softmobile on 2018/7/23.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit

protocol sendEventSelectedDelegate {
    func sendEventSelected(index: UICollectionViewCell)
}
class HKSCloudDetailViewControllerCell: UICollectionViewCell {
    
    @IBOutlet var m_lbDetailName: UILabel!
    @IBOutlet var m_btnEventWeb: UIButton!
    @IBOutlet var m_ivShop: UIImageView!
    @IBOutlet var m_lbEventDate: UILabel!
    @IBOutlet var m_lbEventContent: UILabel!
    @IBOutlet var m_ivEvent: UIImageView!
    @IBOutlet var m_ivCoupon: UIImageView!
    
    @IBOutlet var m_cstrHaveImage: NSLayoutConstraint!
    @IBOutlet var m_cstrNoImage: NSLayoutConstraint!
    @IBOutlet var m_cstrEventWidth: NSLayoutConstraint!

    @IBOutlet var m_cstrNoCoupon: NSLayoutConstraint!
    @IBOutlet var m_cstrHaveCoupon: NSLayoutConstraint!
    @IBOutlet var m_cstrCouponWidth: NSLayoutConstraint!
    
    @IBAction func showEventWeb(_ sender: Any) {
        self.delegate?.sendEventSelected(index: self)
    }
    
    var delegate: sendEventSelectedDelegate?
    var cellSelect: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        m_cstrEventWidth.constant = kMainWidth
        m_cstrCouponWidth.constant = kMainWidth
        m_btnEventWeb.layer.borderWidth = 1.0
    }
}
