//
//  BiometricInfoVC+ApiCall.swift
//  FTX Identity
//
//  Created by Darshan on 23/12/21.
//

import Foundation
extension BiometricInfoVC
{
    func getBioMetricData()
    {
        self.tbl_view.isHidden = true
        LoadingOverlay.shared.showOverlay(view: self.view)
        AFWrapper.sharedInstance.requestGETURL(ApiURls.ProfileBiometric) { (jsonResponse) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponse.dictionary
            {
                if let data = dic["data"]?.dictionary
                {
                    print(data)
                    self.idBackImageUrl = data["idBackImageUrl"]?.string ?? ""
                    self.idFrontImageUrl = data["idFrontImageUrl"]?.string ?? ""
                    self.selfImageUrl = data["selfImageUrl"]?.string ?? ""
                    
                    self.btn_verify_again.setTitle("Verify Again", for: .normal)
                    self.tbl_view.isHidden = false
                }else{
                    self.btn_verify_again.setTitle("Verify", for: .normal)
                    self.tbl_view.isHidden = true
                }
            }else{
                
            }
        } failure: { (error) in
            print(error)
        }

    }
}
