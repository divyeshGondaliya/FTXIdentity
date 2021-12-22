//
//  Constant.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 15/12/21.
//

import Foundation

class APIEnvironment {
    static let mainURL = "https://ftxidentity-api.goftx.com"
    static let serverUrl = "https://ftxidentity.goftx.com"
}

class ApiKey
{
    static let CLIENT_CREDENTIALS_CLIENTID = "34980034-3020-4aaa-a25d-96a9734250a3"
    static let CLIENT_CREDENTIALS_SECRET = "b577ee09-b6ca-4905-b35a-c8aafc8d9091"
    static let CLIENT_CREDENTIALS_GRANT_TYPE = "client_credentials"
}

class ApiURls{
    static let guestToken = "/connect/token"
    
    static let userDetails          = "/api/v1/Account"
    static let SignupStep1          = "/api/v1/Signup/Availability"
    static let SignupStep2          = "/api/v2/Signup/Otp"
    static let SignupStep3          = "/api/v2/Signup/Otp/Verify"
    static let OtpResend            = "/api/v2/Signup/Otp/Resend"
    static let SignupStep4          = "/api/v2/Signup/Biometric"
    static let SignupStep5          = "/api/v2/Signup"
    static let Memberships          = "/api/v1/Profile/Memberships"
    static let ClaimType            = "/api/v1/ClaimType"
    static let allow_Identity       = "/api/v1/Profile/Identity"
    static let delete_shredIdentity = "/api/v1/Profile/Identity/"
    static let personalInfo         = "/api/v1/Profile/PersonalInfo"
    static let firstNameUpdate      = "/api/v1/Profile/FirstName"
    static let lastNameUpdate       = "/api/v1/Profile/LastName"
    static let SSNUpdate            = "/api/v1/Profile/SSN"
    static let DOBUpdate            = "/api/v1/Profile/DOB"
    static let EmailUpdate          = "/api/v1/Profile/Email"
    static let EmailVerify          = "/api/v1/Profile/Email/Verify"
    static let PasswordUpdate       = "/api/v1/Profile/Password"
    static let updateProfileImage   = "/api/v1/Profile/Image"
    static let SigninInfo           = "/api/v1/Profile/SigninInfo"
    static let Profile_Enable2Fa    = "/api/v1/Profile/Enable2Fa"
    static let Save2Fa              = "/api/v1/Profile/Save2Fa"
    static let Disable2Fa           = "/api/v1/Profile/Disable2Fa"
}

struct APIHeader {
    static let contentType = "application/json"
    static let contentTypeGuestToken = "application/x-www-form-urlencoded"
    static let Accept = "text/json"
    static let formData = "multipart/form-data"
}

class ParamDefaults
{
    static let accountApplicationId = ""
}

class SignupBy
{
    static let None = 0
    static let Email = 1
    static let PhoneNumber = 2
}

struct APIConstant {
    static let email = "email"
    static let password = "password"
    static let firebaseId = "fb_uuid"
    static let userName = "username"
    static let firstName = "first_name"
    static let lastName = "last_name"
    static let addressline1 = "address_line_1"
    static let addressline2 = "address_line_2"
    static let state = "state"
    static let city = "city"
    static let zip = "zip"
    static let phoneNumber = "phone"
    static let countryCode = "countrycode"
    static let birthDate = "date_of_birth"
    static let sex = "customer_sex"
    static let profilePic = "avatar_url"
    static let contentType = "content-type"
    static let authorization = "Authorization"
    static let registrationToken = "reg_token"
    static let oldRegistrationToken = "old_reg_token"
    static let referralCode = "referral_code"
    static let forceReferralCheck = "forceReferralCheck"
    static let approvePolicies = "approve_policies"
    static let accountApplicationId = "accountApplicationId"
    
    
}
