//
//  PersonalInfoVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import UIKit

class PersonalInfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
