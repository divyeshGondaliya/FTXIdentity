//
//  SearchRetailerVC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 17/12/21.
//

import Foundation
import UIKit

extension SearchRetailerVC
{
    func unShareIdentity(accountApplicationId:String)
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        AFWrapper.sharedInstance.requestDelete("\(ApiURls.delete_shredIdentity)\(accountApplicationId)") { (jsonResponse) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponse.dictionary
            {
                if self.vcForMemberShip
                {
                    var int_id = 0
                    if dic["succeeded"]?.bool ?? false
                    {
                        for item in self.itemToDisplay
                        {
                            if item["accountApplicationId"]?.string ?? "" == accountApplicationId
                            {
                                break
                            }
                            int_id += 1
                        }
                        self.itemToDisplay.remove(at: int_id)
                        self.tbl_view.reloadData()
                    }
                }else{
                    print(dic)
                    var int_id = 0
                    if dic["succeeded"]?.bool ?? false
                    {
                        for item in self.itemToDisplay
                        {
                            if item["accountApplicationId"]?.string ?? "" == accountApplicationId
                            {
                                self.itemToDisplay[int_id]["identityShared"] = false
                                break
                            }
                            int_id += 1
                        }
                    }
                    
                    self.tbl_view.reloadData()
                }
                
            }
        } failure: { (error) in
            print(error)
        }
    }
    
    
    func getRetailer(search:String)
    {
        self.img_no_data.isHidden = true
        self.dummy_tbl_view.isHidden = false
        var dic = ["membershipType":0,
                   "PageSize":self.pagesize,
                   "Page": self.pageIndex] as [String:AnyObject]
        if search.count > 0
        {
            dic["searchKeyword"] = search as AnyObject
        }
        if vcForMemberShip
        {
            dic["Filters"] = "identityShared==true" as AnyObject
        }
        
        AFWrapper.sharedInstance.requestGETURL(ApiURls.Memberships,parma: dic) { (jsonResponse) in
            if let dic = jsonResponse.dictionary
            {
                if self.pageIndex == 1
                {
                    self.itemToDisplay.removeAll()
                    self.tbl_view.reloadData()
                }
                if let data = dic["data"]?.dictionary
                {
//                    print(dic)
                    self.totalPages = data["totalPages"]?.int ?? 0
                    self.hasNextPage = data["hasNextPage"]?.bool ?? false
                    
                    if let array = data["items"]?.array
                    {
                        for item in array
                        {
                            if let dic = item.dictionary
                            {
                                self.itemToDisplay.append(dic)
                            }
                        }
                    }
                    self.dummy_tbl_view.isHidden = true
                    if self.itemToDisplay.count == 0
                    {
                        self.img_no_data.isHidden = false
                    }else{
                        self.img_no_data.isHidden = true
                    }
                    self.tbl_view.reloadData()
                }
            }else{
            }
        } failure: { (error) in
            print(error)
        }

    }
    
    func loadMore()
    {
        if self.hasNextPage
        {
            self.pageIndex += 1
            self.getRetailer(search: self.txt_search_retailer.text?.count ?? 0 > 0 ? self.txt_search_retailer.text ?? "" : "")
        }
    }
}
