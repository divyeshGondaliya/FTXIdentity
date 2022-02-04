//
//  CreateAccountStep4VC+NavigationToOtherView.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import Foundation
import UIKit

extension CreateAccountStep4VC
{
    func goingnToIDScan()
    {
        let vc = IDScanVC(nibName: "IDScanVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goingToVideoRecord()
    {
//        let vc = VideoRecordingVC(nibName: "VideoRecordingVC", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
//        let vc = TakeSelfieVC(nibName: "TakeSelfieVC", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
//        let vc = CaptureViewController(nibName: "CaptureViewController", bundle: nil)
//        let navi = UINavigationController(rootViewController: vc)
//        navi.modalPresentationStyle = .fullScreen
//        navi.navigationBar.isHidden = true
//        vc.callback = self
//        vc.configuration = CaptureConfiguration.init(forVerification: true, withTraits: "Face")
//
//        self.present(navi, animated: true, completion: nil)
        let vc = AntiSpoofingContainerViewController(nibName: "AntiSpoofingContainerViewController", bundle: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goingToStep5()
    {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateAccountStep5VC") as? CreateAccountStep5VC
        {
            self.navigationController?.pushViewController(vc, animated: true)
        }        
    }
}

extension CreateAccountStep4VC:MyClassDelegate
{
    func myClassDelegateMethod(_ sender: UIImage) {
        SignUpData.shared.selfieImageFaceMe = sender
    }
    
    
}

//extension CreateAccountStep4VC:CaptureDelegate
//{
//    func biometricTaskFinished(_ data: CaptureConfiguration!, withSuccess success: [Any]!) {
//        if let arr_img = success as? [UIImage]
//        {
//            if arr_img.count == 2
//            {
//                SignUpData.shared.selfieImage_1 = arr_img[0]
//                SignUpData.shared.selfieImage_2 = arr_img[1]
//            }
//        }
//    }
//
//
//}
