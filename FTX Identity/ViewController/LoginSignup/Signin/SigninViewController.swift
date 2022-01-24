//
//  SigninViewController.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 14/12/21.
//

import UIKit
import WebKit
import AppAuth

class SigninViewController: MainStuffViewController, WKNavigationDelegate {
    
    @IBOutlet weak var txt_email_mobile_number: UITextField!
    @IBOutlet weak var txt_pwd: UITextField!
    @IBOutlet weak var webview: WKWebView!
    var webViewObserver: NSKeyValueObservation?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        webViewObserver?.invalidate()
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_frgt_pwd(_ sender: Any) {
    }
    
    @IBAction func btn_sign_in_press(_ sender: Any) {
    }
    
    @IBAction func btn_sign_up_press(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {        
    }
    
    @IBAction func freshToken_press(_ sender: Any) {
    }
    @IBAction func authNoCodeExchange(_ sender: UIButton) {
        
        
    }
    
    
}
extension SigninViewController {
    
    
    
}







