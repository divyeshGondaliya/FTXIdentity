//
//  PersonalnfoChangePopupVC+Helper.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 21/12/21.
//

import Foundation
import UIKit
import OTPFieldView

extension PersonalnfoChangePopupVC:OnlyDateAndMonthPickerDelegate
{
    func dateSelected(stringValueOfTextField: String) {
        print("selected Date :- \(stringValueOfTextField)")
        switch self.selectionFor
        {
            case .TXT:
                self.txt_fiels.text = stringValueOfTextField
            case .CTXT:
                self.txt_confirm.text = stringValueOfTextField
        }
    }
    
    
}

extension PersonalnfoChangePopupVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if editFor == .SSN
            {
                let allowedCharacters = CharacterSet(charactersIn:"0123456789")
                let characterSet = CharacterSet(charactersIn: updatedText)
                if updatedText.count < 5
                {
                    return allowedCharacters.isSuperset(of: characterSet)
                }
                return false
            }
        }
        return true
    }
    
}

extension PersonalnfoChangePopupVC:OTPFieldViewDelegate
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

extension PersonalnfoChangePopupVC
{
    func setupOtpView()
    {
        self.txt_otp.isUserInteractionEnabled = true
        self.txt_otp.fieldsCount = 6
        self.txt_otp.fieldBorderWidth = 1
        self.txt_otp.defaultBorderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.txt_otp.filledBorderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.txt_otp.cursorColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.txt_otp.displayType = .roundedCorner
        self.txt_otp.fieldSize = 40
        self.txt_otp.separatorSpace = 8
        self.txt_otp.shouldAllowIntermediateEditing = false
        self.txt_otp.delegate = self
        self.txt_otp.initializeUI()
    }
    
    func uiIniti()
    {
        self.btn_date_selection.isHidden = true
        self.btn_date_selection_confirm.isHidden = true
        
        self.txt_fiels.delegate = self
        self.txt_confirm.delegate = self
        if confirmRequired
        {
            self.txt_top_confirm_16.constant = 16
            self.txt_confirm_height_44.constant = 44
            self.txt_confirm.setLeftPaddingPoints(16)
            self.txt_confirm.setRightPaddingPoints(16)
        }
        if self.preFillString.count > 0
        {
            self.txt_fiels.text = self.preFillString
            self.txt_confirm.text = self.preFillString
        }
        self.txt_fiels.setLeftPaddingPoints(16)
        self.txt_fiels.setRightPaddingPoints(16)
        
        switch self.editFor
        {
        case .FirstName:
            self.txt_fiels.keyboardType = .default
            self.lbl_top_placeholder.text = " First Name "
        case .LastName:
            self.txt_fiels.keyboardType = .default
            self.lbl_top_placeholder.text = " Last Name "
        case .SSN:
            self.txt_fiels.keyboardType = .numberPad
            self.txt_confirm.keyboardType = .numberPad
            self.lbl_top_placeholder.text = " Last 4 of SSN* "
            self.txt_fiels.placeholder = " Last 4 of SSN* "
            self.txt_fiels.isSecureTextEntry = true
            if confirmRequired
            {
                self.txt_confirm.isSecureTextEntry = true
                self.lbl_confirm_top_placeholder.text = " Confirm Last 4 of SSN "
                self.txt_confirm.placeholder = " Confirm Last 4 of SSN "
            }
        case .Email:
            self.txt_fiels.keyboardType = .emailAddress
            self.lbl_top_placeholder.text = " New Email* "
            self.txt_fiels.placeholder = " New Email* "
        case .Mobile:
            self.lbl_top_placeholder.text = " Mobile "
            self.txt_fiels.keyboardType = .numberPad
        case .DateOfBirth:
            self.btn_date_selection.isHidden = false
            self.btn_date_selection_confirm.isHidden = false
            self.txt_fiels.keyboardType = .numberPad
            self.txt_confirm.keyboardType = .numberPad
            self.lbl_top_placeholder.text = " Date of Birth (MM/DD)* "
            self.txt_fiels.placeholder = " Date of Birth (MM/DD)* "
            self.txt_fiels.isSecureTextEntry = false
            if confirmRequired
            {
                self.txt_confirm.isSecureTextEntry = false
                self.lbl_confirm_top_placeholder.text = " Confirm Date of Birth (MM/DD) "
                self.txt_confirm.placeholder = " Confirm Date of Birth (MM/DD) "
            }
        }
    }
}
