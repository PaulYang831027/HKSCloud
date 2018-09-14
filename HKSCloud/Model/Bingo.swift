//
//  Bingo.swift
//  Bingo
//
//  Created by softmobile on 2018/7/4.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import Foundation


struct Bingo {
    
//    static let m_number : Int
//    init(m_number:Int) {
//        self.init(m_number: 4)
//    }
    
    var m_lineCountTest: Int
    var m_number: Int
    init(m_lineCountTest: Int, m_number: Int) {
        self.m_lineCountTest = m_lineCountTest
        self.m_number = m_number
    }
    init() {
        self.init(m_lineCountTest: 0, m_number: 0)
    }

}

