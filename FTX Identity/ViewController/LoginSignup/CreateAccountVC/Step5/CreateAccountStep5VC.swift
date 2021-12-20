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
                formatter.dateFormat = "dd/MM/yyyy"
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
            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: "Please enter firstname first.", andAlertType: 3)
            return
        }
        
        if self.txt_lname.text ?? "" == ""
        {
            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: "Please enter lastname first.", andAlertType: 3)
            return
        }
        
        if self.view_ssn.alpha == 0
        {
            if self.txt_bdate.text ?? "" == ""
            {
                CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: "Please select date of birth first.", andAlertType: 3)
                return
            }
        }else{
            if self.txt_ssn.text?.count ?? 0 == 0
            {
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Please enter ssn number first.", andAlertType: 3)
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
        self.lbl_ssn_bdy.text = "Use SSN instead"
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
            self.lbl_ssn_bdy.text = ""
            self.btn_dob_ssn.isEnabled = false
        }
        if SignUpData.shared.biometricOption == 2
        {
            self.txt_fname.isUserInteractionEnabled = false
            self.txt_lname.isUserInteractionEnabled = false
            self.txt_bdate.isUserInteractionEnabled = false
            self.lbl_ssn_bdy.text = ""
            self.btn_dob_ssn.isEnabled = false
        }
        self.txt_fname.text = SignUpData.shared.firstName
        self.txt_lname.text = SignUpData.shared.lastName
        self.txt_bdate.text = SignUpData.shared.dateOfBirth       
    }
    
    func toggle_SSN_BDay_setup()
    {
        if self.lbl_ssn_bdy.text == "Use SSN instead"
        {
            self.view_ssn.alpha = 1
            self.lbl_ssn_bdy.text = "Use Birth Date instead"
        }else{
            self.view_ssn.alpha = 0
            self.lbl_ssn_bdy.text = "Use SSN instead"
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
