//
//  PersonalnfoChangePopupVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import UIKit

protocol PersonalnfoChangePopupDelegate:class {
    func updateButtonPress(stringValueOfTextField:String)
    func cancelButtonPress(stringValueOfTextField:String)
}

class PersonalnfoChangePopupVC: UIViewController {

    var editFor = EditFor.FirstName
    
    @IBOutlet weak var lbl_top_placeholder: UILabel!
    @IBOutlet weak var txt_fiels: UITextField!
    weak var delegate: PersonalnfoChangePopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiIniti()
        // Do any additional setup after loading the view.
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
        self.dismiss(animated: true) {
            self.delegate?.updateButtonPress(stringValueOfTextField: self.txt_fiels.text ?? "")
        }
    }
    
}

extension PersonalnfoChangePopupVC
{
    func uiIniti()
    {
        self.txt_fiels.setLeftPaddingPoints(16)
        self.txt_fiels.setRightPaddingPoints(16)
        switch self.editFor
        {
            case .FirstName:
                self.txt_fiels.keyboardType = .default
                self.lbl_top_placeholder.text = " First Name "
            case .LastName:
                self.txt_fiels.keyboardType = .default
                self.lbl_top_placeholder.text = " Last Name "
            case .SSN:
                self.txt_fiels.keyboardType = .numberPad
                self.lbl_top_placeholder.text = " SSN "
            case .Email:
                self.txt_fiels.keyboardType = .emailAddress
                self.lbl_top_placeholder.text = " Email "
            case .Mobile:
                self.lbl_top_placeholder.text = " Mobile "
                self.txt_fiels.keyboardType = .numberPad
        }
    }
}
