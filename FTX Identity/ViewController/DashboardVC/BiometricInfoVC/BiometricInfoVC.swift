//
//  BiometricInfoVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import UIKit

class BiometricInfoVC: UIViewController {

    @IBOutlet weak var tbl_view: UITableView!
    
    var img_arr = [UIImage(named: "front-id-icon"),UIImage(named: "back-id-card-icon"),UIImage(named: "selfie-media-icon")]
    var title_arr = ["Front ID Card","Back ID Card","Selfie Record"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl_view.register(UINib(nibName: "BiometricInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "BiometricInfoTableViewCell")
    }

    @IBAction func btn_verifyAgain_press(_ sender: Any) {
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
