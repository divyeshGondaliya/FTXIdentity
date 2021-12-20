//
//  PersonalInfoVC+ApiCall.swift
//  FTX Identity
//
//  Created by Darshan on 20/12/21.
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
}
