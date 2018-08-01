//
//  HKSCloudDetailViewControllerCell.swift
//  HKSCloud
//
//  Created by softmobile on 2018/7/23.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit

class HKSCloudDetailViewControllerCell: UICollectionViewCell {
    
    @IBOutlet var m_cstrEvent: NSLayoutConstraint!
    @IBOutlet var m_lbDetailName: UILabel!
    @IBOutlet var m_ivShop: UIImageView!
    @IBOutlet var m_lbEventDate: UILabel!
    @IBOutlet var m_lbEventContent: UILabel!
    @IBOutlet var m_ivEvent: UIImageView!
    @IBOutlet var m_cstrHaveImage: NSLayoutConstraint!
    @IBOutlet var m_cstrNoImage: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        m_cstrEvent.constant = UIScreen.main.bounds.size.width
    }
}
