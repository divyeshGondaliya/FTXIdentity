//
//  SuccessSignupVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 17/12/21.
//

import UIKit

class SuccessSignupVC: MainStuffViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_login_now_press(_ sender: Any) {
        for item in self.navigationController?.viewControllers ?? []
        {
            if item is ChooseOprtionVC
            {
                SignUpData.shared.initdata()
                self.navigationController?.popToViewController(item, animated: true)
                break
            }
        }
    }
    
}
