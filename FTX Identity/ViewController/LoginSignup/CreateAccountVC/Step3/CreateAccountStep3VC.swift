//
//  CreateAccountStep3VC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 15/12/21.
//

import UIKit
import OTPFieldView

class CreateAccountStep3VC: MainStuffViewController {

    @IBOutlet weak var btnSendOTP: UIButton!
    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    var strOTP : String = "" {
        
        didSet{
            print("didSet otp to \(oldValue) new otp is: \(strOTP)")
            btnSendOTP.isEnabled = true
            self.btnSendOTP.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSendOTP.isEnabled = false
        self.btnSendOTP.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.26)
        self.designRelatedStuff()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btn_next_pres(_ sender: Any) {
        self.verifyOTP(otp: strOTP)
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

extension CreateAccountStep3VC:OTPFieldViewDelegate
{
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        print(otp)
        self.strOTP = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        print("Has entered all OTP? \(hasEnteredAll)")
        return false
    }
    
    
}

extension CreateAccountStep3VC
{
    func designRelatedStuff()
    {
        self.otpTextFieldView.isUserInteractionEnabled = true
        self.otpTextFieldView.fieldsCount = 6
        self.otpTextFieldView.fieldBorderWidth = 1
        self.otpTextFieldView.defaultBorderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.otpTextFieldView.filledBorderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.otpTextFieldView.cursorColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.otpTextFieldView.displayType = .roundedCorner
        self.otpTextFieldView.fieldSize = 40
        self.otpTextFieldView.separatorSpace = 8
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }
}
