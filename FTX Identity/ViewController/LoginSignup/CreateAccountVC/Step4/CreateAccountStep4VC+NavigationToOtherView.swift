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
        let vc = TakeSelfieVC(nibName: "TakeSelfieVC", bundle: nil)
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
