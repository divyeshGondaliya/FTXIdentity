//
//  CreateAccountStep1VC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 14/12/21.
//

import UIKit
import iOSDropDown
import IQKeyboardManagerSwift

class CreateAccountStep1VC: MainStuffViewController {
    
    @IBOutlet weak var btn_use_mobile_email: UIButton!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var btn_lbl: UILabel!
    @IBOutlet weak var txt_phone_number: UITextField!
    
    @IBOutlet weak var txt_country_code: DropDown!
    @IBOutlet weak var view_phone_number: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_email.text = "yp3@yopmail.com"
        self.designRelatedStuff()
        self.view_phone_number.alpha = 0
        self.btn_lbl.text = StringMsgToDisplay.instedMobile
    }

    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    @IBAction func btn_sign_in_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_next_pres(_ sender: Any) {
        if self.view_phone_number.alpha == 0
        {
            if !(self.txt_email.text ?? "").isValidEmail()
            {
                CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: StringMsgToDisplay.emailNotValid, andAlertType: 3)
                return
            }
        }else{
            if self.txt_country_code.text?.count ?? 0 == 0
            {
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: StringMsgToDisplay.selectCountryCode, andAlertType: 3)
                return
            }
            if self.txt_phone_number.text?.count ?? 0 != 10
            {
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: StringMsgToDisplay.mobileNotValid, andAlertType: 3)
                return
            }
        }
        self.checkEmailAndPhoneAvailability()        
    }
    @IBAction func btn_select_press(_ sender: Any) {
        self.txt_country_code.showList()
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_use_mobile_email_press(_ sender: Any) {
        if btn_lbl.text?.lowercased() == StringMsgToDisplay.instedMobile.lowercased()
        {
            self.view_phone_number.alpha = 1
            self.btn_lbl.text = StringMsgToDisplay.instedEmail
        }else{
            self.view_phone_number.alpha = 0
            self.btn_lbl.text = StringMsgToDisplay.instedMobile
        }
    }
}

extension CreateAccountStep1VC
{
    func designRelatedStuff()
    {
        self.txt_phone_number.setLeftPaddingPoints(16)
        self.txt_phone_number.setRightPaddingPoints(16)
        self.txt_email.setLeftPaddingPoints(16)
        self.txt_email.setRightPaddingPoints(16)
        txt_country_code.rowHeight = 50
        txt_country_code.placeholder = "Select"
        txt_country_code.textAlignment = .center
        txt_country_code.optionArray = StaticArray.countryCode
        txt_country_code.optionIds = [0,1]
        txt_country_code.optionImageArray = StaticArray.countryName
        txt_country_code.didSelect{(selectedText , index ,id) in
            self.txt_country_code.text = selectedText
        }
    }
}
