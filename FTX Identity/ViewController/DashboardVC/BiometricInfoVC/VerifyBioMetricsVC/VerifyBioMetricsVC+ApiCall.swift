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
    func uploadAllData(FrontImage:Data,BackImage:Data,selfieData:Data?)
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
        AF.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(FrontImage, withName: "FrontImage", fileName: "image.png")
                multipartFormData.append(BackImage, withName: "BackImage", fileName: "image2.png")
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
}
