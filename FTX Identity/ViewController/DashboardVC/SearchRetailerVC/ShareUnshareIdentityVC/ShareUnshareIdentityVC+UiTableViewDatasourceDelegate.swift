//
//  ShareUnshareIdentityVC+UiTableViewDatasourceDelegate.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import Foundation
import UIKit

extension ShareUnshareIdentityVC:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allRequiredInfo.count > 0
        {
            return 1 + self.finalArrayToDisplay.count
        }
        return self.finalArrayToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfShareOptionCell", for: indexPath) as? ListOfShareOptionCell
        {
            cell.selectionStyle = .none
            if self.allRequiredInfo.count > 0 && indexPath.row == 0
            {
                cell.lbl_rules.text = "Your personal info such as \(self.allRequiredInfo.joined(separator: ", "))"
                cell.btn_switch.setImage(UIImage(named: "switchon"), for: .normal)
            }else{
                let indexrow = self.allRequiredInfo.count > 0 ? indexPath.row - 1 : indexPath.row
                cell.lbl_rules.text = "Your \(self.finalArrayToDisplay[indexrow]["title"]?.string ?? "")"
                
                if self.switchOnid.contains(self.finalArrayToDisplay[indexrow]["id"]?.string ?? "")
                {
                    cell.btn_switch.setImage(UIImage(named: "switchon"), for: .normal)
                }else{
                    cell.btn_switch.setImage(UIImage(named: "switchoff"), for: .normal)
                }
            }
            cell.btn_switch.tag = indexPath.row
            cell.btn_switch.removeTarget(self, action: #selector(self.btn_press_switch(sender:)), for: .touchUpInside)
            cell.btn_switch.addTarget(self, action: #selector(self.btn_press_switch(sender:)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    @objc func btn_press_switch(sender:UIButton)
    {
        self.setupSelectionAndUnselection(intRow: sender.tag)
    }
}

extension ShareUnshareIdentityVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.setupSelectionAndUnselection(intRow: indexPath.row)
    }
    
    @objc func setupSelectionAndUnselection(intRow:Int)
    {
        if self.allRequiredInfo.count > 0 && intRow == 0
        {
        }else{
            let indexrow = self.allRequiredInfo.count > 0 ? intRow - 1 : intRow
            if self.switchOnid.contains(self.finalArrayToDisplay[indexrow]["id"]?.string ?? "")
            {
                self.switchOnid.remove(at: self.switchOnid.firstIndex(of: self.finalArrayToDisplay[indexrow]["id"]?.string ?? "")!)
            }else{
                self.switchOnid.append(self.finalArrayToDisplay[indexrow]["id"]?.string ?? "")
            }
            self.tbl_view.reloadData()
        }
    }
}
