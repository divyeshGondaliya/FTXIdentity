//
//  PersonalInfoVC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import Foundation
import Alamofire
import SwiftyJSON

extension PersonalInfoVC
{
    func getUserDetails()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        AFWrapper.sharedInstance.requestGETURL(ApiURls.personalInfo) { (jsonResponse) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponse.dictionary
            {
                if let data = dic["data"]?.dictionary
                {
                    self.userData = data
                    self.setupDataToView()
                }
            }else{
                
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    func updateUserInfo(txtToUpdate:String)
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        var dic = [:] as [String:AnyObject]
        switch self.editFor
        {
            case .FirstName:
                dic["firstName"] = txtToUpdate as AnyObject
            case .LastName:
                dic["lastName"] = txtToUpdate as AnyObject
            case .SSN:
                if txtToUpdate.count > 0
                {
                    dic["ssn"] = txtToUpdate as AnyObject
                    dic["confirmSSN"] = txtToUpdate as AnyObject
                }
            case .Email:
                dic["firstName"] = txtToUpdate as AnyObject
            case .Mobile:
                dic["firstName"] = txtToUpdate as AnyObject
            case .DateOfBirth:
                dic["dob"] = txtToUpdate as AnyObject
                dic["confirmDOB"] = txtToUpdate as AnyObject
        }
        var apiCallFor = ApiURls.firstNameUpdate
        
        switch self.editFor
        {
            case .FirstName:
                apiCallFor = ApiURls.firstNameUpdate
            case .LastName:
                apiCallFor = ApiURls.lastNameUpdate
            case .SSN:
                apiCallFor = ApiURls.SSNUpdate
            case .Email:
                apiCallFor = ApiURls.firstNameUpdate
            case .Mobile:
                apiCallFor = ApiURls.firstNameUpdate
            case .DateOfBirth:
                apiCallFor = ApiURls.DOBUpdate
        }
        
        AFWrapper.sharedInstance.requestPut(apiCallFor, parma: dic) { (jsonResponce) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponce.dictionary
            {
                print(dic)
                let succeeded = dic["succeeded"]?.bool ?? false
                if succeeded
                {
                    self.getUserDetails()
                }
            }
        } failure: { (error) in
            print(error)
        }

    }
    
    func deleteProfilePic()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        AFWrapper.sharedInstance.requestDelete(ApiURls.dltProfile) { (responceJson) in
            LoadingOverlay.shared.hideOverlayView()
            self.getUserDetails()
        } failure: { (error) in
            print(error)
        }
    }
    
}

extension PersonalInfoVC
{
    func uploadProfilePic(imgData:Data,fileName:String)
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        print("Image Size :- \(imgData.count)")
        print("Image Name :- tmpFile.\(fileName)")
        var headers:HTTPHeaders  = []
        headers.add(name: APIConstant.authorization, value: "Bearer " + AuthLoginClass.shared.FreshToken)
        headers.add(name: APIConstant.contentType, value: APIHeader.formData)
        
//        let parameters = [:]
        
        let finalUrl = APIEnvironment.mainURL + ApiURls.updateProfileImage
        print(finalUrl)
//        print(parameters)
        print(headers)
        
        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//            multipartFormData.append(imgData, withName: "Image", fileName: "tmpFile.\(fileName)")
//            multipartFormData.append(imgData, withName: "Image")
            multipartFormData.append(imgData, withName: "Image", fileName: "tmp.\(fileName)", mimeType: "image/\(fileName)")
        }, to: finalUrl, usingThreshold: UInt64.init(), method: .put,headers: headers).responseJSON { (responseObject) in
            LoadingOverlay.shared.hideOverlayView()
            switch responseObject.result {
            case .success(let value):
                let resJson = JSON(value)
                let succeeded = resJson["succeeded"].bool ?? false
                if succeeded
                {
                    self.getUserDetails()
                }else{
                    if let message = resJson["message"].string
                    {
                        CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: message, andAlertType: 3)
                    }
                }
                print("Responce :- \(resJson)")
            case .failure(let error):
                let error : Error = responseObject.error ?? error
                print(error)
            }
        }
    }
}
