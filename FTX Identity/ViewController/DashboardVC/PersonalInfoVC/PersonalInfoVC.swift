//
//  PersonalInfoVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import UIKit
import SwiftyJSON
class PersonalInfoVC: UIViewController {
    
    @IBOutlet weak var img_profile: UIImageView!
    
    @IBOutlet weak var lbl_fname: UILabel!
    @IBOutlet weak var lbl_lname: UILabel!
    @IBOutlet weak var lbl_dob: UILabel!
    @IBOutlet weak var lbl_ssn: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_mobile: UILabel!
    @IBOutlet weak var lbl_pwd: UILabel!
    
    @IBOutlet weak var btn_edit_dob: UIButton!
    @IBOutlet weak var btn_edit_ssn: UIButton!
    @IBOutlet weak var btn_edit_email: UIButton!
    @IBOutlet weak var btn_edit_mobile: UIButton!
    @IBOutlet weak var btn_delete_profile_pic: UIButton!
    
    @IBOutlet weak var btn_dlt_dob: UIButton!
    @IBOutlet weak var btn_dlt_ssn: UIButton!
    @IBOutlet weak var btn_dlt_mobile: UIButton!
    @IBOutlet weak var btn_edit_profile_pic: UIButton!
    
    var editFor = EditFor.FirstName
    var userData = [String:JSON]()
    
    let add_img = UIImage(named: "add")
    let edit_img = UIImage(named: "edit")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_delete_profile_pic.isHidden = true
        self.getUserDetails()
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_edit_profile_press(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
        self.editFor = .DateOfBirth
        self.updateUserInfo(txtToUpdate: "")
    }
    @IBAction func btn_bday_edit(_ sender: Any) {
        self.editFor = .DateOfBirth
        self.openPopupForEdit()
    }
    
    @IBAction func btn_ssn_edit(_ sender: Any) {
        self.editFor = .SSN
        self.openPopupForEdit()
    }
    @IBAction func btn_ssn_dlt(_ sender: Any) {
        self.editFor = .SSN
        self.updateUserInfo(txtToUpdate: "")
    }
    
    @IBAction func btn_email_edit(_ sender: Any) {
        self.editFor = .Email
        self.openPopupForEdit()
    }
    @IBAction func btn_dlt_mobile(_ sender: Any) {
        showalertYesNo(vc: self, title: AlertString.title, subTitle: StringMsgToDisplay.DLTMobileNumber) {
            self.dltMobileNumber()
        } failure: {
        }
        
    }
    @IBAction func btn_mobile_edit(_ sender: Any) {
//        self.editFor = .Mobile
//        self.openPopupForEdit()
        self.editFor = .Mobile
        let vc = MobileNumberVC(nibName: "MobileNumberVC", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btn_delete_profile_pic_press(_ sender: Any) {
        self.deleteProfilePic()
    }
    
    @IBAction func btn_pwd_edit(_ sender: Any) {
        let vc = ChangePwdVC(nibName: "ChangePwdVC", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}

extension PersonalInfoVC
{
    func openPopupForEdit()
    {
        let vc = PersonalnfoChangePopupVC(nibName: "PersonalnfoChangePopupVC", bundle: nil)
        vc.userCurrentEmail = self.lbl_email.text ?? ""
        vc.editFor = self.editFor
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        switch self.editFor
        {
            case .FirstName:
                vc.preFillString = self.lbl_fname.text ?? ""
            case .LastName:
                vc.preFillString = self.lbl_lname.text ?? ""
            case .SSN:
                vc.preFillString = ""
                vc.confirmRequired = true
            case .Email:
                vc.preFillString = ""
            case .Mobile:
                vc.preFillString = ""
            case .DateOfBirth:
                vc.preFillString = self.lbl_dob.text ?? "" == "(Not Set)" ? "":self.lbl_dob.text ?? ""
                vc.confirmRequired = true
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupDataToView()
    {
        self.btn_delete_profile_pic.isHidden = true
        self.btn_edit_profile_pic.setImage(UIImage(named: "editprofilepic"), for: .normal)
        print(self.userData)
        if let basicInfo = self.userData["basicInfo"]?.dictionary
        {
            self.img_profile.image = "\(basicInfo["firstName"]?.string ?? "") \(basicInfo["lastName"]?.string ?? "")".getFirstLetterOfTwoString().createImage()
            if let profileImageUrl = basicInfo["profileImageUrl"]?.string
            {
                if let url = URL(string: profileImageUrl)
                {
                    self.img_profile.kf.setImage(with: url)
                    self.btn_delete_profile_pic.isHidden = false
                    self.btn_edit_profile_pic.setImage(UIImage(named: "edit-input-icon"), for: .normal)
                }
            }
            self.lbl_fname.text = basicInfo["firstName"]?.string
            self.lbl_lname.text = basicInfo["lastName"]?.string
            if (basicInfo["ssn"]?.null) != nil || basicInfo["ssn"]?.string == ""
            {
                self.lbl_ssn.text = "(Not Set)"
            }else{
                self.lbl_ssn.text = basicInfo["ssn"]?.string?.count ?? 0 > 0 ? "****":""
            }
            
            if (basicInfo["dob"]?.null) != nil || basicInfo["dob"]?.string == ""
            {
                self.lbl_dob.text = "(Not Set)"
            }else{
                self.lbl_dob.text = basicInfo["dob"]?.string
            }
            
        }
        
        if let contactInfo = self.userData["contactInfo"]?.dictionary
        {
            self.lbl_email.text = contactInfo["email"]?.string
            if (contactInfo["mobile"]?.null) != nil
            {
                self.lbl_mobile.text = "(Not Set)"
            }else{
                self.lbl_mobile.text = "\(contactInfo["countryCode"]?.string ?? "") \(contactInfo["mobile"]?.string ?? "")"
            }
            
        }
        
        if self.lbl_dob.text ?? "" == "(Not Set)"
        {
            self.btn_edit_dob.setImage(self.add_img, for: .normal)
            self.btn_dlt_dob.isHidden = true
        }else{
            self.btn_edit_dob.setImage(self.edit_img, for: .normal)
            self.btn_dlt_dob.isHidden = false
        }
        
        if self.lbl_ssn.text ?? "" == "(Not Set)"
        {
            self.btn_edit_ssn.setImage(self.add_img, for: .normal)
            self.btn_dlt_ssn.isHidden = true
            self.btn_dlt_dob.isHidden = true
        }else{
            self.btn_edit_ssn.setImage(self.edit_img, for: .normal)
            self.btn_dlt_ssn.isHidden = false
            if self.lbl_dob.text ?? "" != "(Not Set)"
            {
                self.btn_dlt_dob.isHidden = false
            }else{
                self.btn_dlt_ssn.isHidden = true
            }
        }
        
        if self.lbl_mobile.text ?? "" == "(Not Set)"
        {
            self.btn_edit_mobile.setImage(self.add_img, for: .normal)
            self.btn_dlt_mobile.isHidden = true
        }else{
            self.btn_edit_mobile.setImage(self.edit_img, for: .normal)
            self.btn_dlt_mobile.isHidden = false
        }
    }
}
