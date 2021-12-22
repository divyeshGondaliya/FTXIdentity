//
//  SignInSecurityVC+Helper.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 22/12/21.
//

import Foundation

extension SignInSecurityVC
{
    func openPopupForEdit()
    {
        let vc = PersonalnfoChangePopupVC(nibName: "PersonalnfoChangePopupVC", bundle: nil)
        vc.userCurrentEmail = self.lbl_email.text ?? ""
        vc.editFor = self.editFor
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        switch self.editFor
        {
            case .FirstName:
                print("Firstname")
            case .LastName:
                print("Last name")
            case .SSN:
                vc.preFillString = ""
                vc.confirmRequired = true
            case .Email:
                vc.preFillString = ""
            case .Mobile:
                vc.preFillString = ""
            case .DateOfBirth:
                print("Date Of Birth")
        }
        self.present(vc, animated: true, completion: nil)
    }
}

extension SignInSecurityVC:PersonalnfoChangePopupDelegate
{
    func updateButtonPress(stringValueOfTextField: String) {
        switch self.editFor
        {
            case .FirstName:
                print("Firstname")
            case .LastName:
                print("Last name")
            case .SSN:
                print("Update SSN")
//                self.updateUserInfo(txtToUpdate: stringValueOfTextField)
            case .Email:
                print("Email \(stringValueOfTextField)")
//                self.getUserDetails()
            case .Mobile:
                print("Mobile \(stringValueOfTextField)")
            case .DateOfBirth:
                print("DOB")
        }
    }
    
    func cancelButtonPress(stringValueOfTextField: String) {
        print(stringValueOfTextField)
    }
}

extension SignInSecurityVC:ChangePwdDelegate
{
    func pwdChange(responce: Bool) {
        if responce
        {
            CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Password successfully changed", andAlertType: 1)
        }else{
            CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Password not successfully changed please try again.", andAlertType: 1)
        }
    }
    
    func cancelPwdChange() {
        print("cancel pwd changes")
    }
}
