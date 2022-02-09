//
//  QrCodeDisplayVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import UIKit

protocol QrCodeDisplayDelegate:class {
    func openQrScanner()
}
class QrCodeDisplayVC: MainStuffViewController {

    @IBOutlet weak var img_qr: UIImageView!
    @IBOutlet weak var profile_img: UIImageView!
    
    var imgurlStr = ""
    
    weak var delegate:QrCodeDisplayDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getQrCode()
        
        if let data = UserDefaults.standard.value(forKey: "UserImageToCompare_FTx") as? Data
        {
            if data.count > 0
            {
                if let image = UIImage(data: data)
                {
                    self.profile_img.image = image
                }
            }
        }else{
            if imgurlStr.count == 2
            {
                self.profile_img.image = self.imgurlStr.createImage()
            }else if imgurlStr.count > 0
            {
                self.profile_img.kf.setImage(with: URL(string: imgurlStr))
            }
        }
        

        
        // Do any additional setup after loading the view.
    }
    @IBAction func btn_open_scaner(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.openQrScanner()
        }
    }
    
    @IBAction func btn_close_press(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //api/v1/Profile/Identity/qr
}
