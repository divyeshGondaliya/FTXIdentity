//
//  SignInSecurityVC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 22/12/21.
//

import Foundation

extension SignInSecurityVC
{
    func getSigninInfo()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        AFWrapper.sharedInstance.requestGETURL(ApiURls.SigninInfo) { (jsonResponse) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponse.dictionary
            {
                if let data = dic["data"]?.dictionary
                {
                    self.signinInfo = data
                    self.setupDataToView()
                }
            }else{
                
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    func disable2FA()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        AFWrapper.sharedInstance.requestPut(ApiURls.Disable2Fa) { (responceJson) in
            LoadingOverlay.shared.hideOverlayView()
            self.getSigninInfo()
        } failure: { (error) in
            print(error)
        }
    }
    
    func removeAlernateEmail()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        let dic = ["email":nil] as [String:AnyObject]
        AFWrapper.sharedInstance.requestPut(ApiURls.AlternateEmail,parma: dic) { (responceJson) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = responceJson.dictionary
            {
                print(dic)
            }
            self.getSigninInfo()
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
                    self.getSigninInfo()
                }
            }
        } failure: { (error) in
            print(error)
        }

    }
    
    func dltMobileNumber(apiCallFor:String)
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        var dic = [:] as [String:AnyObject]
        dic["mobile"] = nil
        
        AFWrapper.sharedInstance.requestPut(apiCallFor, parma: dic) { (jsonResponce) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponce.dictionary
            {
                print(dic)
                let succeeded = dic["succeeded"]?.bool ?? false
                if succeeded
                {
                    self.getSigninInfo()
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
