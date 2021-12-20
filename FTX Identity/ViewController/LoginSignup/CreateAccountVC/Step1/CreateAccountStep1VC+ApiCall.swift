//
//  CreateAccountStep1VC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import Foundation
import UIKit
extension CreateAccountStep1VC
{
    func checkEmailAndPhoneAvailability()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        let signUpBy = self.view_phone_number.alpha == 0 ? SignupBy.Email : SignupBy.PhoneNumber
        let email = (self.view_phone_number.alpha == 0) ? self.txt_email.text ?? "" : ""
        let countryCode = self.view_phone_number.alpha == 0 ? "" : self.txt_country_code.text ?? ""
        let phoneNumber = self.view_phone_number.alpha == 0 ? "" : self.txt_phone_number.text ?? ""
        
        let dic = ["signUpBy":signUpBy,
                   "userName":"",
                   "email": email,
                   "countryCode":countryCode,
                   "phoneNumber":phoneNumber] as [String:AnyObject]
        
        AFWrapper.sharedInstance.requestPOSTURL(ApiURls.SignupStep1, accessTokenSignup: SignUpData.shared.access_token, params: dic) { (jsonobj) in
            hideOverlay()
            if let dic = jsonobj.dictionary
            {
                let succeeded = dic["succeeded"]?.bool ?? false
                if succeeded
                {
                    if let data = dic["data"]?.dictionary
                    {
                        if let isAvailable = data["isAvailable"]?.bool
                        {
                            if isAvailable
                            {
                                DispatchQueue.main.async {
                                    SignUpData.shared.email = email
                                    SignUpData.shared.signUpBy = signUpBy
                                    SignUpData.shared.countryCode = countryCode
                                    SignUpData.shared.phoneNumber = phoneNumber
                                    
                                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CreateAccountStep2VC") as? CreateAccountStep2VC
                                    {
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                }
                            }else{
                                CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: "Email: \(self.txt_email.text ?? "") is already being used.", andAlertType: 3)
                            }
                        }
                    }
                }else{
                    CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: dic["message"]?.string ?? "", andAlertType: 3)
                }
            }
        } failure: { (error) in
            print(error.localizedDescription)
            
            hideOverlay()
        }
        
    }
}
