//
//  UIAlertController+Ext.swift
//  Bingo
//
//  Created by softmobile on 2018/7/4.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit

typealias AlertActionType = (UIAlertAction?)->()
extension UIAlertController{
    
    class func alert(title:String? = NSLocalizedString("AlertTitle:kAlertReEnter", comment: ""),message:String?)->UIAlertController  {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        return alertController
    }
    
    func addTextField(handler:  @escaping (UITextField) -> Void) -> UIAlertController {
        addTextField(configurationHandler: handler)
        return self
    }
    
    func cancleHandle(title:String? = NSLocalizedString("AlertAction:kAlertCancel", comment: ""),
                      style:UIAlertActionStyle? = .cancel,
                      alertAction:AlertActionType?) -> UIAlertController {
        let alert = UIAlertAction(title: title, style: style!) { (action) in
            if alertAction != nil{
                alertAction!(action)
            }
        }
        self.addAction(alert)
        
        return self
    }
    
    func otherHandle(title:String? = NSLocalizedString("AlertAction:kAlertConfirm", comment: ""),
                     style:UIAlertActionStyle? = .default,
                     alertAction:AlertActionType?) -> UIAlertController {
        let alert = UIAlertAction(title: title, style: style!) { (action) in
            if alertAction != nil{
                alertAction!(action)
            }
        }
        self.addAction(alert)
        
        return self
    }
    
    func show(currentVC:UIViewController) {
        currentVC.present(self, animated: true, completion: nil)
    }
}


