//
//  HKSCloudNeighborhoodTableViewCell.swift
//  HKSCloud
//
//  Created by softmobile on 2018/7/18.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit

protocol sendSelectRowDelegate {
    func sendSelectRow(index: UITableViewCell)
}
class HKSCloudNeighborhoodTableViewCell: UITableViewCell {
    @IBOutlet var m_lbDistance: UILabel!
    @IBOutlet var m_ivShop: UIImageView!
    @IBOutlet var m_lbNeighborhoodTitle: UILabel!
    @IBOutlet var m_lbNeighborhoodName: UILabel!
    @IBAction func showShopMap(_ sender: Any) {
        self.delegate?.sendSelectRow(index: self)
    }
    
    var delegate: sendSelectRowDelegate?
    var cellSelect: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
