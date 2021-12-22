//
//  CreateAccountStep5VC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import UIKit
import DatePickerDialog

class CreateAccountStep5VC: MainStuffViewController {

    @IBOutlet weak var view_ssn: UIView!

    @IBOutlet weak var txt_fname: UITextField!
    @IBOutlet weak var txt_lname: UITextField!
    @IBOutlet weak var txt_bdate: UITextField!
    @IBOutlet weak var btn_bdate: UIButton!
    @IBOutlet weak var txt_ssn: UITextField!
    @IBOutlet weak var lbl_ssn_bdy: UILabel!
    @IBOutlet weak var btn_dob_ssn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.designRelatedStuff()
    }
    
    @IBAction func btn_date_picker_press(_ sender: Any) {
        DatePickerDialog().show("Birthday", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) { date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                self.txt_bdate.text = formatter.string(from: dt)
            }
        }
    }
    @IBAction func btn_ssn_Bday_press(_ sender: Any) {
        self.toggle_SSN_BDay_setup()
    }
    @IBAction func btn_next_pres(_ sender: Any) {
        
        if self.txt_fname.text ?? "" == ""
        {
            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: StringMsgToDisplay.enterFname, andAlertType: 3)
            return
        }
        
        if self.txt_lname.text ?? "" == ""
        {
            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: StringMsgToDisplay.enterLname, andAlertType: 3)
            return
        }
        
        if self.view_ssn.alpha == 0
        {
            if self.txt_bdate.text ?? "" == ""
            {
                CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: StringMsgToDisplay.BDYSelect, andAlertType: 3)
                return
            }
        }else{
            if self.txt_ssn.text?.count ?? 0 == 0
            {
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: StringMsgToDisplay.enterSSN, andAlertType: 3)
                return
            }
        }
        
        self.signupTheThings()
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


extension CreateAccountStep5VC
{
    func designRelatedStuff()
    {
        self.lbl_ssn_bdy.text = StringMsgToDisplay.SSNinstead
        self.view_ssn.alpha = 0
        self.txt_ssn.delegate = self
        self.txt_ssn.keyboardType = .numberPad
        
        for item in [self.txt_fname, txt_lname, txt_bdate, txt_ssn]
        {
            item?.setLeftPaddingPoints(16)
            item?.setRightPaddingPoints(16)
        }
        
        if SignUpData.shared.biometricOption == 1 && SignUpData.shared.biometricsVerfyByServer
        {
            self.txt_fname.isUserInteractionEnabled = false
            self.txt_lname.isUserInteractionEnabled = false
            self.txt_bdate.isUserInteractionEnabled = false
            self.btn_bdate.isUserInteractionEnabled = false
            self.lbl_ssn_bdy.text = ""
            self.btn_dob_ssn.isEnabled = false
        }
        if SignUpData.shared.biometricOption == 2
        {
            self.txt_fname.isUserInteractionEnabled = false
            self.txt_lname.isUserInteractionEnabled = false
            self.txt_bdate.isUserInteractionEnabled = false
            self.btn_bdate.isUserInteractionEnabled = false
            self.lbl_ssn_bdy.text = ""
            self.btn_dob_ssn.isEnabled = false
        }
        self.txt_fname.text = SignUpData.shared.firstName
        self.txt_lname.text = SignUpData.shared.lastName
//        2021-12-22T06:33:33.687Z
        let arr = SignUpData.shared.dateOfBirth.components(separatedBy: "T")
        if arr.count > 0
        {
            let dateStr = arr[0]
            let mainDateArr = dateStr.components(separatedBy: "-")
            if mainDateArr.count == 3
            {
                self.txt_bdate.text = "\(mainDateArr[1])/\(mainDateArr[2])/\(mainDateArr[0])"
            }
        }
        if self.txt_bdate.text?.count ?? 0 == 0
        {
            self.txt_bdate.text = SignUpData.shared.dateOfBirth
        }
    }
    
    func toggle_SSN_BDay_setup()
    {
        if self.lbl_ssn_bdy.text == StringMsgToDisplay.SSNinstead
        {
            self.view_ssn.alpha = 1
            self.lbl_ssn_bdy.text = StringMsgToDisplay.BDYinsted
        }else{
            self.view_ssn.alpha = 0
            self.lbl_ssn_bdy.text = StringMsgToDisplay.SSNinstead
        }
    }
}

extension CreateAccountStep5VC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField != self.txt_ssn
        {
            return true
        }
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")
            let characterSet = CharacterSet(charactersIn: updatedText)
            if updatedText.count < 5
            {
                return allowedCharacters.isSuperset(of: characterSet)
            }
            return false
        }
        return true
    }
}
