//
//  RetailerDetailsVC+HelperFunction.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 20/12/21.
//

import Foundation
import MessageUI

extension RetailerDetailsVC:MFMailComposeViewControllerDelegate
{
    func sendMailTo(mailTo:String)
    {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([mailTo])
            present(mail, animated: true)
        } else {
            print("Application is not able to send an email")
        }
    }
    
    //MARK: MFMail Compose ViewController Delegate method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension RetailerDetailsVC
{
    func make_A_Call(callTo:String)
    {
        guard let number = URL(string: "tel://" + callTo) else { return }
        UIApplication.shared.open(number)
    }
    
    func openUrl(urlStr:String)
    {
        if urlStr.contains("https://"){
            if let url = URL(string: urlStr) {
                UIApplication.shared.open(url)
            }
        }else{
            if let url = URL(string: "https://"+urlStr) {
                UIApplication.shared.open(url)
            }
        }
        
    }
}
