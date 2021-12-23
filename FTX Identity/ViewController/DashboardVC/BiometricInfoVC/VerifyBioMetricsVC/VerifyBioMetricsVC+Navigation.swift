//
//  VerifyBioMetricsVC+Navigation.swift
//  FTX Identity
//
//  Created by Darshan on 23/12/21.
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
        let vc = TakeSelfieVC(nibName: "TakeSelfieVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
