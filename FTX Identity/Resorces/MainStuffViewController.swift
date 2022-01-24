//
//  MainStuffViewController.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 17/12/21.
//

import UIKit

class MainStuffViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet {
             print("Connected")
         } else {
             DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                 CustomToast.show(message: "Couldn't connect to internet.", bgColor: UIColor(displayP3Red: 255/255, green: 51/255, blue: 51/255, alpha: 1), textColor: .white, labelFont: UIFont(name: "SourceSansPro-Regular", size: 12)!, showIn: .top, controller: self)
             }
        }
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("InternetConnectionError"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("InternetConnectionError"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        CustomToast.show(message: "Couldn't connect to internet.", bgColor: UIColor(displayP3Red: 255/255, green: 51/255, blue: 51/255, alpha: 1), textColor: .white, labelFont: UIFont(name: "SourceSansPro-Regular", size: 12)!, showIn: .top, controller: self)
    }

}
