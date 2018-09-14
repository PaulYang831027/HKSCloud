//
//  HKSCloudWebViewController.swift
//  HKSCloud
//
//  Created by softmobile on 2018/8/6.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit
import WebKit

class HKSCloudWebViewController: UIViewController, WKNavigationDelegate {

    var m_wvEvent = WKWebView()
    var m_progBar = UIProgressView()
    var m_strEventUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeWKwebview()
        setProBar()
        self.m_wvEvent.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    deinit {
        m_wvEvent.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewWillDisappear(animated: Bool) {
        m_wvEvent.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    func makeWKwebview() {
        
        let url: URL?
        //创建wkwebview
        m_wvEvent = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        m_wvEvent.navigationDelegate = self
        //创建网址
        url = URL(string: self.m_strEventUrl)
        if url != nil {
        //创建请求
            let request = URLRequest(url: url!)
        //加载请求
            m_wvEvent.load(request)
        //添加wkwebview
            self.view.addSubview(m_wvEvent)
        }
    }
    
    func setProBar() {
        m_progBar = UIProgressView(frame: CGRect(x: 0, y:0, width: self.view.frame.width, height: 50))
        m_progBar.progress = 0.15
        m_progBar.tintColor = UIColor.red
        self.m_wvEvent.addSubview(m_progBar)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            
            self.m_progBar.alpha = 1.0
            self.m_progBar.setProgress(Float(m_wvEvent.estimatedProgress), animated: true)
            //进度条的值最大为1.0
            if(self.m_wvEvent.estimatedProgress >= 1.0) {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                    self.m_progBar.alpha = 0.0
                }, completion: { (finished:Bool) -> Void in
                    self.m_progBar.progress = 0
                })
            }
        }
    }
}
