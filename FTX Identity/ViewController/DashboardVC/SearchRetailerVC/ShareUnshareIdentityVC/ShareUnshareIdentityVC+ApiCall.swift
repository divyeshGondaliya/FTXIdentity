//
//  ShareUnshareIdentityVC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import Foundation
extension ShareUnshareIdentityVC
{
    func allowAccessToIdentity()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        let accountApplicationId = self.retailerData["accountApplicationId"]?.string ?? ""
        let claimTypes = self.getSendIdAll()
        
        let dic = ["accountApplicationId":accountApplicationId,
                   "claimTypes":claimTypes] as [String:AnyObject]
        
        AFWrapper.sharedInstance.requestPOSTURL(ApiURls.allow_Identity, params: dic) { (jsonResponce) in
            LoadingOverlay.shared.hideOverlayView()
            if jsonResponce["succeeded"].bool ?? false
            {
                let arr = self.navigationController?.viewControllers ?? []
                if arr.count > 0
                {
                    if arr[arr.count - 2] is RetailerDetailsVC
                    {
                        let vc = arr[arr.count - 2] as! RetailerDetailsVC
                        self.retailerData["identityShared"] = true
                        vc.retailerData = self.retailerData
                        self.navigationController?.popToViewController(vc, animated: true)
                    }else{
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
                
            }else{
                CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: "Please try again later.", andAlertType: 3)
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    func getClaimType()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        AFWrapper.sharedInstance.requestGETURL(ApiURls.ClaimType) { (jsonResponse) in
            LoadingOverlay.shared.hideOverlayView()
            self.claimTypeArr.removeAll()
            if let dic = jsonResponse.dictionary
            {
                if let data = dic["data"]?.array
                {
                    for item in data
                    {
                        if let dic = item.dictionary
                        {
                            self.claimTypeArr.append(dic)
                            self.switchOnid.append(dic["id"]?.string ?? "")
                        }
                    }
                }
                self.setupTodataArr()
            }else{
                
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    func setupTodataArr()
    {
        self.finalArrayToDisplay.removeAll()
        self.allRequiredInfo.removeAll()
        
        for item in self.claimTypeArr
        {
            if item["required"]?.bool ?? false
            {
                self.allRequiredInfo.append(item["title"]?.string ?? "")
            }else{
                self.finalArrayToDisplay.append(item)
            }
        }
        DispatchQueue.main.async {
            self.tbl_view.reloadData()
        }
    }
    
    func getSendIdAll()->[String]
    {
        var passParamId = [String]()
        
        passParamId = switchOnid
        
        for item in self.claimTypeArr
        {
            if item["required"]?.bool ?? false
            {
                passParamId.append(item["id"]?.string ?? "")
            }
        }
        
        return passParamId
    }
}
