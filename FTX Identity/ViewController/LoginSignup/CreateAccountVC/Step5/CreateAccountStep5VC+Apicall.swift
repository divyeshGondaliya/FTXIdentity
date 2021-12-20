//
//  CreateAccountStep5VC+Apicall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 17/12/21.
//

import Foundation
import UIKit

extension CreateAccountStep5VC
{
    func signupTheThings()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        var dateOfBirth = ""
        if self.view_ssn.alpha == 0 && self.txt_bdate.text?.count ?? 0 > 0
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            if let date = formatter.date(from: self.txt_bdate.text ?? "")
            {
                formatter.dateFormat = "yyyy-MM-dd"
                dateOfBirth = formatter.string(from: date)
            }
        }
        
        let firstName = self.txt_fname.text ?? ""
        let lastName = self.txt_lname.text ?? ""
        let ssn = self.view_ssn.alpha == 0 ? "" : self.txt_ssn.text ?? ""
        dateOfBirth = self.view_ssn.alpha == 0 ? dateOfBirth : ""
        
        var dic = ["firstName":firstName,
                   "lastName":lastName,
                   "ssn": ssn,
                   "UserTempId":SignUpData.shared.userTempId] as [String:AnyObject]
        if dateOfBirth.count > 0
        {
            dic["dateOfBirth"] = dateOfBirth as AnyObject
        }
        AFWrapper.sharedInstance.requestPOSTURL(ApiURls.SignupStep5, accessTokenSignup: SignUpData.shared.access_token, params: dic) { (jsonobj) in
            hideOverlay()
            if let dic = jsonobj.dictionary
            {
                print(dic)
                let succeeded = dic["succeeded"]?.bool ?? false
                if succeeded
                {
                    let vc = SuccessSignupVC(nibName: "SuccessSignupVC", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    CustomAlertView.display(activeViewController:self, withTitle: nil, andMessage: dic["message"]?.string ?? "", andAlertType: 3)
                }
            }
        } failure: { (error) in
            print(error.localizedDescription)
            
            hideOverlay()
        }
        
    }
}
