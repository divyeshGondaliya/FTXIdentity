//
//  RetailerDetailsVC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import Foundation

extension RetailerDetailsVC
{
    func unShareIdentity(accountApplicationId:String)
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        AFWrapper.sharedInstance.requestDelete("\(ApiURls.delete_shredIdentity)\(accountApplicationId)") { (jsonResponse) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponse.dictionary
            {
                if dic["succeeded"]?.bool ?? false
                {
                    self.retailerData["identityShared"] = false
                }
                self.configureDataToView()
            }
        } failure: { (error) in
            print(error)
        }
    }
}
