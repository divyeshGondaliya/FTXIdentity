//
//  Reachability.swift
//  FTX Identity
//
//  Created by Darshan on 24/01/22.
//

import Foundation
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
    
    static func checkAndDisplayMsgForInternetConnection()
    {
        if Connectivity.isConnectedToInternet {
            print("Connected")
        } else {
            NotificationCenter.default.post(name: Notification.Name("InternetConnectionError"), object: nil)
        }
    }
}


