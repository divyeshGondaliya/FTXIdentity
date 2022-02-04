//
//  SignUpData.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import Foundation
import UIKit

class SignUpData
{
    static let shared = SignUpData()
    
    var access_token = ""
    var videoSelfie:Data!
//    var selfieImage:UIImage!
//    var selfieImage_1:UIImage!
//    var selfieImage_2:UIImage!
    var selfieImageFaceMe:UIImage!
    var frontIDImg:UIImage!
    var backIDImg:UIImage!
    
//    Step 1
    var signUpBy = -1
    var userName = ""
    var email = ""
    var countryCode = ""
    var phoneNumber = ""
    
//    step 2
    var userTempId = ""
    
//    step 3
    var biometricOption = -1
    var biometricCode = -1
    var biometricsVerfyByServer = false
    
//    step 4
    var firstName = ""
    var lastName = ""
    var dateOfBirth = ""
    
    func initdata()
    {
        self.access_token = ""
        self.videoSelfie = nil
//        self.selfieImage = nil
//        self.selfieImage_1 = nil
//        self.selfieImage_2 = nil
        self.selfieImageFaceMe = nil
        self.frontIDImg = nil
        self.backIDImg = nil
        self.signUpBy = -1
        self.userName = ""
        self.email = ""
        self.countryCode = ""
        self.phoneNumber = ""
        self.userTempId = ""
        self.biometricOption = -1
        self.biometricCode = -1
        self.biometricsVerfyByServer = false
        self.firstName = ""
        self.lastName = ""
        self.dateOfBirth = ""
    }
}
