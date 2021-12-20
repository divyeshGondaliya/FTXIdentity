//
//  PersonalInfoVC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import Foundation

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
                    print(data)
                    if let basicInfo = data["basicInfo"]?.dictionary
                    {
                        if let profileImageUrl = basicInfo["profileImageUrl"]?.string
                        {
                            if let url = URL(string: profileImageUrl)
                            {
                                self.img_profile.kf.setImage(with: url)
                            }
                        }
                    }
                }
            }else{
                
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    func updateUserInfo(txtToUpdate:String)
    {
        var dic = [:] as [String:AnyObject]
        switch self.editFor
        {
            case .FirstName:
                dic["firstName"] = txtToUpdate as AnyObject
            case .LastName:
                dic["lastName"] = txtToUpdate as AnyObject
            case .SSN:
                dic["ssn"] = txtToUpdate as AnyObject
            case .Email:
                dic["firstName"] = txtToUpdate as AnyObject
            case .Mobile:
                dic["firstName"] = txtToUpdate as AnyObject
        }
        var apiCallFor = ApiURls.firstNameUpdate
        
        switch self.editFor
        {
            case .FirstName:
                apiCallFor = ApiURls.firstNameUpdate
            case .LastName:
                apiCallFor = ApiURls.lastNameUpdate
            case .SSN:
                apiCallFor = ApiURls.firstNameUpdate
            case .Email:
                apiCallFor = ApiURls.firstNameUpdate
            case .Mobile:
                apiCallFor = ApiURls.firstNameUpdate
        }
        
        AFWrapper.sharedInstance.requestPut(apiCallFor, parma: dic) { (jsonResponce) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponce.dictionary
            {
                print(dic)
            }
        } failure: { (error) in
            print(error)
        }

    }
}
