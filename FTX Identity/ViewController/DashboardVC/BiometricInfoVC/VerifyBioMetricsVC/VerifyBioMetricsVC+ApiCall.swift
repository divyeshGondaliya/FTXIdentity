//
//  VerifyBioMetricsVC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import Foundation
import SwiftyJSON
import Alamofire

extension VerifyBioMetricsVC
{
    func uploadAllData(FrontImage:String,BackImage:String,selfieData:Data?)
    {
//        print("selfie size :- \(selfieData.count)")
        print("FrontImage Size :- \(FrontImage.count)")
        print("BackImage Size :- \(BackImage.count)")
        var headers:HTTPHeaders  = []
        headers.add(name: APIConstant.authorization, value: "Bearer " + AuthLoginClass.shared.FreshToken)
        headers.add(name: APIConstant.contentType, value: APIHeader.formData)
        
        
        let finalUrl = APIEnvironment.mainURL + ApiURls.BiometricVerify
        print(finalUrl)
        print(headers)
        var parameters = ["FrontImage": "\(FrontImage)"]
        parameters["BackImage"] = "\(BackImage)"
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
//                multipartFormData.append(FrontImage, withName: "FrontImage", fileName: "image.png")
//                multipartFormData.append(BackImage, withName: "BackImage", fileName: "image2.png")
//                multipartFormData.append(selfieData, withName: "SelfImage", fileName: "selfieData.png")
        }, to: finalUrl, usingThreshold: UInt64.init(), method: .post,headers: headers).responseJSON { (responseObject) in
            self.loadingView.isHidden = true
            self.hideanimation = true
            switch responseObject.result {
            case .success(let value):
                let resJson = JSON(value)
                let succeeded = resJson["succeeded"].bool ?? false
                if succeeded
                {
                    if let data = resJson["data"].dictionary
                    {
                        let isValid = data["isValid"]?.bool ?? false
                        if isValid
                        {
                            if let biometricDetails = data["biometricDetails"]?.dictionary
                            {
                                let firstName = biometricDetails["firstName"]?.string ?? ""
                                let lastName = biometricDetails["lastName"]?.string ?? ""
                                let dateOfBirth = biometricDetails["dateOfBirth"]?.string ?? ""
                                var bdy = ""
                                let arr = dateOfBirth.components(separatedBy: "T")
                                if arr.count > 0
                                {
                                    let dateStr = arr[0]
                                    let mainDateArr = dateStr.components(separatedBy: "-")
                                    if mainDateArr.count == 3
                                    {
                                        bdy = "\(mainDateArr[1])/\(mainDateArr[2])/\(mainDateArr[0])"
                                    }
                                }
                                
                                print("\(firstName + "" + lastName + "" + dateOfBirth)")
                                showalertYesNo(vc: self, title: AlertString.title, subTitle: "Please Verify Details\n\nFirst Name :- \(firstName)\nLast Name :- \(lastName)\nBirth Date :- \(bdy)") {
                                    print("Save To server")
                                    self.puBioMetricsToServer()
                                } failure: {
                                }
                            }
                        }else{
                            let failingReasons = data["failingReasons"]?.array
                            if failingReasons?.count ?? 0 > 0
                            {
                                CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: "\(failingReasons?[0].string ?? "")", andAlertType: 3)
                            }else{
                                CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: "Please try again.", andAlertType: 3)
                            }
                        }
                    }
                }else{
                    CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: StringMsgToDisplay.biometricsError, andAlertType: 3)
                }
                print("Responce :- \(resJson)")
            case .failure(let error):
                let error : Error = responseObject.error ?? error
                print(error)
            }
        }
    }
    
    func puBioMetricsToServer()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        AFWrapper.sharedInstance.requestPut(ApiURls.ProfileBiometricPut) { (jsonresponce) in
            LoadingOverlay.shared.hideOverlayView()
            print(jsonresponce)
            UserDefaults.standard.removeObject(forKey: "UserImageToCompare_FTx")
            UserDefaults.standard.synchronize()
            for item in self.navigationController?.viewControllers ?? []
            {
                if item is DashboardVC
                {
                    self.navigationController?.popToViewController(item, animated: true)
                    break
                }
            }
        } failure: { (error) in
            print(error)
        }

    }
    
    
    func facemeImageValidate(image1:String)
    {
        let dic = ["image":image1] as [String:AnyObject]
        
        AFWrapper.sharedInstance.requestPOSTURL(ApiURls.facemeImageValidate, accessTokenSignup: "", params: dic) { (jsonobj) in
            if let dic = jsonobj.dictionary
            {
                print(dic)
                let succeeded = dic["succeeded"]?.bool ?? false
                let message = dic["message"]?.string ?? "Something went wrong!!!"
                if succeeded
                {
                    if let data = dic["data"]?.dictionary
                    {
                        let succeededData = data["succeeded"]?.bool ?? false
                        if succeededData
                        {
                            if let image1 = SignUpData.shared.frontIDImg.pngData(){
                                if let image2 = SignUpData.shared.backIDImg.pngData(){
                                    let str1 = image1.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
                                    let str2 = image2.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                        self.uploadAllData(FrontImage: str1, BackImage: str2, selfieData: nil)
                                    }
                                }
                            }
                        }else{
                            self.loadingView.isHidden = true
                            self.hideanimation = true
                            var msgToDisplay = ""
                            if let errors = data["errors"]?.array
                            {
                                if errors.count > 0
                                {
                                    if let dictmp = errors[0].dictionary
                                    {
                                        msgToDisplay = dictmp["message"]?.string ?? ""
                                    }
                                }
                            }
                            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: msgToDisplay.count == 0 ? "Something went wrong!!!":msgToDisplay, andAlertType: 3)
                        }
                    }else{
                        self.loadingView.isHidden = true
                        self.hideanimation = true
                        CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: "Something went wrong!!!", andAlertType: 3)
                    }
                    
                }else{
                    self.loadingView.isHidden = true
                    self.hideanimation = true
                    CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: message , andAlertType: 3)
                }

            }
        } failure: { (error) in
            print(error.localizedDescription)
            hideOverlay()
        }
        
    }
}
