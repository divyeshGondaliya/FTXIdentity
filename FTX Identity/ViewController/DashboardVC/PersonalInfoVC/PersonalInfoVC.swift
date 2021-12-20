//
//  PersonalInfoVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import UIKit

class PersonalInfoVC: UIViewController {

    @IBOutlet weak var img_profile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserDetails()
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_edit_profile_press(_ sender: Any) {
    }
}
