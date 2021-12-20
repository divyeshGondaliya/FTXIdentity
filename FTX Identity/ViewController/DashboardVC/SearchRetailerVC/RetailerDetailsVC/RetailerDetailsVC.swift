//
//  RetailerDetailsVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import UIKit
import SwiftyJSON

class RetailerDetailsVC: UIViewController {

    @IBOutlet weak var retailer_profile_img: UIImageView!
    @IBOutlet weak var img_share_unshare_identity: UIImageView!
    
    @IBOutlet weak var retailer_no_profile_view: UIView!
    @IBOutlet weak var view_share_identity: UIView!
    @IBOutlet weak var view_email: UIView!
    @IBOutlet weak var view_phone: UIView!
    @IBOutlet weak var view_website: UIView!
    
    @IBOutlet weak var retailer_no_profile_lbl: UILabel!
    @IBOutlet weak var lbl_companyName: UILabel!
    @IBOutlet weak var lbl_applicationName: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var img_logoUrl: UIImageView!
    @IBOutlet weak var lbl_share_my_identity: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_website: UILabel!
    
    var retailerData = [String:JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.configureDataToView()
    }
    @IBAction func btn_email_press(_ sender: Any) {
        self.sendMailTo(mailTo: self.lbl_email.text ?? "")
    }
    @IBAction func btn_phone_press(_ sender: Any) {
        self.make_A_Call(callTo: "\(retailerData["countryCode"]?.string ?? "") \(retailerData["contactNumber"]?.string ?? "")")
    }
    @IBAction func btn_webstite_press(_ sender: Any) {
        self.openUrl(urlStr: self.lbl_website.text ?? "")
    }
    @IBAction func btn_share_my_identity(_ sender: Any) {
        if retailerData["identityShared"]?.bool ?? false
        {
            showalertYesNo(vc: self, title: "FTX Identity", subTitle: "Are you sure you want to unshare identity to \(retailerData["companyName"]?.string ?? "")-\(retailerData["applicationName"]?.string ?? "")") {
                self.unShareIdentity(accountApplicationId: self.retailerData["accountApplicationId"]?.string ?? "")
            } failure: {
            }
        }else{
            let vc = ShareUnshareIdentityVC(nibName: "ShareUnshareIdentityVC", bundle: nil)
            vc.retailerData = self.retailerData
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
   
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension RetailerDetailsVC
{
    func configureDataToView()
    {
        let logoUrl = retailerData["logoUrl"]?.string ?? ""
        if logoUrl.count > 0
        {
            self.retailer_no_profile_view.isHidden = true
            if let url = URL(string: logoUrl)
            {
                self.retailer_profile_img.kf.setImage(with: url)
            }
        }else{
            self.retailer_no_profile_view.isHidden = false
            self.retailer_no_profile_lbl.text = retailerData["companyName"]?.string?.getFirstLetterOfTwoString().uppercased()
        }
        self.lbl_companyName.text = retailerData["companyName"]?.string
        self.lbl_applicationName.text = retailerData["applicationName"]?.string
        self.lbl_description.text = retailerData["description"]?.string
        
        self.img_share_unshare_identity.tintColor = .white
        self.img_share_unshare_identity.image = retailerData["identityShared"]?.bool ?? false ? UIImage(named: "unshare"):UIImage(named: "shareIdentity")
        self.view_share_identity.backgroundColor = retailerData["identityShared"]?.bool ?? false ? #colorLiteral(red: 1, green: 0.5176470588, blue: 0.5019607843, alpha: 1):#colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
        self.lbl_share_my_identity.text = retailerData["identityShared"]?.bool ?? false ? "UNSHARE":"SHARE MY IDENTITY"
        
        if retailerData["contactEmail"]?.string?.count ?? 0 > 0
        {
            self.view_email.isHidden = false
            self.lbl_email.text = retailerData["contactEmail"]?.string
        }else{
            self.view_email.isHidden = true
        }
        
        if retailerData["contactNumber"]?.string?.count ?? 0 > 0
        {
            self.view_phone.isHidden = false
            self.lbl_phone.text = "\(retailerData["countryCode"]?.string ?? "") \(retailerData["contactNumber"]?.string ?? "")"
        }else{
            self.view_phone.isHidden = true
        }
        
        if retailerData["url"]?.string?.count ?? 0 > 0
        {
            self.view_website.isHidden = false
            self.lbl_website.text = retailerData["url"]?.string
        }else{
            self.view_website.isHidden = true
        }
    }
}
