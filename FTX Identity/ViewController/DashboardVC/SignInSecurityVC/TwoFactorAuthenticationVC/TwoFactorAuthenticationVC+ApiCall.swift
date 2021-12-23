//
//  TwoFactorAuthenticationVC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 22/12/21.
//

import Foundation
import UIKit

extension TwoFactorAuthenticationVC
{
    func getProfileEnable2Fa()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        AFWrapper.sharedInstance.requestGETURL(ApiURls.Profile_Enable2Fa) { (jsonResponse) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponse.dictionary
            {
                print(dic)
                if let data = dic["data"]?.dictionary
                {
                    if let authenticatorUri = data["authenticatorUri"]?.string
                    {
                        print(authenticatorUri)
                        self.img_qrcode.image = authenticatorUri.generateQRCode()
                    }
                    if let sharedKey = data["sharedKey"]?.string
                    {
                        self.enterThisCode.text = sharedKey
                    }
                }
            }else{
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    func enable2FA(appcode:String)
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        let dic = ["code":appcode] as [String:AnyObject]
        AFWrapper.sharedInstance.requestPut(ApiURls.Save2Fa,parma: dic) { (jsonResponce) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponce.dictionary
            {
                if let data = dic["data"]?.dictionary
                {
                    if let recoveryCodes = data["recoveryCodes"]?.array
                    {
                        self.recoveryCodes = recoveryCodes
                        let vc = TwoFASuccessVC(nibName: "TwoFASuccessVC", bundle: nil)
                        vc.recoveryCodes = self.recoveryCodes
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                print(dic)
            }
        } failure: { (error) in
            print(error)
        }
    }
}
