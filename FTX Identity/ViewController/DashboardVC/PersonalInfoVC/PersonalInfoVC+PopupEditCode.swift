//
//  PersonalInfoVC+PopupEditCode.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import Foundation
import UIKit

enum EditFor {
    case FirstName
    case LastName
    case SSN
    case Email
    case Mobile
    case DateOfBirth
}

extension PersonalInfoVC:PersonalnfoChangePopupDelegate
{
    func updateButtonPress(stringValueOfTextField: String) {
        switch self.editFor
        {
            case .FirstName:
                self.updateUserInfo(txtToUpdate: stringValueOfTextField)
            case .LastName:
                self.updateUserInfo(txtToUpdate: stringValueOfTextField)
            case .SSN:
                self.updateUserInfo(txtToUpdate: stringValueOfTextField)
            case .Email:
                print("Email \(stringValueOfTextField)")
                self.getUserDetails()
            case .Mobile:
                print("Mobile \(stringValueOfTextField)")
            case .DateOfBirth:
                self.updateUserInfo(txtToUpdate: stringValueOfTextField)
        }
    }
    
    func cancelButtonPress(stringValueOfTextField: String) {
        print(stringValueOfTextField)
    }
}

extension PersonalInfoVC:ChangePwdDelegate
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
