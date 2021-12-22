//
//  TwoFASuccessVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 22/12/21.
//

import UIKit
import SwiftyJSON

class TwoFASuccessVC: UIViewController {

    @IBOutlet weak var tbl_view: UITableView!
    var recoveryCodes = [JSON]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl_view.register(UINib(nibName: "TwoFASuccessCell", bundle: nil), forCellReuseIdentifier: "TwoFASuccessCell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_close_press(_ sender: Any) {
        for item in self.navigationController?.viewControllers ?? []
        {
            if item is SignInSecurityVC
            {
                self.navigationController?.popToViewController(item, animated: true)
                break
            }
        }
    }
    
}

extension TwoFASuccessVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.recoveryCodes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TwoFASuccessCell", for: indexPath) as? TwoFASuccessCell
        {
            cell.lbl_codes.text = self.recoveryCodes[indexPath.row].string ?? ""
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
