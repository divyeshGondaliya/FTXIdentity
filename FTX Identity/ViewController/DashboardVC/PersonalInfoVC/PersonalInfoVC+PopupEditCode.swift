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
                print("SSN \(stringValueOfTextField)")
            case .Email:
                print("Email \(stringValueOfTextField)")
            case .Mobile:
                print("Mobile \(stringValueOfTextField)")
        }
    }
    
    func cancelButtonPress(stringValueOfTextField: String) {
        print(stringValueOfTextField)
    }
}
