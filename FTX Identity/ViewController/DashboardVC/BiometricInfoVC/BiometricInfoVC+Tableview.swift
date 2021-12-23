//
//  BiometricInfoVC+Tableview.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import Foundation
import UIKit

extension BiometricInfoVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.title_arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BiometricInfoTableViewCell", for: indexPath) as? BiometricInfoTableViewCell
        {
            cell.selectionStyle = .none
            cell.img_view.image = self.img_arr[indexPath.row]
            cell.lbl_for_what.text = self.title_arr[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DisplayImageVC(nibName: "DisplayImageVC", bundle: nil)
        var imgurl = ""
        if indexPath.row == 0
        {
            imgurl = self.idFrontImageUrl
        }
        if indexPath.row == 1
        {
            imgurl = self.idBackImageUrl
        }
        if indexPath.row == 2
        {
            imgurl = self.selfImageUrl
        }
        if imgurl.count > 0
        {
            vc.imgStringUrl = imgurl
            self.present(vc, animated: true, completion: nil)
        }        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
