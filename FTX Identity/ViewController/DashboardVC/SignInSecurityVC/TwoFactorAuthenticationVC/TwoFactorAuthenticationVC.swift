//
//  TwoFactorAuthenticationVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 22/12/21.
//

import UIKit
import SwiftyJSON

class TwoFactorAuthenticationVC: UIViewController {

    @IBOutlet weak var enterThisCode: UILabel!
    @IBOutlet weak var txt_enterCode: UITextField!
    @IBOutlet weak var img_qrcode: UIImageView!
    var recoveryCodes = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProfileEnable2Fa()
        self.txt_enterCode.setLeftPaddingPoints(16)
        self.txt_enterCode.setRightPaddingPoints(16)
    }
    
    @IBAction func btn_enable_press(_ sender: Any) {
        if self.txt_enterCode.text?.count == 0
        {
            return
        }
        self.enable2FA(appcode: self.txt_enterCode.text ?? "")
    }
    
    @IBAction func btn_cancel_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_back_pres(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
