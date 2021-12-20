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
    func uploadAllData(FrontImage:Data,BackImage:Data)
    {
        print("Video Size :- \(SignUpData.shared.videoSelfie.count)")
        print("FrontImage Size :- \(FrontImage.count)")
        print("BackImage Size :- \(BackImage.count)")
//        LoadingOverlay.shared.showOverlay(view: self.view)        
        var headers:HTTPHeaders  = []
        headers.add(name: APIConstant.authorization, value: "Bearer " + SignUpData.shared.access_token)
        headers.add(name: APIConstant.contentType, value: APIHeader.formData)
        
        let parameters = ["UserTempId":SignUpData.shared.userTempId]
        
        let finalUrl = APIEnvironment.mainURL + ApiURls.SignupStep4
        print(finalUrl)
        print(parameters)
        print(headers)
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if let data = SignUpData.shared.videoSelfie
            {
                multipartFormData.append(data, withName: "SelfVideo", fileName: "output.mp4")
            }
//            if let data = SignUpData.shared.frontIDImg.pngData(){
                multipartFormData.append(FrontImage, withName: "FrontImage", fileName: "image.png")
//            }
//            if let data = SignUpData.shared.backIDImg.pngData(){
                multipartFormData.append(BackImage, withName: "BackImage", fileName: "image2.png")
//            }
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
                    CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: "Please make sure that your id proof photos clear and selfie video with audio is loud and clear.", andAlertType: 3)
                }
                print("Responce :- \(resJson)")
            case .failure(let error):
                let error : Error = responseObject.error ?? error
                print(error)
            }
        }
    }
}
