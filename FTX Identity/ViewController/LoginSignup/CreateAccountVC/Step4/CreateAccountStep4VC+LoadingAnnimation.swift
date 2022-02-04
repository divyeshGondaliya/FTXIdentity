//
//  CreateAccountStep4VC+LoadingAnnimation.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import Foundation
import UIKit

extension CreateAccountStep4VC
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
//            if !self.hideanimation
//            {
//                self.showanimationTopBottomAndBottomTop()
//            }
        }
    }
    
    func loadSelfieImageAndAnnimate()
    {
        self.img_bioMatrick.image = SignUpData.shared.selfieImageFaceMe
        self.line_top.constant = self.line_top.constant == 0 ? self.img_bioMatrick.frame.height:0
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        } completion: { (result) in
//            self.loadSelfieImage2AndAnnimate()
            if !self.hideanimation
            {
                self.showanimationTopBottomAndBottomTop()
            }
        }
    }
//    
//    func loadSelfieImage2AndAnnimate()
//    {
//        self.img_bioMatrick.image = SignUpData.shared.selfieImage_2
//        self.line_top.constant = self.line_top.constant == 0 ? self.img_bioMatrick.frame.height:0
//        UIView.animate(withDuration: 0.6) {
//            self.view.layoutIfNeeded()
//        } completion: { (result) in
//            if !self.hideanimation
//            {
//                self.showanimationTopBottomAndBottomTop()
//            }
//        }
//    }
}
