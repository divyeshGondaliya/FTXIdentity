//
//  MobileNumberVC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 24/12/21.
//

import Foundation
import OTPFieldView

extension MobileNumberVC
{
    func getOtpForMobile()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        var dic = [:] as [String:AnyObject]
        dic["countryCode"] = (self.txt_country_code.text ?? "") as AnyObject
        dic["mobile"] = (self.txt_mobile_number.text ?? "") as AnyObject
        
        var apiCallFor = ApiURls.ProfileMobileUpdate
        if forAlternate
        {
            apiCallFor = ApiURls.AlternateMobile
        }
        AFWrapper.sharedInstance.requestPut(apiCallFor, parma: dic) { (jsonResponce) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponce.dictionary
            {
                print(dic)
                let succeeded = dic["succeeded"]?.bool ?? false
                if succeeded
                {
                    DispatchQueue.main.async {
                        self.otp_view.isHidden = false
                        self.lbl_mobile_otp_send.text = "A text with a One Time Password (OTP) has been sent to your Phone Number: \(self.txt_country_code.text ?? "") \(self.txt_mobile_number.text ?? "")"
                        self.setupOtpView()
                    }
                }else{
                    if let message = dic["message"]?.string
                    {
                        CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: message, andAlertType: 3)
                    }
                }
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    func verifyOtp()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        var dic = [:] as [String:AnyObject]
        dic["otp"] = self.strOTP as AnyObject
        
        var apiCallFor = ApiURls.MobileVerifyUpdate
        if forAlternate
        {
            apiCallFor = ApiURls.AlternateMobileVerify
        }
        AFWrapper.sharedInstance.requestPut(apiCallFor, parma: dic) { (jsonResponce) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponce.dictionary
            {
                print(dic)
                let succeeded = dic["succeeded"]?.bool ?? false
                if succeeded
                {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true) {
                            self.delegate?.updateButtonPress(stringValueOfTextField: "Email")
                        }
                    }
                }else{
                    if let message = dic["message"]?.string
                    {
                        CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: message, andAlertType: 3)
                    }
                }
            }
        } failure: { (error) in
            print(error)
        }
    }
}

extension MobileNumberVC:OTPFieldViewDelegate
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
