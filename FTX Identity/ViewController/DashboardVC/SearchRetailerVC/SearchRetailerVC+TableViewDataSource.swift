//
//  SearchRetailerVC+TableViewDataSource.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 17/12/21.
//

import Foundation
import UIKit
import SkeletonView

extension SearchRetailerVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dummy_tbl_view == tableView
        {
            return 10
        }
        return self.itemToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.dummy_tbl_view == tableView
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "RetailerTableViewCell", for: indexPath) as? RetailerTableViewCell
            {
                cell.configureForSkeletonView()
                
                return cell
            }
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RetailerTableViewCell", for: indexPath) as? RetailerTableViewCell
        {
            let dic = self.itemToDisplay[indexPath.row]
            cell.configureCell(dic: dic)
            cell.btn_share_unshare_press.tag = indexPath.row
            cell.btn_share_unshare_press.removeTarget(self, action: #selector(self.btn_share_unshare_press(sender:)), for: .touchUpInside)
            cell.btn_share_unshare_press.addTarget(self, action: #selector(self.btn_share_unshare_press(sender:)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func btn_share_unshare_press(sender:UIButton)
    {
        let dic = self.itemToDisplay[sender.tag]
        if dic["identityShared"]?.bool ?? false
        {
            showalertYesNo(vc: self, title: "FTX Identity", subTitle: "Are you sure you want to unshare identity to \(dic["companyName"]?.string ?? "")-\(dic["applicationName"]?.string ?? "")") {
                self.unShareIdentity(accountApplicationId: dic["accountApplicationId"]?.string ?? "")
            } failure: {
            }
        }else{
            let vc = ShareUnshareIdentityVC(nibName: "ShareUnshareIdentityVC", bundle: nil)
            vc.retailerData = self.itemToDisplay[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 200.0 {
            self.loadMore()
        }
    }
}

extension SearchRetailerVC
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.dummy_tbl_view != tableView
        {
            let vc = RetailerDetailsVC(nibName: "RetailerDetailsVC", bundle: nil)
            vc.retailerData = self.itemToDisplay[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }        
    }
}
