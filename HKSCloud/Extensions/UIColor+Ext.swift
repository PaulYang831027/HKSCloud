//
//  UIColor+Ext.swift
//  Bingo
//
//  Created by softmobile on 2018/7/10.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(netHex: Int, alpha: Double = 1.0) {
        let r = CGFloat((netHex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((netHex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(netHex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
}
