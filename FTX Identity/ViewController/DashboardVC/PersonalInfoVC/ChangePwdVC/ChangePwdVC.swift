//
//  ChangePwdVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 21/12/21.
//

import UIKit
protocol ChangePwdDelegate:class {
    func pwdChange(responce:Bool)
    func cancelPwdChange()
}
class ChangePwdVC: MainStuffViewController {
    
    @IBOutlet weak var txt_current_pwd: UITextField!
    @IBOutlet weak var txt_new_pwd: UITextField!
    @IBOutlet weak var txt_c_pwd: UITextField!
    
    weak var delegate:ChangePwdDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in[txt_current_pwd,txt_new_pwd,txt_c_pwd]
        {
            item?.setLeftPaddingPoints(16)
            item?.setRightPaddingPoints(16)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_cancel_press(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.cancelPwdChange()
        }
    }
    
    @IBAction func btn_update_press(_ sender: Any) {
        if self.txt_new_pwd.text?.count ?? 0 == 0
        {
            return
        }
        
        if self.txt_new_pwd.text?.count ?? 0 == 0
        {
            return
        }
        
        if self.txt_c_pwd.text?.count ?? 0 == 0
        {
            return
        }
        
        if self.txt_new_pwd.text != self.txt_c_pwd.text
        {
            return
        }
        
        self.changePwd()
    }
    @IBAction func btn_bg_press(_ sender: Any) {
        self.view.endEditing(true)
    }
}

extension ChangePwdVC
{
    func changePwd()
    {
        LoadingOverlay.shared.showOverlay(view: self.view)
        var dic = [:] as [String:AnyObject]
        dic["currentPassword"] = (self.txt_current_pwd.text ?? "") as AnyObject
        dic["newPassword"] = (self.txt_new_pwd.text ?? "") as AnyObject
        dic["confirmNewPassword"] = (self.txt_c_pwd.text ?? "") as AnyObject
        
        let apiCallFor = ApiURls.PasswordUpdate
        AFWrapper.sharedInstance.requestPut(apiCallFor, parma: dic) { (jsonResponce) in
            LoadingOverlay.shared.hideOverlayView()
            if let dic = jsonResponce.dictionary
            {
                print(dic)
                let succeeded = dic["succeeded"]?.bool ?? false
                if succeeded
                {
                    self.dismiss(animated: true) {
                        self.delegate?.pwdChange(responce: true)
                    }
                }else{
                    if let message = dic["message"]?.string
                    {
                        CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: message, andAlertType: 3)
                    }else{
                        self.dismiss(animated: true) {
                            self.delegate?.pwdChange(responce: false)
                        }
                    }                    
                }
            }
        } failure: { (error) in
            print(error)
        }
    }
}
