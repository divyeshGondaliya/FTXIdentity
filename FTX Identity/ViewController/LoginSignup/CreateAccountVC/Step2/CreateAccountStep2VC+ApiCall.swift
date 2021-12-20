//
//  CreateAccountStep2VC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import Foundation
import UIKit

extension CreateAccountStep2VC
{
    func generateOTP()
    {
        let pwd = self.txt_pwd.text ?? ""
        LoadingOverlay.shared.showOverlay(view: self.view)
        let dic = ["signUpBy":SignUpData.shared.signUpBy,
                   "userName":SignUpData.shared.userName,
                   "email": SignUpData.shared.email,
                   "countryCode":SignUpData.shared.countryCode,
                   "phoneNumber":SignUpData.shared.phoneNumber,
                   "password":pwd] as [String:AnyObject]
        
        AFWrapper.sharedInstance.requestPOSTURL(ApiURls.SignupStep2, accessTokenSignup: SignUpData.shared.access_token, params: dic) { (jsonobj) in
            hideOverlay()
            if let dic = jsonobj.dictionary
            {
                print(dic)
                let succeeded = dic["succeeded"]?.bool ?? false
                if succeeded
                {
                    if let data = dic["data"]?.dictionary
                    {
                        if let userTempId = data["userTempId"]?.string
                        {
                            if userTempId.count > 0
                            {
                                SignUpData.shared.userTempId = userTempId
                                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateAccountStep3VC") as? CreateAccountStep3VC
                                {
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        }
                    }
                }else{
                    let errors = dic["errors"]?.dictionary
                    if let INVALID_PASSWORD = errors?["INVALID_PASSWORD"]?.array
                    {
                        if INVALID_PASSWORD.count > 0
                        {
                            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: INVALID_PASSWORD[0].string, andAlertType: 3)
                        }
                    }
                    
                }
            }
        } failure: { (error) in
            print(error.localizedDescription)
            hideOverlay()
        }
        
    }
}
