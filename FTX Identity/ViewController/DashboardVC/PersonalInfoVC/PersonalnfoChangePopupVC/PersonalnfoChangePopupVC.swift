//
//  PersonalnfoChangePopupVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import UIKit
import DatePickerDialog
import OTPFieldView

protocol PersonalnfoChangePopupDelegate:class {
    func updateButtonPress(stringValueOfTextField:String)
    func cancelButtonPress(stringValueOfTextField:String)
}
enum SelectionFor {
    case TXT
    case CTXT
}
class PersonalnfoChangePopupVC: UIViewController {
    
    var strOTP : String = ""
    
    @IBOutlet weak var lbl_top_placeholder: UILabel!
    @IBOutlet weak var lbl_confirm_top_placeholder: UILabel!
    
    @IBOutlet weak var txt_fiels: UITextField!
    @IBOutlet weak var txt_confirm: UITextField!
    
    @IBOutlet weak var txt_top_confirm_16: NSLayoutConstraint!
    @IBOutlet weak var txt_confirm_height_44: NSLayoutConstraint!
        
    @IBOutlet weak var btn_date_selection: UIButton!
    @IBOutlet weak var btn_date_selection_confirm: UIButton!
    
    @IBOutlet weak var txt_otp: OTPFieldView!
    @IBOutlet weak var otp_view: UIView!
    @IBOutlet weak var lbl_email_otp_send: UILabel!
    
    var selectionFor = SelectionFor.TXT
    weak var delegate: PersonalnfoChangePopupDelegate?
    var preFillString = ""
    var confirmRequired = false
    var editFor = EditFor.FirstName
    var userCurrentEmail = ""
    var isRecoverEmail = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.otp_view.isHidden = true
        self.uiIniti()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_cancel_email_press(_ sender: Any) {
        self.delegate?.cancelButtonPress(stringValueOfTextField: "")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn_update_email_press(_ sender: Any) {
        if self.strOTP.count == 6
        {
            self.verifyOtp()
        }else{
            CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Please enter valid otp.", andAlertType: 3)
        }
    }
    @IBAction func btn_change_email(_ sender: Any) {
        self.otp_view.isHidden = true
    }
    @IBAction func dateSelectionForTextField(_ sender:Any)
    {
        self.selectionFor = .TXT
        self.openPickerView()
    }
    
    func openPickerView()
    {
        let vc = OnlyDateAndMonthPickerVC(nibName: "OnlyDateAndMonthPickerVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        switch self.selectionFor
        {
            case .TXT:
                vc.selected_Day_month = self.txt_fiels.text ?? ""
            case .CTXT:
                vc.selected_Day_month = self.txt_confirm.text ?? ""
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func dateSelectionForConfirmTextField(_ sender:Any)
    {
        self.selectionFor = .CTXT
        self.openPickerView()
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func btn_cancel_press(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.cancelButtonPress(stringValueOfTextField: self.txt_fiels.text ?? "")
        }
    }
    @IBAction func btn_update_press(_ sender: Any) {
        let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
        let filtered = (self.txt_fiels.text ?? "").components(separatedBy: cs).joined(separator: "")
        let testCase = filtered == self.txt_fiels.text ?? ""
        switch self.editFor
        {
        case .FirstName:
            if testCase
            {
                self.dismiss(animated: true) {
                    self.delegate?.updateButtonPress(stringValueOfTextField: self.txt_fiels.text ?? "")
                }
            }else{
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Please enter valid first name.", andAlertType: 3)
            }
        case .LastName:
            if testCase
            {
                self.dismiss(animated: true) {
                    self.delegate?.updateButtonPress(stringValueOfTextField: self.txt_fiels.text ?? "")
                }
            }else{
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Please enter valid last name.", andAlertType: 3)
            }
        case .SSN:
            if self.txt_fiels.text?.count != 4
            {
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Please enter SSN number.", andAlertType: 3)
                return
            }
            if self.txt_confirm.text ?? "" != self.txt_fiels.text ?? "" && self.confirmRequired
            {
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "New SSN and Confirm SSN should be same.", andAlertType: 3)
                return
            }
            let ACCEPTABLE_CHARACTERS = "0123456789"
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered = (self.txt_fiels.text ?? "").components(separatedBy: cs).joined(separator: "")
            let testCase = filtered == self.txt_fiels.text ?? ""
            if testCase
            {
                self.dismiss(animated: true) {
                    self.delegate?.updateButtonPress(stringValueOfTextField: self.txt_fiels.text ?? "")
                }
            }else{
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Please enter Valid SSN number.", andAlertType: 3)
            }
        case .Email:
            print("email")
            if (self.txt_fiels.text ?? "").isValidEmail()
            {
                if self.txt_fiels.text ?? "" != self.userCurrentEmail
                {
                    self.getOtpForEmail()
                }else{
                    CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "New email can not be same as the old one.", andAlertType: 3)
                }
            }else{
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Please enter valid email.", andAlertType: 3)
            }
        case .Mobile:
            print("mobile")
        case .DateOfBirth:
            print("DoB")
            if self.txt_fiels.text?.count == 0
            {
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "Please select date of birth.", andAlertType: 3)
                return
            }
            if self.txt_confirm.text ?? "" != self.txt_fiels.text ?? "" && self.confirmRequired
            {
                CustomAlertView.display(activeViewController:self,withTitle: nil, andMessage: "New Date of Birth and Confirm Date of Birth should be same.", andAlertType: 3)
                return
            }
            self.dismiss(animated: true) {
                self.delegate?.updateButtonPress(stringValueOfTextField: self.txt_fiels.text ?? "")
            }
        }
        
    }
}

