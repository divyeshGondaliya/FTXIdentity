//
//  ChooseOprtionVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 14/12/21.
//

import UIKit
import AppAuth
import AVFoundation

class ChooseOprtionVC: MainStuffViewController {

    @IBOutlet weak var page_indicator_1: UIView!
    @IBOutlet weak var page_indicator_2: UIView!
    @IBOutlet weak var page_indicator_3: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var currentPage = 0
    
    let titleArr = ["Help Guard Your Identity.","True Identity Protection.","You'r in Control"]
    let descriptionArr = ["FTxIdentity is all about helping to protect the personal information. Keep your documents locked up in a safe at home.",
                          "Manage your Identity by accessing your membership in a central location, whether they’re in the cloud or on-premises.",
                          "AI based identification by matching facial profile."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: "UserImageToCompare_FTx")
        UserDefaults.standard.synchronize()
//        LoadingOverlay.shared.showOverlay(view: self.view)
        self.collectionView.reloadData()
        self.updatePagging(selectedPage: self.currentPage)
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @IBAction func create_ac_press(_ sender: Any) {
        AVCaptureDevice.requestAccess(for: .video) { success in
            if success { 
                DispatchQueue.main.async {
                    SignUpData.shared.initdata()
                    self.getGuestToken()
                }
            } else {
                let alert = UIAlertController(title: "Camera", message: "Camera access is absolutely necessary to use this app.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @IBAction func btn_already_member_press(_ sender: Any) {
        AuthLoginClass.shared.performAuthAndLogin(vc: self) { (result) in
            if result && AuthLoginClass.shared.FreshToken.count > 0
            {
                let vc = DashboardVC(nibName: "DashboardVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                print("something went wrong please try again")
            }
        }
    }
    
}



extension ChooseOprtionVC
{
    func updatePagging(selectedPage:Int)
    {
        self.page_indicator_1.layer.borderWidth = 0
        self.page_indicator_2.layer.borderWidth = 0
        self.page_indicator_3.layer.borderWidth = 0
        self.page_indicator_1.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.page_indicator_2.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.page_indicator_3.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.page_indicator_1.backgroundColor = .white
        self.page_indicator_2.backgroundColor = .white
        self.page_indicator_3.backgroundColor = .white
        
        switch selectedPage {
        case 0:
            self.page_indicator_1.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
            self.page_indicator_2.layer.borderWidth = 1
            self.page_indicator_3.layer.borderWidth = 1
        case 1:
            self.page_indicator_2.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
            self.page_indicator_1.layer.borderWidth = 1
            self.page_indicator_3.layer.borderWidth = 1
        case 2:
            self.page_indicator_3.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
            self.page_indicator_1.layer.borderWidth = 1
            self.page_indicator_2.layer.borderWidth = 1
        default:
            print("nothing")
        }
    }
}

//extension ChooseOprtionVC:UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//}
