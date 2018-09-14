//
//  HKSCloudNeighborhoodViewController.swift
//  HKSCloud
//
//  Created by softmobile on 2018/7/16.
//  Copyright © 2018年 softmobile. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import MJRefresh
import Kingfisher

class HKSCloudNeighborhoodViewController: UITableViewController, CLLocationManagerDelegate {
    
    @IBOutlet var m_tvHKSCloudNeighborhood: UITableView!
    
    let kCellIdentifier_HKSCloudNeighbor = "neighborhoodCell"
    let m_footer = MJRefreshAutoNormalFooter()
    var m_json: JSON!
    var m_jsonData: [JSON] = []
    var m_lat: Double?
    var m_lon: Double?
    var m_iIndex: Int = 0
    var m_strDatagroup: String!
    var m_strImageUrl: String?
    var m_bFinish: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCellNib()
        m_jsonData = m_json["branch"].arrayValue
        self.m_tvHKSCloudNeighborhood.mj_footer = m_footer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return m_jsonData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkRefresh()
        checkReadyRequest(rowCount: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "neighborhoodCell", for: indexPath) as! HKSCloudNeighborhoodTableViewCell
        cell.delegate = self
        cell.m_lbNeighborhoodName.text = m_jsonData[indexPath.row]["name"].stringValue
        cell.m_lbNeighborhoodTitle.text = m_jsonData[indexPath.row]["event"][0]["title"].stringValue
        cell.m_lbDistance.text = m_jsonData[indexPath.row]["distance"].stringValue + kKm
        checkShopLogo(rowCount: indexPath.row, cell: cell)
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = HKSCloudDetailViewController()
        detailView.m_eventJSON = m_jsonData[indexPath.row]
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func initCellNib() {
        let cellNib = UINib(nibName: "HKSCloudNeighborhoodTableViewCell", bundle: nil)
        self.m_tvHKSCloudNeighborhood.register(cellNib, forCellReuseIdentifier: kCellIdentifier_HKSCloudNeighbor)
    }
    
    func checkRefresh() {
        self.m_tvHKSCloudNeighborhood.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            if self.m_bFinish == false {
                self.m_tvHKSCloudNeighborhood.mj_footer.beginRefreshing()
            } else {
                self.m_tvHKSCloudNeighborhood.mj_footer.endRefreshing(completionBlock: {
                    self.m_tvHKSCloudNeighborhood.mj_footer.endRefreshingWithNoMoreData()
                })
            }
        })
    }
    
    func checkReadyRequest(rowCount: Int) {
        if (rowCount == kChangeRow) {
            kChangeRow += kLimit
            self.m_iIndex += kLimit
            HKSCloudLocationManager.shared.getCurrent(location: { (location) in
                self.m_lat = location.coordinate.latitude
                self.m_lon = location.coordinate.longitude
                HKSCloudHttpClient.eventSearch(dataGroup: self.m_strDatagroup, lat: self.m_lat!, lon: self.m_lon!, index: self.m_iIndex
                    , callback: { (content) in
                        self.m_jsonData += content["branch"].arrayValue
                        self.m_tvHKSCloudNeighborhood!.reloadData()
                        if (content["branch"].rawString()?.isEmpty == true) {
                            self.m_bFinish = true
                        }
                })
            })
        }
    }
    
    func checkShopLogo(rowCount: Int, cell: HKSCloudNeighborhoodTableViewCell) {
        let m_strImageUrl = m_jsonData[rowCount]["logo"].string
        if m_strImageUrl != "" {
            let url = URL(string: m_strImageUrl!)
            cell.m_ivShop.kf.setImage(with: url)
        } else {
            cell.m_ivShop.image = kNoImage
        }
    }
}

extension HKSCloudNeighborhoodViewController: sendSelectRowDelegate {
    func sendSelectRow(index: UITableViewCell) {
        let vc = HKSCloudMapViewController.init(nibName: "HKSCloudMapViewController", bundle: nil)
        guard let selectCount = m_tvHKSCloudNeighborhood.indexPath(for: index)?.row else {
            return
        }
        vc.m_dbMapLat = double_t(m_jsonData[selectCount]["lat"].stringValue)
        vc.m_dbMapLon = double_t(m_jsonData[selectCount]["lon"].stringValue)
        vc.m_strMapTitle = (m_jsonData[selectCount]["name"].stringValue)
        vc.m_strMapAddr = (m_jsonData[selectCount]["addr"].stringValue)
        vc.m_strMapPhone = (m_jsonData[selectCount]["event"][0]["phone"].stringValue)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


