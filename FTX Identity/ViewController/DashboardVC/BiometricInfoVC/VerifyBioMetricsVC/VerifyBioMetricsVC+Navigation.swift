//
//  VerifyBioMetricsVC+Navigation.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import Foundation
import UIKit

extension VerifyBioMetricsVC
{
    func goingnToIDScan()
    {
        let vc = IDScanVC(nibName: "IDScanVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goingToVideoRecord()
    {
//        let vc = TakeSelfieVC(nibName: "TakeSelfieVC", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
        let vc = AntiSpoofingContainerViewController(nibName: "AntiSpoofingContainerViewController", bundle: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension VerifyBioMetricsVC:MyClassDelegate
{
    func myClassDelegateMethod(_ sender: UIImage) {
        SignUpData.shared.selfieImageFaceMe = sender
    }
    
}
