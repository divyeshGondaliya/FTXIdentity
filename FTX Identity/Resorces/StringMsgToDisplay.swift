//
//  StringMsgToDisplay.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 22/12/21.
//

import Foundation

class StringMsgToDisplay{
    static let otpError = "Invalid OTP enter."
    
    static let emailNotValid = "Please enter valid email."
    static let selectCountryCode = "Please select country code."
    static let mobileNotValid = "Please enter valid mobile number."
    
    static let instedMobile = "Use Mobile Number instead"
    static let instedEmail = "Use Email Address instead"
    
    static let enterPassword = "Please enter Password."
    static let enterCPassword = "Please enter confirm password."
    static let pwdCpwdSame = "Password and confirm password must be same."
    
    static let takeAllBiometricsFirst = "Please first scan your ID Document and take selfie for verification."
    static let idAlreadyScaned = "Are you sure you want to scan again? Your ID Document last ID Document will be deleted."
    static let selfieAlreadyTaken = "Are you sure you want to captured again? Last selfie image will be deleted."
    static let biometricsError = "Please make sure that your id proof photos is clear."
    
    static let SSNinstead = "Use SSN instead"
    static let BDYinsted = "Use Birth Date instead"
    
    static let enterFname = "Please enter firstname first."
    static let enterLname = "Please enter lastname first."
    static let BDYSelect = "Please select date of birth first."
    static let enterSSN = "Please enter ssn number first."
    
    static let dltRecoveryEmail = "Are you sure you want to delete Email ?"
    static let TwoFADisable = "Are you sure you want to Disable 2FA Authentication?"
    
    static let logout = "Are you sure you want to log out ?"
    
    static let DLTMobileNumber = "Are you sure you want to delete Mobile ?"
}

class StaticArray
{
    static let countryCode = ["+1", "+91"]
    static let countryName = ["usa","india"]
}

class StaticValues
{
    static let OtpSendInTimer = 60
}

class AlertString
{
    static let title = "FTX Identity"
}
