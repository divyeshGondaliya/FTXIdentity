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
                        self.generateQRCode(qrstring: authenticatorUri)
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
    
    
    
    func generateQRCode(qrstring:String)
    {
        // Get data from the string
        let data = qrstring.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return }
        let processedImage = UIImage(cgImage: cgImage)
        self.img_qrcode.image = processedImage
    }
}
