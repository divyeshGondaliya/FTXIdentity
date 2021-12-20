//
//  CustomAlertView.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import Foundation
import FCAlertView

public class CustomAlertView {
    
    public class func display(withTitle title: String?,doneTitle : String? = "Ok", andMessage message: String?, in viewController: UIViewController,andButton:Bool = false,andAlertType alertType:Int? = 0, completion: ((Bool)->())? = nil) {
        
        let customAlert = FCAlertView()
        customAlert.colorScheme = customAlert.flatTurquoise
        customAlert.blurBackground = false
        customAlert.bounceAnimations = true
        customAlert.cornerRadius = CGFloat(20)
        customAlert.animateAlertOutToBottom = true
        
        if andButton == true {
            customAlert.addButton("Yes") {
                completion?(true)
            }
        }
        
        if let objAlertType = alertType {
            switch objAlertType {
            case 1:
                customAlert.makeAlertTypeSuccess()
            case 2:
                customAlert.makeAlertTypeWarning()
            case 3:
                customAlert.makeAlertTypeCaution()
            case 4:
                customAlert.secondButtonHighlightedBackgroundColor = .red
                customAlert.secondButtonBackgroundColor = .red
            default:
                break
            }
        }
        
        customAlert.doneActionBlock {
            customAlert.dismiss()
            completion?(false)
        }
        
        customAlert.showAlert(inView: viewController, withTitle: title, withSubtitle: message, withCustomImage: nil, withDoneButtonTitle: doneTitle, andButtons:nil)
    }
    
    public class func display(activeViewController:UIViewController,withTitle title: String?,doneTitle:String? = "Ok", andMessage message: String?,andButton:Bool = false,andAlertType alertType:Int? = 0, completion: ((Bool)->())? = nil ) {
        // Get the active view controller
        
        // Display the alert in the active view controller
        display(withTitle: title,doneTitle:doneTitle, andMessage: message, in: activeViewController,andButton: andButton,andAlertType:alertType) { (response) in
            completion?(response)
        }
    }
    
    public enum AlertType {
        case success
        case error
        case warning
    }
    
    public class func display(
        title: String?,
        message: String?,
        type: AlertType,
        doneButtonTitle: String = "Done",
        cancelButtonTitle: String? = "Cancel",
        cancel: (() -> ())? = nil,
        done: (() -> ())? = nil
    ) {
        let customAlert = FCAlertView()
        customAlert.colorScheme = customAlert.flatTurquoise
        customAlert.blurBackground = false
        customAlert.bounceAnimations = true
        customAlert.cornerRadius = CGFloat(20)
        customAlert.animateAlertOutToBottom = true
        
        switch type {
        case .success:
            customAlert.makeAlertTypeSuccess()
        case .error:
            customAlert.makeAlertTypeWarning()
        case .warning:
            customAlert.makeAlertTypeCaution()
        }
        if cancelButtonTitle == "Don't Show"
        {
            
        }else{
            if let cancelButtonTitle = cancelButtonTitle {
                customAlert.addButton(cancelButtonTitle) {
                    customAlert.dismiss()
                    cancel?()
                }
            }
        }
        customAlert.doneActionBlock {
            customAlert.dismiss()
            done?()
        }
        
        customAlert.showAlert(
            withTitle: title ?? "",
            withSubtitle: message ?? "",
            withCustomImage: nil,
            withDoneButtonTitle: doneButtonTitle,
            andButtons: nil
        )
    }
    
    public class func display(
        _ alert: AlertMessage,
        cancel: (() -> ())? = nil,
        done: (() -> ())? = nil
    ) {
        display(
            title: alert.title,
            message: alert.message,
            type: alert.type,
            doneButtonTitle: alert.doneTitle,
            cancelButtonTitle: alert.cancelTitle,
            cancel: cancel,
            done: done
        )
    }
    
}


public struct AlertMessage {
    
    public let title: String
    public let message: String?
    public let doneTitle: String
    public let cancelTitle: String?
    public let type: CustomAlertView.AlertType
    
    public init(
        title: String,
        message: String?,
        type: CustomAlertView.AlertType,
        doneTitle: String = "OK",
        cancelTitle: String? = nil
    ) {
        self.title = title
        self.message = message
        self.type = type
        self.doneTitle = doneTitle
        self.cancelTitle = cancelTitle
    }
    
    public func display() {
        CustomAlertView.display(self)
    }
    
}
