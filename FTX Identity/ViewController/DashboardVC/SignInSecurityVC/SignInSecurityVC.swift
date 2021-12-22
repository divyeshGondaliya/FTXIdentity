//
//  SignInSecurityVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 22/12/21.
//

import UIKit
import SwiftyJSON

class SignInSecurityVC: UIViewController {

    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_recover_email: UILabel!
    @IBOutlet weak var lbl_mobile: UILabel!
    @IBOutlet weak var lbl_recover_mobile: UILabel!
    @IBOutlet weak var lbl_pwd: UILabel!
    @IBOutlet weak var lbl_2fa: UILabel!
    
    @IBOutlet weak var btn_edit_2fa: UIButton!
    @IBOutlet weak var btn_edit_email: UIButton!
    @IBOutlet weak var btn_edit_mobile: UIButton!
    @IBOutlet weak var btn_edit_recover_email: UIButton!
    @IBOutlet weak var btn_edit_recover_mobile: UIButton!
    
    @IBOutlet weak var btn_dlt_2fa: UIButton!
    @IBOutlet weak var btn_dlt_mobile: UIButton!
    
    var editFor = EditFor.FirstName
    var signinInfo = [String:JSON]()
    
    let add_img = UIImage(named: "add")
    let edit_img = UIImage(named: "edit")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getSigninInfo()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_2fa_edit(_ sender: Any) {
        
    }
    @IBAction func btn_2fa_dlt(_ sender: Any) {
    }
    
    @IBAction func btn_email_edit(_ sender: Any) {
        self.editFor = .Email
        self.openPopupForEdit()
    }
    @IBAction func btn_edit_recover_email_press(_ sender: Any) {
    }
    @IBAction func btn_mobile_edit(_ sender: Any) {
//        self.editFor = .Mobile
//        self.openPopupForEdit()
    }
    
    @IBAction func btn_dlt_mobile(_ sender: Any) {
    }
    
    @IBAction func btn_pwd_edit(_ sender: Any) {
        let vc = ChangePwdVC(nibName: "ChangePwdVC", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}

extension SignInSecurityVC
{
    func setupDataToView()
    {
        if let signinInfo = self.signinInfo["signinInfo"]?.dictionary
        {
            self.lbl_email.text = signinInfo["email"]?.string
            if signinInfo["twoFactorAuth"]?.bool ?? false
            {
                
            }else{
                self.lbl_2fa.text = "(Not Set)"
            }
            
            if (signinInfo["mobile"]?.null) != nil
            {
                self.lbl_mobile.text = "(Not Set)"
            }else{
                self.lbl_mobile.text = "\(signinInfo["countryCode"]?.string ?? "") \(signinInfo["mobile"]?.string ?? "")"
            }
        }
        
        if let recoveryInfo = self.signinInfo["recoveryInfo"]?.dictionary
        {
            if (recoveryInfo["mobile"]?.null) != nil
            {
                self.lbl_recover_email.text = "(Not Set)"
            }else{
                self.lbl_recover_email.text = "\(recoveryInfo["email"]?.string ?? "")"
            }
            
            if (recoveryInfo["mobile"]?.null) != nil
            {
                self.lbl_recover_mobile.text = "(Not Set)"
            }else{
                self.lbl_recover_mobile.text = "\(recoveryInfo["countryCode"]?.string ?? "") \(recoveryInfo["mobile"]?.string ?? "")"
            }
        }
        
        if self.lbl_2fa.text ?? "" == "(Not Set)"
        {
            self.btn_edit_2fa.setImage(self.add_img, for: .normal)
            self.btn_dlt_2fa.isHidden = true
        }else{
            self.btn_edit_2fa.setImage(self.edit_img, for: .normal)
            self.btn_dlt_2fa.isHidden = false
        }
        if self.lbl_mobile.text ?? "" == "(Not Set)"
        {
            self.btn_edit_mobile.setImage(self.add_img, for: .normal)
            self.btn_dlt_mobile.isHidden = true
        }else{
            self.btn_edit_mobile.setImage(self.edit_img, for: .normal)
            self.btn_dlt_mobile.isHidden = false
        }
        
        if self.lbl_recover_email.text ?? "" == "(Not Set)"
        {
            self.btn_edit_recover_email.setImage(self.add_img, for: .normal)
        }else{
            self.btn_edit_recover_email.setImage(self.edit_img, for: .normal)
        }
        
        if self.lbl_recover_mobile.text ?? "" == "(Not Set)"
        {
            self.btn_edit_recover_mobile.setImage(self.add_img, for: .normal)
        }else{
            self.btn_edit_recover_mobile.setImage(self.edit_img, for: .normal)
        }
    }
}
