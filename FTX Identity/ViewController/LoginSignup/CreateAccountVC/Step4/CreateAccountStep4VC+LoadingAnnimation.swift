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
        self.line_top.constant = self.img_bioMatrick.frame.height
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        } completion: { (result) in
            self.img_bioMatrick.image = SignUpData.shared.backIDImg
            self.line_top.constant = 0
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
}
