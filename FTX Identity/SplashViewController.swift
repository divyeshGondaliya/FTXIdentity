//
//  ViewController.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 13/12/21.
//

import UIKit

class SplashViewController: MainStuffViewController {

    @IBOutlet weak var img_1: UIImageView!
    @IBOutlet weak var img_2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func viewWillAppear(_ animated: Bool) {
        UINavigationBar.appearance().backgroundColor = .white
        UIBarButtonItem.appearance().tintColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)

        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
        UINavigationBar.appearance().isTranslucent = false
        
        
        AuthLoginClass.shared.validateOAuthConfiguration()
        AuthLoginClass.shared.loadState()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.desideWherToGo()
        }
    }
    
    func desideWherToGo()
    {
        if AuthLoginClass.shared.authState != nil
        {
            AuthLoginClass.shared.gettingFreshToken { (result) in
                if result && AuthLoginClass.shared.FreshToken.count > 0
                {
                    let vc = DashboardVC(nibName: "DashboardVC", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.goingToChooseOptionVC()
                }
            }
        }else{
            self.goingToChooseOptionVC()            
        }
    }
    
    func goingToChooseOptionVC(){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChooseOprtionVC") as? ChooseOprtionVC
        {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SplashViewController:CaptureDelegate
{
    func biometricTaskFinished(_ data: CaptureConfiguration!, withSuccess success: [Any]!) {
        print(success)
        if success.count == 2
        {
            if let img_arr = success as? [UIImage]
            {
                self.img_1.image = img_arr[0]
                self.img_2.image = img_arr[1]
            }
        }
    }
    
    
//    func biometricTaskFinished(_ data: CaptureConfiguration!, withSuccess success: Bool) {
//        var biometricResult = ""
//        if (success) {
//            biometricResult = "Successful "
//        }
//        else {
//            biometricResult = "Failed "
//        }
//
//        if (data.performEnrollment) {
//            biometricResult = "\(biometricResult) Enrollment"
//        }
//        else {
//            biometricResult = "\(biometricResult) Verification"
//        }
//        print(biometricResult)
//    }
    
    
}
