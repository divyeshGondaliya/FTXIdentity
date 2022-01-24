//
//  MobileNumberVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 24/12/21.
//

import UIKit
import OTPFieldView
import iOSDropDown

class MobileNumberVC: MainStuffViewController {

    var strOTP : String = ""
    
    @IBOutlet weak var txt_mobile_number: UITextField!
    @IBOutlet weak var txt_country_code: DropDown!
    @IBOutlet weak var lbl_resend_txt: UILabel!
    @IBOutlet weak var btn_resend: UIButton!
    
    @IBOutlet weak var txt_otp: OTPFieldView!
    @IBOutlet weak var otp_view: UIView!
    @IBOutlet weak var lbl_mobile_otp_send: UILabel!
    //A text with a One Time Password (OTP) has been sent to your Phone Number: +91 8469667550
    weak var delegate: PersonalnfoChangePopupDelegate?
    
    var forAlternate = false
    var timer: Timer?
    var totalTime = StaticValues.OtpSendInTimer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        // Do any additional setup after loading the view.
    }
    @IBAction func btn_coutry_code_press(_ sender: Any) {
        self.txt_country_code.showList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stopOtpTimer()
    }
    
    @IBAction func btn_cancel_press(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func btn_resend_press(_ sender: Any) {
        print("resend?")
        self.getOtpForMobile()
    }
    
    @IBAction func btn_update_press(_ sender: Any) {
        if self.txt_country_code.text?.count ?? 0 == 0
        {
            CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: StringMsgToDisplay.selectCountryCode, andAlertType: 3)
            return
        }
        if self.txt_mobile_number.text?.count ?? 0 != 10
        {
            CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: StringMsgToDisplay.mobileNotValid, andAlertType: 3)
            return
        }
        
        self.getOtpForMobile()
    }
    
    @IBAction func btn_update_otp_press(_ sender: Any) {
        if self.strOTP.count == 6
        {
            self.verifyOtp()
        }else{
            CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Please enter valid otp.", andAlertType: 3)
        }
    }
    @IBAction func btn_update_cancel_press(_ sender: Any) {
        stopOtpTimer()
        self.otp_view.isHidden = true
    }
    @IBAction func btn_change_mobile_press(_ sender: Any) {
        self.stopOtpTimer()
        self.otp_view.isHidden = true
    }
    
    
}

extension MobileNumberVC
{
    
    func setupOtpView()
    {
        self.txt_otp.isUserInteractionEnabled = true
        self.txt_otp.fieldsCount = 6
        self.txt_otp.fieldBorderWidth = 1
        self.txt_otp.defaultBorderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.txt_otp.filledBorderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.txt_otp.cursorColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.txt_otp.displayType = .roundedCorner
        self.txt_otp.fieldSize = 40
        self.txt_otp.separatorSpace = 8
        self.txt_otp.shouldAllowIntermediateEditing = false
        self.txt_otp.delegate = self
        self.txt_otp.initializeUI()
        self.startOtpTimer()
    }
    
    func initData()
    {
        self.view.bringSubviewToFront(self.otp_view)
        self.otp_view.isHidden = true
        self.txt_mobile_number.setLeftPaddingPoints(16)
        self.txt_mobile_number.setRightPaddingPoints(16)
        
        txt_country_code.rowHeight = 50
        txt_country_code.placeholder = "Select"
        txt_country_code.textAlignment = .center
        txt_country_code.optionArray = StaticArray.countryCode
        txt_country_code.optionIds = [0,1]
        txt_country_code.optionImageArray = StaticArray.countryName
        txt_country_code.didSelect{(selectedText , index ,id) in
            self.txt_country_code.text = selectedText
        }
    }
    
    func startOtpTimer() {
        self.totalTime = StaticValues.OtpSendInTimer
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        self.btn_resend.isEnabled = false
    }
    func stopOtpTimer(){
        if let timer = self.timer {
            self.btn_resend.isEnabled = true
            timer.invalidate()
            self.timer = nil
            self.lbl_resend_txt.text = "Resend code"
        }
    }
    
    @objc func updateTimer() {
        self.lbl_resend_txt.text = "Resend your code in \(self.totalTime)"
        if totalTime != 0 {
            self.btn_resend.isEnabled = false
            totalTime -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                self.btn_resend.isEnabled = true
                timer.invalidate()
                self.timer = nil
                self.lbl_resend_txt.text = "Resend code"
            }
        }
    }
}
