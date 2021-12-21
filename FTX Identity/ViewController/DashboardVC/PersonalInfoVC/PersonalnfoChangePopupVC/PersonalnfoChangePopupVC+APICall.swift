//
//  PersonalnfoChangePopupVC+APICall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 21/12/21.
//

import Foundation
extension PersonalnfoChangePopupVC
{
    func getOtpForEmail()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        var dic = [:] as [String:AnyObject]
        dic["email"] = (self.txt_fiels.text ?? "") as AnyObject
        let apiCallFor = ApiURls.EmailUpdate
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
                        self.lbl_email_otp_send.text = "A text with a One Time Password (OTP) has been sent to your Email Address: \(self.txt_fiels.text ?? "")"
                        self.setupOtpView()
                    }
                }else{
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
        let apiCallFor = ApiURls.EmailVerify
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
                }
            }
        } failure: { (error) in
            print(error)
        }
    }
}
