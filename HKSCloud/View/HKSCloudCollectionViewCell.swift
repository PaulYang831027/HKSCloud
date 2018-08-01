//
//  cvCell.swift
//  Bingo2
//
//  Created by softmobile on 2018/6/25.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit

class HKSCloudCollectionViewCell: UICollectionViewCell {
    @IBOutlet var m_lbName: UILabel!
    @IBOutlet var m_ivFeatures: UIImageView!
    
    
    
    func initView() {
        self.m_lbName.text = ""
    }
  
    func cellLayout(m_test: Int) {
        m_lbName.textAlignment = .center
        m_lbName.textColor = UIColor.black
        m_lbName.backgroundColor = UIColor.white
    }
}
