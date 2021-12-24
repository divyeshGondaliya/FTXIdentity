//
//  QrCodeDisplayVC+ApiCall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import Foundation

extension QrCodeDisplayVC
{
    func getQrCode()
    {
        AFWrapper.sharedInstance.requestGETURL(ApiURls.Identityqr) { (jsonResponse) in
            if let dic = jsonResponse.dictionary
            {
                print(dic)
            }else{
            }
        } failure: { (error) in
            print(error)
        }
    }
}
