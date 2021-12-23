//
//  VerifyBioMetricsVC+Annimation.swift
//  FTX Identity
//
//  Created by Darshan on 23/12/21.
//

import Foundation
import UIKit

extension VerifyBioMetricsVC
{
    func showanimationTopBottomAndBottomTop()
    {
        self.img_bioMatrick.image = SignUpData.shared.frontIDImg
        self.line_top.constant = self.line_top.constant == 0 ? self.img_bioMatrick.frame.height:0
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        } completion: { (result) in
            self.loadBackImageAndAnnimate()
        }
    }
    func loadBackImageAndAnnimate()
    {
        self.img_bioMatrick.image = SignUpData.shared.backIDImg
        self.line_top.constant = self.line_top.constant == 0 ? self.img_bioMatrick.frame.height:0
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        } completion: { (result) in
            self.loadSelfieImageAndAnnimate()
        }
    }
    
    func loadSelfieImageAndAnnimate()
    {
        self.img_bioMatrick.image = SignUpData.shared.selfieImage
        self.line_top.constant = self.line_top.constant == 0 ? self.img_bioMatrick.frame.height:0
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        } completion: { (result) in
            if !self.hideanimation
            {
                self.showanimationTopBottomAndBottomTop()
            }
        }
    }
}
