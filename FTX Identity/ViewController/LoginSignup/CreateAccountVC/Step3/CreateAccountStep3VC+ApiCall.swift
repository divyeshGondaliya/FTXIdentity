//
//  CreateAccountStep3VC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import Foundation
import UIKit

extension CreateAccountStep3VC
{
    func verifyOTP(otp:String)
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        let dic = ["userTempId":SignUpData.shared.userTempId,
                   "otp":otp] as [String:AnyObject]
        
        AFWrapper.sharedInstance.requestPOSTURL(ApiURls.SignupStep3, accessTokenSignup: SignUpData.shared.access_token, params: dic) { (jsonobj) in
            hideOverlay()
            if let dic = jsonobj.dictionary
            {
                print(dic)
                let succeeded = dic["succeeded"]?.bool ?? false
                if succeeded
                {
                    if let data = dic["data"]?.dictionary
                    {
                        let isSuccess = data["isSuccess"]?.bool ?? false
                        if isSuccess{
                            if let infoForBiometric = data["infoForBiometric"]?.dictionary
                            {
                                SignUpData.shared.biometricOption = infoForBiometric["biometricOption"]?.int ?? 0
                                SignUpData.shared.biometricCode = infoForBiometric["biometricCode"]?.int ?? 0
                                print(SignUpData.shared.biometricOption)
                                print(SignUpData.shared.biometricCode)
                            }
                            if SignUpData.shared.biometricOption == 0
                            {
                                //Skip Here step 4 and go to step 5
                            }else if SignUpData.shared.biometricOption == 1
                            {
                                self.goingToStep4()
                            }else if SignUpData.shared.biometricOption == 2{
                                self.goingToStep4()
                            }
                            
                        }else{
                            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: StringMsgToDisplay.otpError, andAlertType: 3)
                        }
                    }
                }
            }
        } failure: { (error) in
            print(error.localizedDescription)
            hideOverlay()
        }
        
    }
    
    func goingToStep4()
    {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CreateAccountStep4VC") as? CreateAccountStep4VC
        {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func reSendOTP()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        let dic = ["userTempId":SignUpData.shared.userTempId] as [String:AnyObject]
        
        AFWrapper.sharedInstance.requestPOSTURL(ApiURls.OtpResend, accessTokenSignup: SignUpData.shared.access_token, params: dic) { (jsonobj) in
            hideOverlay()
            if let dic = jsonobj.dictionary
            {
                print(dic)
                let succeeded = dic["succeeded"]?.bool ?? false
                if succeeded
                {
                    self.startOtpTimer()
                }
            }
        } failure: { (error) in
            print(error.localizedDescription)
            hideOverlay()
        }
        
    }
}
