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
                let imagStr = dic["data"]?.string ?? ""
                if imagStr.count > 0
                {
                    if let decodedImageData = Data(base64Encoded: imagStr, options: .ignoreUnknownCharacters) {
                        DispatchQueue.main.async {
                            self.img_qr.image = UIImage(data: decodedImageData)
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

