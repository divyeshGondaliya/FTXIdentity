//
//  PersonalInfoVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import UIKit

class PersonalInfoVC: UIViewController {
    
    @IBOutlet weak var img_profile: UIImageView!
    @IBOutlet weak var lbl_fname: UILabel!
    @IBOutlet weak var lbl_lname: UILabel!
    @IBOutlet weak var lbl_dob: UILabel!
    @IBOutlet weak var lbl_ssn: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_mobile: UILabel!
    @IBOutlet weak var lbl_pwd: UILabel!
    
    var editFor = EditFor.FirstName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserDetails()
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_edit_profile_press(_ sender: Any) {
    }
    @IBAction func btn_firstName_edit(_ sender: Any) {
        self.editFor = .FirstName
        self.openPopupForEdit()
    }
    @IBAction func btn_lastName_edit(_ sender: Any) {
        self.editFor = .LastName
        self.openPopupForEdit()
    }
    
    @IBAction func btn_dlt_bday(_ sender: Any) {
    }
    @IBAction func btn_bday_edit(_ sender: Any) {
    }
    
    @IBAction func btn_ssn_edit(_ sender: Any) {
        self.editFor = .SSN
        self.openPopupForEdit()
    }
    @IBAction func btn_ssn_dlt(_ sender: Any) {
    }
    
    @IBAction func btn_email_edit(_ sender: Any) {
        self.editFor = .Email
        self.openPopupForEdit()
    }
    @IBAction func btn_mobile_edit(_ sender: Any) {
        self.editFor = .Mobile
        self.openPopupForEdit()
    }
    
    @IBAction func btn_pwd_edit(_ sender: Any) {
    }
}

extension PersonalInfoVC
{
    func openPopupForEdit()
    {
        let vc = PersonalnfoChangePopupVC(nibName: "PersonalnfoChangePopupVC", bundle: nil)
        vc.editFor = self.editFor
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}
