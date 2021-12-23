//
//  QrCodeDisplayVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import UIKit

class QrCodeDisplayVC: UIViewController {

    @IBOutlet weak var img_qr: UIImageView!
    @IBOutlet weak var profile_img: UIImageView!
    
    var imgurlStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getQrCode()
        if imgurlStr.count > 0
        {
            self.profile_img.kf.setImage(with: URL(string: imgurlStr))
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btn_open_scaner(_ sender: Any) {
    }
    
    @IBAction func btn_close_press(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //api/v1/Profile/Identity/qr
}
