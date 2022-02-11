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
    @IBOutlet weak var view_id: UIView!
    @IBOutlet weak var view_selfie: UIView!
    @IBOutlet weak var lbl_id_scan: UILabel!
    @IBOutlet weak var lbl_selfie: UILabel!
    
    @IBOutlet weak var img_id_scan: UIImageView!
    @IBOutlet weak var img_selfie: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if SignUpData.shared.backIDImg != nil && SignUpData.shared.frontIDImg != nil
        {
            self.img_id_scan.tintColor = #colorLiteral(red: 0.05882352941, green: 0.631372549, blue: 0.2509803922, alpha: 1)
        }else{
            self.img_id_scan.tintColor = #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1)
        }
        if SignUpData.shared.selfieImageFaceMe != nil
        {
            self.img_selfie.tintColor = #colorLiteral(red: 0.05882352941, green: 0.631372549, blue: 0.2509803922, alpha: 1)
        }else{
            self.img_selfie.tintColor = #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1)
        }
        if SignUpData.shared.backIDImg != nil && SignUpData.shared.frontIDImg != nil && SignUpData.shared.selfieImageFaceMe != nil
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
        if SignUpData.shared.frontIDImg != nil && SignUpData.shared.backIDImg != nil && SignUpData.shared.selfieImageFaceMe != nil
        {
//            if let image1 = SignUpData.shared.selfieImage_1.pngData(){
//                if let image2 = SignUpData.shared.selfieImage_2.pngData(){
//                    let str1 = image1.base64EncodedString(options: .endLineWithLineFeed)//Data.Base64EncodingOptions.lineLength64Characters)
//                    let str2 = image2.base64EncodedString(options: .endLineWithLineFeed)
//                    self.hideanimation = false
//                    self.loadingView.isHidden = false
//                    self.showanimationTopBottomAndBottomTop()
//                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
//                        self.validateSelfieImage(image1: str1, image2: str2)
//                    }
//                }
//            }
            
//            if let frontIDImg = SignUpData.shared.frontIDImg.pngData(){
//                if let backIDImg = SignUpData.shared.backIDImg.pngData(){
////                    if let selfieData = SignUpData.shared.selfieImage.pngData(){
//                        self.hideanimation = false
//                        self.loadingView.isHidden = false
//                        self.showanimationTopBottomAndBottomTop()
//                        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
//                            self.uploadAllData(FrontImage: frontIDImg, BackImage: backIDImg,selfieData: nil)
//                        }
////                    }
//                }
//            }
            if let image = SignUpData.shared.selfieImageFaceMe.pngData()//SignUpData.shared.selfieImageFaceMe.jpegData(compressionQuality: 0.5)
            {
                self.hideanimation = false
                self.loadingView.isHidden = false
                self.showanimationTopBottomAndBottomTop()
                let imgData = image.base64EncodedString(options: .endLineWithLineFeed)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    self.facemeImageValidate(image1: imgData)
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
        if SignUpData.shared.selfieImageFaceMe != nil
        {
            showalertYesNo(vc: self, title: AlertString.title, subTitle: StringMsgToDisplay.selfieAlreadyTaken) {
//                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//                let fileUrl = paths[0].appendingPathComponent("output.mp4")
//                try? FileManager.default.removeItem(at: fileUrl)
                SignUpData.shared.selfieImageFaceMe = nil
                self.goingToVideoRecord()
            } failure: {
            }
        }else{
//            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            let fileUrl = paths[0].appendingPathComponent("output.mp4")
//            try? FileManager.default.removeItem(at: fileUrl)
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
