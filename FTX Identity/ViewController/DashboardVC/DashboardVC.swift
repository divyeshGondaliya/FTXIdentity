//
//  DashboardVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 14/12/21.
//

import UIKit
import Kingfisher
class DashboardVC: MainStuffViewController {

    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var lbl_greeting: UILabel!
    @IBOutlet weak var profile_img: UIImageView!
    
    let arr_img = [UIImage(named: "personal-info-icon"),UIImage(named: "biometric-info-icon"),UIImage(named: "sign-in-security-icon"),UIImage(named: "icon-membership"),UIImage(named: "icon-search"),UIImage(named: "Icon metro-settings-power")]
    let arr_title = ["Personal Info","Biometric Info","Sign-in Security","Membership","Search Retailer","Logout"]
    var profileimg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection_view.register(UINib(nibName: "DashboardOptionCell", bundle: nil), forCellWithReuseIdentifier: "DashboardOptionCell")
        // Do any additional setup after loading the view.
        
    }
    @IBAction func btn_profile_qr_press(_ sender: Any) {
//        let vc = QrCodeDisplayVC(nibName: "QrCodeDisplayVC", bundle: nil)
//        vc.imgurlStr = self.profileimg
//        vc.delegate = self
//        self.present(vc, animated: true, completion: nil)
        self.openQrCodeDisplay()
    }
    
    @IBAction func btn_bottom_scan_press(_ sender: Any) {
//        let vc = QrCodeScannerVC(nibName: "QrCodeScannerVC", bundle: nil)
//        vc.delegate = self
//        self.navigationController?.present(vc, animated: true, completion: nil)
        self.openQrScanner()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getUserDetails()
    }
}

extension DashboardVC:QrCodeScannerDelegate,QrCodeDisplayDelegate
{
    func openQrScanner() {
        DispatchQueue.main.async {
            let vc = QrCodeScannerVC(nibName: "QrCodeScannerVC", bundle: nil)
            vc.delegate = self
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    func openQrCodeDisplay() {
        DispatchQueue.main.async {
            let vc = QrCodeDisplayVC(nibName: "QrCodeDisplayVC", bundle: nil)
            vc.imgurlStr = self.profileimg
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension DashboardVC
{
    func getUserDetails()
    {
        AFWrapper.sharedInstance.requestGETURL(ApiURls.userDetails) { (jsonResponse) in
            if let dic = jsonResponse.dictionary
            {
                if let data = dic["data"]?.dictionary
                {
                    print(data)
                    let mutableAttrString1 = NSMutableAttributedString()
                    
                    let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "SourceSansPro-SemiBold", size: 24.0)!,
                                        NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor] as [NSAttributedString.Key : Any]
                    mutableAttrString1.append(NSMutableAttributedString(string: "Welcome, ", attributes: myAttribute))
                    
                    let myAttribute2 = [ NSAttributedString.Key.font: UIFont(name: "SourceSansPro-SemiBold", size: 24.0)! ,
                                         NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1).cgColor] as [NSAttributedString.Key : Any]
                    mutableAttrString1.append(NSMutableAttributedString(string: "\(data["firstName"]?.string ?? "") \(data["lastName"]?.string ?? "")", attributes: myAttribute2))
                    
                    self.lbl_greeting.attributedText = mutableAttrString1
                    self.profileimg = data["profileImageUrl"]?.string ?? ""
                    if self.profileimg.count > 0
                    {
                        self.profile_img.kf.setImage(with: URL(string: data["profileImageUrl"]?.string ?? ""))
                    }else{
                        self.profile_img.image = "\(data["firstName"]?.string ?? "") \(data["lastName"]?.string ?? "")".getFirstLetterOfTwoString().createImage()
                        self.profileimg = "\(data["firstName"]?.string ?? "") \(data["lastName"]?.string ?? "")".getFirstLetterOfTwoString()
                    }
                }
            }else{
                
            }
        } failure: { (error) in
            print(error)
        }

    }
}
