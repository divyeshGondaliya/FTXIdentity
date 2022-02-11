//
//  CreateAccountStep2VC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 15/12/21.
//

import UIKit

class CreateAccountStep2VC: MainStuffViewController {

    var access_token = ""
    @IBOutlet weak var txt_pwd: UITextField!
    @IBOutlet weak var txt_c_pwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.designRelatedStuff()
        print("access_token - \(access_token)")
//        self.txt_pwd.text = "Admin@123"
//        self.txt_c_pwd.text = "Admin@123"
        // Do any additional setup after loading the view.
    }
    @IBAction func btn_next_pres(_ sender: Any) {
        if self.txt_pwd.text?.count == 0
        {
            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: StringMsgToDisplay.enterPassword, andAlertType: 3)
            return
        }
        if self.txt_c_pwd.text?.count == 0
        {
            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: StringMsgToDisplay.enterCPassword, andAlertType: 3)
            return
        }
        if self.txt_pwd.text != self.txt_c_pwd.text
        {
            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: StringMsgToDisplay.pwdCpwdSame, andAlertType: 3)
            return
        }
        self.generateOTP()
    }
    
    @IBAction func btn_sign_in_press(_ sender: Any) {
        for item in self.navigationController?.viewControllers ?? []
        {
            if item is ChooseOprtionVC
            {
                self.navigationController?.popToViewController(item, animated: true)
                break
            }
        }
    }
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateAccountStep2VC
{
    func designRelatedStuff()
    {
        self.txt_pwd.setLeftPaddingPoints(16)
        self.txt_pwd.setRightPaddingPoints(16)
        self.txt_c_pwd.setLeftPaddingPoints(16)
        self.txt_c_pwd.setRightPaddingPoints(16)
    }
}
