//
//  AllPopupView.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 15/12/21.
//

import Foundation
import FCAlertView

func showalert(vc:UIViewController,title:String,subTitle:String)
{
    let customAlert = FCAlertView()
    customAlert.colorScheme = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
    customAlert.blurBackground = true
    customAlert.bounceAnimations = true
    customAlert.titleFont = UIFont(name: "SourceSansPro-SemiBold", size: 20)
    customAlert.subtitleFont = UIFont(name: "SourceSansPro-Regular", size: 18)
    customAlert.doneButtonCustomFont = UIFont(name: "SourceSansPro-SemiBold", size: 18)
    customAlert.cornerRadius = CGFloat(12)
    customAlert.doneActionBlock {
        
    }
    
    customAlert.showAlert(inView: vc, withTitle: title, withSubtitle: subTitle, withCustomImage: nil, withDoneButtonTitle: "Okay", andButtons:nil)
}

func showalertYesNo(vc:UIViewController,title:String,subTitle:String,success:@escaping () -> Void, failure:@escaping () -> Void)
{
    let customAlert = FCAlertView()
    customAlert.colorScheme = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
    customAlert.blurBackground = true
    customAlert.bounceAnimations = true
    customAlert.titleFont = UIFont(name: "SourceSansPro-SemiBold", size: 20)
    customAlert.subtitleFont = UIFont(name: "SourceSansPro-Regular", size: 18)
    customAlert.doneButtonCustomFont = UIFont(name: "SourceSansPro-SemiBold", size: 18)
    customAlert.firstButtonCustomFont = UIFont(name: "SourceSansPro-SemiBold", size: 18)
    customAlert.secondButtonCustomFont = UIFont(name: "SourceSansPro-SemiBold", size: 18)
    customAlert.cornerRadius = CGFloat(12)
    customAlert.doneActionBlock {
        customAlert.dismiss()
        success()
    }
    customAlert.addButton("No") {
        customAlert.dismiss()
        failure()
    }
    
    customAlert.showAlert(inView: vc, withTitle: title, withSubtitle: subTitle, withCustomImage: nil, withDoneButtonTitle: "Yes", andButtons:nil)
}
