//
//  ShareUnshareIdentityVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import UIKit
import SwiftyJSON

class ShareUnshareIdentityVC: MainStuffViewController {

    @IBOutlet weak var tbl_view: UITableView!
    
    @IBOutlet weak var tbl_height: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_subTitle: UILabel!
    
    var retailerData = [String:JSON]()
    var claimTypeArr = [[String:JSON]]()
    var finalArrayToDisplay = [[String:JSON]]()
    var allRequiredInfo = [String]()
    var switchOnid = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getClaimType()
        self.tbl_view.register(UINib(nibName: "ListOfShareOptionCell", bundle: nil), forCellReuseIdentifier: "ListOfShareOptionCell")
        self.tbl_view.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.setupDataToView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tbl_view.removeObserver(self, forKeyPath: "contentSize")
        super.viewWillDisappear(true)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                self.tbl_height.constant = newsize.height
            }
        }
    }
    
    @IBAction func btn_cancel_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_allow_press(_ sender: Any) {
        self.allowAccessToIdentity()
    }
}


extension ShareUnshareIdentityVC
{
    func setupDataToView()
    {
        self.setupTitle()
        self.setupSubTitle()
    }
    
    func setupTitle()
    {
        let mutableAttrString1 = NSMutableAttributedString()
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "SourceSansPro-SemiBold", size: 24.0)!,
                            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1).cgColor] as [NSAttributedString.Key : Any]
        mutableAttrString1.append(NSMutableAttributedString(string: "\(retailerData["companyName"]?.string ?? "")", attributes: myAttribute))
        
        let myAttribute2 = [ NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Regular", size: 24.0)! ,
                             NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1).cgColor] as [NSAttributedString.Key : Any]
        mutableAttrString1.append(NSMutableAttributedString(string: " wants to access your ", attributes: myAttribute2))
        
        let myAttribute3 = [ NSAttributedString.Key.font: UIFont(name: "SourceSansPro-SemiBold", size: 24.0)! ,
                             NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1).cgColor] as [NSAttributedString.Key : Any]
        mutableAttrString1.append(NSMutableAttributedString(string: "FTX Identity", attributes: myAttribute3))
        
        let myAttribute4 = [ NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Regular", size: 24.0)! ,
                             NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1).cgColor] as [NSAttributedString.Key : Any]
        mutableAttrString1.append(NSMutableAttributedString(string: " Account", attributes: myAttribute4))
        
        self.lbl_title.attributedText = mutableAttrString1
    }
    
    func setupSubTitle()
    {
        let mutableAttrString1 = NSMutableAttributedString()
        
        let myAttribute2 = [ NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Regular", size: 17.0)! ,
                             NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor] as [NSAttributedString.Key : Any]
        mutableAttrString1.append(NSMutableAttributedString(string: "Select What ", attributes: myAttribute2))
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "SourceSansPro-SemiBold", size: 17.0)!,
                            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1).cgColor] as [NSAttributedString.Key : Any]
        mutableAttrString1.append(NSMutableAttributedString(string: "\(retailerData["companyName"]?.string ?? "")", attributes: myAttribute))
        
        
        
        let myAttribute3 = [ NSAttributedString.Key.font: UIFont(name: "SourceSansPro-SemiBold", size: 17.0)! ,
                             NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor] as [NSAttributedString.Key : Any]
        mutableAttrString1.append(NSMutableAttributedString(string: " can access", attributes: myAttribute3))
                
        self.lbl_subTitle.attributedText = mutableAttrString1
    }
}
