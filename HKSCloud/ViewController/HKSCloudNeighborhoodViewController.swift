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

class HKSCloudNeighborhoodViewController: UITableViewController {
    
    @IBOutlet var m_tvHKSCloudNeighborhood: UITableView!

    var newArray: Array<String>?
    var m_json: JSON!
    var m_detailCellRow: Bool = false
    var m_didselectNumber: Int = 0
    var m_jsonData: JSON!
    var aryShopImag: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "HKSCloudNeighborhoodTableViewCell", bundle: nil)
        self.m_tvHKSCloudNeighborhood.register(cellNib, forCellReuseIdentifier: "neighborhoodCell")
        print(m_json)
        m_jsonData = m_json["branch"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return m_json["branch"].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "neighborhoodCell", for: indexPath) as! HKSCloudNeighborhoodTableViewCell
        cell.delegate = self
        cell.m_lbNeighborhoodName.text = m_jsonData[indexPath.row]["name"].stringValue
        cell.m_lbNeighborhoodTitle.text = m_jsonData[indexPath.row]["event"][0]["title"].stringValue
        cell.m_lbDistance.text = m_jsonData[indexPath.row]["distance"].stringValue + "km"
        Alamofire.request(m_jsonData[indexPath.row]["logo"].string!).responseData { (response) in
            if let urlData = response.data {
                cell.m_ivShop.image = UIImage.init(data: urlData)
            }
        }

        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = HKSCloudDetailViewController()
        m_didselectNumber = indexPath.row
        detailView.m_eventJSON = m_json
        detailView.m_iSelectShop = indexPath.row
        detailView.m_shopImage = aryShopImag
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

extension HKSCloudNeighborhoodViewController: sendSelectRowDelegate {
    func sendSelectRow(index: UITableViewCell) {
        let vc = HKSCloudMapViewController.init(nibName: "HKSCloudMapViewController", bundle: nil)
        guard let selectCount = m_tvHKSCloudNeighborhood.indexPath(for: index)?.row else {
            return
        }
        vc.m_dbMapLat = double_t(m_json["branch"][selectCount]["lat"].stringValue)
        vc.m_dbMapLon = double_t(m_json["branch"][selectCount]["lon"].stringValue)
        vc.m_strMaptitle = (m_json["branch"][selectCount]["name"].stringValue)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


