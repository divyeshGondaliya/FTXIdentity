//
//  DashboardVC+APICall.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 07/02/22.
//

import Foundation
extension DashboardVC
{
    func getBioMetricData()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        AFWrapper.sharedInstance.requestGETURL(ApiURls.ProfileBiometric) { (jsonResponse) in
            if let dic = jsonResponse.dictionary
            {
                if let data = dic["data"]?.dictionary
                {
                    print(data)
                    let img_url = data["selfImageUrl"]?.string ?? ""
                    if img_url.count > 0
                    {
                        if let url = URL(string: img_url)
                        {
                            self.btn_profile_qr.isHidden = false
                            self.downloadImage(from: url)
                        }else{
                            self.btn_profile_qr.isHidden = true
                            LoadingOverlay.shared.hideOverlayView()
                        }
                    }else{
                        self.btn_profile_qr.isHidden = true
                        LoadingOverlay.shared.hideOverlayView()
                    }
                }else{
                    self.btn_profile_qr.isHidden = true
                    LoadingOverlay.shared.hideOverlayView()
                }
            }else{
                self.btn_profile_qr.isHidden = true
                LoadingOverlay.shared.hideOverlayView()
            }
        } failure: { (error) in
            print(error)
            self.btn_profile_qr.isHidden = true
            LoadingOverlay.shared.hideOverlayView()
        }

    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async {
                UserDefaults.standard.set(data, forKey: "UserImageToCompare_FTx")
                UserDefaults.standard.synchronize()
            }
        }
    }
}
