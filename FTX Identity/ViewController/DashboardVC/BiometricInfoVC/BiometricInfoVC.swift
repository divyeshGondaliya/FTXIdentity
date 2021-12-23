//
//  BiometricInfoVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import UIKit
import AVFoundation

class BiometricInfoVC: UIViewController {
    
    @IBOutlet weak var top_lbl_txt: UILabel!
    @IBOutlet weak var tbl_view: UITableView!
    @IBOutlet weak var btn_verify_again: UIButton!
    
    var idFrontImageUrl = ""
    var idBackImageUrl = ""
    var selfImageUrl = ""
    
    var img_arr = [UIImage(named: "front-id-icon"),UIImage(named: "back-id-card-icon"),UIImage(named: "selfie-media-icon")]
    var title_arr = ["Front ID Card","Back ID Card","Selfie Record"]
    var img_url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl_view.register(UINib(nibName: "BiometricInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "BiometricInfoTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getBioMetricData()
    }
    
    @IBAction func btn_verifyAgain_press(_ sender: Any) {
        AVCaptureDevice.requestAccess(for: .video) { success in
            if success {
                DispatchQueue.main.async {
                    SignUpData.shared.initdata()
                    let vc = VerifyBioMetricsVC(nibName: "VerifyBioMetricsVC", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
