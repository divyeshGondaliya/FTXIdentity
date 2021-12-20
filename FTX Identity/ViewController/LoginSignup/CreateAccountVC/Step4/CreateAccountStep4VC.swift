//
//  CreateAccountStep4VC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 15/12/21.
//

import UIKit

class CreateAccountStep4VC: MainStuffViewController {
    var hideanimation = false
    @IBOutlet weak var btn_skip: UIButton!
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var img_bioMatrick: UIImageView!
    @IBOutlet weak var line_top: NSLayoutConstraint!
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if SignUpData.shared.backIDImg != nil && SignUpData.shared.frontIDImg != nil && SignUpData.shared.videoSelfie != nil
        {
            self.btn_next.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
        }else{
            self.btn_next.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.26)
        }
        self.uiRelatedStuff()
    }
    
    @IBAction func btn_skip_press(_ sender: Any) {
        self.goingToStep5()
    }
    
    @IBAction func btn_next_pres(_ sender: Any) {
        if SignUpData.shared.frontIDImg != nil && SignUpData.shared.backIDImg != nil && SignUpData.shared.videoSelfie != nil
        {
            if let frontIDImg = SignUpData.shared.frontIDImg.pngData(){
                if let backIDImg = SignUpData.shared.backIDImg.pngData(){
                    self.hideanimation = false
                    self.loadingView.isHidden = false
                    self.showanimationTopBottomAndBottomTop()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                        self.uploadAllData(FrontImage: frontIDImg, BackImage: backIDImg)
                    }
                }
            }
        }else{
            showalert(vc: self, title: "FTX Identity", subTitle: "Please first scan your ID Document and record your video for verification.")
        }
    }
    
    @IBAction func btn_id_scan(_ sender: Any) {
       
        if SignUpData.shared.frontIDImg != nil && SignUpData.shared.backIDImg != nil
        {
            showalertYesNo(vc: self, title: "FTX Identity", subTitle: "Are you sure you want to scan again? Your ID Document last ID Document will be deleted.") {
                SignUpData.shared.frontIDImg = nil
                SignUpData.shared.backIDImg = nil
                self.goingnToIDScan()
            } failure: {
            }
        }else{
            self.goingnToIDScan()
        }
    }
    
    
    
    @IBAction func btn_selfie_press(_ sender: Any) {
        if SignUpData.shared.videoSelfie != nil
        {
            showalertYesNo(vc: self, title: "FTX Identity", subTitle: "Are you sure you want to record again? Last video will be deleted.") {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let fileUrl = paths[0].appendingPathComponent("output.mp4")
                try? FileManager.default.removeItem(at: fileUrl)
                SignUpData.shared.videoSelfie = nil
                self.goingToVideoRecord()
            } failure: {
            }
        }else{
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileUrl = paths[0].appendingPathComponent("output.mp4")
            try? FileManager.default.removeItem(at: fileUrl)
            self.goingToVideoRecord()
        }
    }    
    
    @IBAction func btn_sign_in_press(_ sender: Any) {
        for item in self.navigationController?.viewControllers ?? []
        {
            if item is ChooseOprtionVC
            {
                self.navigationController?.popToViewController(item, animated: true)
                break
            }
        }
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateAccountStep4VC
{
    func uiRelatedStuff()
    {
        if SignUpData.shared.biometricOption == 1
        {
            self.btn_skip.isHidden = false
        }else if SignUpData.shared.biometricOption == 2{
            self.btn_skip.isHidden = true
        }
    }
}
