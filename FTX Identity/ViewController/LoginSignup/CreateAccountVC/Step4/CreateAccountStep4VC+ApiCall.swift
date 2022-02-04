//
//  CreateAccountStep4VC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import Foundation
import Alamofire
import SwiftyJSON

extension CreateAccountStep4VC
{
    func uploadAllData(FrontImage:String,BackImage:String,selfieData:Data?)
    {
        print("FrontImage Size :- \(FrontImage.count)")
        print("BackImage Size :- \(BackImage.count)")
        var headers:HTTPHeaders  = []
        headers.add(name: APIConstant.authorization, value: "Bearer " + SignUpData.shared.access_token)
        headers.add(name: APIConstant.contentType, value: APIHeader.formData)
        
        var parameters = ["UserTempId":SignUpData.shared.userTempId]
        
        let finalUrl = APIEnvironment.mainURL + ApiURls.SignupStep4
        print(finalUrl)
        print(parameters)
        print(headers)
        
        parameters["FrontImage"] = "\(FrontImage)"
        parameters["BackImage"] = "\(BackImage)"
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
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
                                SignUpData.shared.firstName = biometricDetails["firstName"]?.string ?? ""
                                SignUpData.shared.lastName = biometricDetails["lastName"]?.string ?? ""
                                SignUpData.shared.dateOfBirth = biometricDetails["dateOfBirth"]?.string ?? ""
                                SignUpData.shared.biometricsVerfyByServer = true
                                self.goingToStep5()
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
    
    func validateSelfieImage(image1:String,image2:String)
    {
        print("image1 Size :- \(image1.count)")
        print("image2 Size :- \(image2.count)")
        var headers:HTTPHeaders  = []
        headers.add(name: APIConstant.authorization, value: "Bearer " + SignUpData.shared.access_token)
        headers.add(name: APIConstant.contentType, value: APIHeader.formData)
        let finalUrl = APIEnvironment.mainURL + ApiURls.validate_liveness
        
        var parameters = ["UserTempId":SignUpData.shared.userTempId]
        
        print(finalUrl)
        print(parameters)
        print(headers)
        
        parameters["Image1"] = "data:image/jpeg;base64,\(image1)"
        parameters["Image2"] = "data:image/jpeg;base64,\(image2)"
        
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, to: finalUrl, usingThreshold: UInt64.init(), method: .post,headers: headers).responseJSON { (responseObject) in
            switch responseObject.result {
            case .success(let value):
                let resJson = JSON(value)
                let succeeded = resJson["succeeded"].bool ?? false
                let message = resJson["message"].string ?? "Something went wrong!!!"
                if succeeded
                {
                    if let data = resJson["data"].dictionary
                    {
                        let succeededData = data["success"]?.bool ?? false
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
                print("Responce :- \(resJson)")
            case .failure(let error):
                let error : Error = responseObject.error ?? error
                print(error)
            }
        }
    }
    
//    func facemeImageValidate(image1:String)
//    {
//        print("image1 Size :- \(image1.count)")
////        print("image2 Size :- \(image2.count)")
//        var headers:HTTPHeaders  = []
//        headers.add(name: APIConstant.authorization, value: "Bearer " + SignUpData.shared.access_token)
//        headers.add(name: APIConstant.contentType, value: APIHeader.formData)
//        let finalUrl = APIEnvironment.mainURL + ApiURls.facemeImageValidate
//
//        var parameters = ["UserTempId":SignUpData.shared.userTempId]
//
//        print(finalUrl)
//        print(parameters)
//        print(headers)
//
//        parameters["image"] = "data:image/jpeg;base64,\(image1)"
////        parameters["Image2"] = "data:image/jpeg;base64,\(image2)"
//
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//        }, to: finalUrl, usingThreshold: UInt64.init(), method: .post,headers: headers).responseJSON { (responseObject) in
//            switch responseObject.result {
//            case .success(let value):
//                let resJson = JSON(value)
//                let succeeded = resJson["succeeded"].bool ?? false
//                let message = resJson["message"].string ?? "Something went wrong!!!"
//                if succeeded
//                {
//                    if let data = resJson["data"].dictionary
//                    {
//                        let succeededData = data["success"]?.bool ?? false
//                        if succeededData
//                        {
//                            if let image1 = SignUpData.shared.frontIDImg.pngData(){
//                                if let image2 = SignUpData.shared.backIDImg.pngData(){
//                                    let str1 = image1.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
//                                    let str2 = image2.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
//                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
//                                        self.uploadAllData(FrontImage: str1, BackImage: str2, selfieData: nil)
//                                    }
//                                }
//                            }
//                        }else{
//                            self.loadingView.isHidden = true
//                            self.hideanimation = true
//                            var msgToDisplay = ""
//                            if let errors = data["errors"]?.array
//                            {
//                                if errors.count > 0
//                                {
//                                    if let dictmp = errors[0].dictionary
//                                    {
//                                        msgToDisplay = dictmp["message"]?.string ?? ""
//                                    }
//                                }
//                            }
//                            CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: msgToDisplay.count == 0 ? "Something went wrong!!!":msgToDisplay, andAlertType: 3)
//                        }
//                    }else{
//                        self.loadingView.isHidden = true
//                        self.hideanimation = true
//                        CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: "Something went wrong!!!", andAlertType: 3)
//                    }
//
//                }else{
//                    self.loadingView.isHidden = true
//                    self.hideanimation = true
//                    CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: message , andAlertType: 3)
//                }
//                print("Responce :- \(resJson)")
//            case .failure(let error):
//                let error : Error = responseObject.error ?? error
//                print(error)
//            }
//        }
//    }
    
    
    func facemeImageValidate(image1:String)
    {
        let dic = ["userTempId":SignUpData.shared.userTempId,
                   "image":image1] as [String:AnyObject]
        
        AFWrapper.sharedInstance.requestPOSTURL(ApiURls.facemeImageValidate, accessTokenSignup: SignUpData.shared.access_token, params: dic) { (jsonobj) in
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
