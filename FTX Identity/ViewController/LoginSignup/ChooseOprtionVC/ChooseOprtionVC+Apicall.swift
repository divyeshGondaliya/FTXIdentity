//
//  ChooseOprtionVC+Apicall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import Foundation
import UIKit

extension ChooseOprtionVC
{
    func getGuestToken()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        let dic = ["client_id":ApiKey.CLIENT_CREDENTIALS_CLIENTID,
                   "client_secret":ApiKey.CLIENT_CREDENTIALS_SECRET,
                   "grant_type":ApiKey.CLIENT_CREDENTIALS_GRANT_TYPE] as [String:AnyObject]
        AFWrapper.sharedInstance.requestPOSTURL(ApiURls.guestToken, params: dic) { (jsonobj) in
            hideOverlay()
            if let dic = jsonobj.dictionary
            {
                let access_token = dic["access_token"]?.string ?? ""
                if access_token.count > 0
                {
                    DispatchQueue.main.async {
                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateAccountStep1VC") as? CreateAccountStep1VC
                        {
                            SignUpData.shared.access_token = access_token
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        } failure: { (error) in
            print(error.localizedDescription)
            hideOverlay()
        }
        
    }
}
