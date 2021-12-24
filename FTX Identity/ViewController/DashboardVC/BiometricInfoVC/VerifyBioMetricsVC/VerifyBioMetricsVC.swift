//
//  VerifyBioMetricsVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import UIKit

class VerifyBioMetricsVC: UIViewController {

    @IBOutlet weak var btn_upload: UIButton!
    
    var hideanimation = false
    @IBOutlet weak var img_bioMatrick: UIImageView!
    @IBOutlet weak var line_top: NSLayoutConstraint!
    @IBOutlet weak var loadingView: UIView!
    
    
    override func viewDidLoad() {
        AuthLoginClass.shared.gettingFreshToken { (reson) in            
        }
        super.viewDidLoad()
        self.view.bringSubviewToFront(self.loadingView)
        self.loadingView.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if SignUpData.shared.backIDImg != nil && SignUpData.shared.frontIDImg != nil && SignUpData.shared.selfieImage != nil
        {
            self.btn_upload.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
        }else{
            self.btn_upload.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.26)
        }
    }
    
    @IBAction func btn_skip_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_upload_pres(_ sender: Any) {
        if SignUpData.shared.frontIDImg != nil && SignUpData.shared.backIDImg != nil && SignUpData.shared.selfieImage != nil
        {
            if let frontIDImg = SignUpData.shared.frontIDImg.pngData(){
                if let backIDImg = SignUpData.shared.backIDImg.pngData(){
                    if let selfieData = SignUpData.shared.selfieImage.pngData(){
                        self.hideanimation = false
                        self.loadingView.isHidden = false
                        self.showanimationTopBottomAndBottomTop()
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                            self.uploadAllData(FrontImage: frontIDImg, BackImage: backIDImg,selfieData: selfieData)
                        }
                    }
                }
            }
        }else{
            showalert(vc: self, title: AlertString.title, subTitle: StringMsgToDisplay.takeAllBiometricsFirst)
        }
    }
    
    @IBAction func btn_id_scan(_ sender: Any) {
       
        if SignUpData.shared.frontIDImg != nil && SignUpData.shared.backIDImg != nil
        {
            showalertYesNo(vc: self, title: AlertString.title, subTitle: StringMsgToDisplay.idAlreadyScaned) {
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
        if SignUpData.shared.selfieImage != nil
        {
            showalertYesNo(vc: self, title: AlertString.title, subTitle: StringMsgToDisplay.selfieAlreadyTaken) {
                SignUpData.shared.selfieImage = nil
                self.goingToVideoRecord()
            } failure: {
            }
        }else{
            self.goingToVideoRecord()
        }
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}






