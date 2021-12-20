//
//  AuthLoginClass.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 15/12/21.
//

import Foundation
import AppAuth

typealias PostRegistrationCallback = (_ configuration: OIDServiceConfiguration?, _ registrationResponse: OIDRegistrationResponse?) -> Void
let kIssuer: String = "https://ftxidentity.goftx.com/"
let kClientID: String? = "ftxcoremyprofilelocal"
let kRedirectURI: String = "ftx.identity.goftx.com://callback"
let kAppAuthExampleAuthStateKey: String = "authState"

class AuthLoginClass:NSObject
{
    static let shared = AuthLoginClass()
    
    var authState: OIDAuthState?
    
    var FreshToken = ""
    
    func performAuthAndLogin(vc:UIViewController,completionHandler:@escaping (Bool) -> Void)
    {        
        guard let issuer = URL(string: kIssuer) else {
            self.logMessage("Error creating URL for : \(kIssuer)")
            completionHandler(false)
            return
        }
        
        self.logMessage("Fetching configuration for issuer: \(issuer)")
        
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { configuration, error in
            
            if let error = error  {
                self.logMessage("Error retrieving discovery document: \(error.localizedDescription)")
                completionHandler(false)
                return
            }
            
            guard let configuration = configuration else {
                self.logMessage("Error retrieving discovery document. Error & Configuration both are NIL!")
                completionHandler(false)
                return
            }
            
            self.logMessage("Got configuration: \(configuration)")
            if let clientId = kClientID {
                self.authAndTokenRetrived(vc: vc, configuration: configuration, clientID: clientId, clientSecret: nil) { (result) in
                    completionHandler(result)
                }
            } else {
                self.doClientRegistration(configuration: configuration) { configuration, response in
                    guard let configuration = configuration, let response = response else {
                        completionHandler(false)
                        return
                    }
                    self.authAndTokenRetrived(vc: vc, configuration: configuration,
                                              clientID: response.clientID,
                                              clientSecret: response.clientSecret) { (result) in
                        completionHandler(result)
                    }
                }
            }
        }
        completionHandler(false)
    }
    
    func gettingFreshToken(completionHandler:@escaping (Bool) -> Void)
    {
        
//        self.authState?.performAction(freshTokens: { (accessToken, idToken, error) in
//            if error != nil  {
//                self.logMessage("Error fetching fresh tokens: \(error?.localizedDescription ?? "Unknown error")")
//                completionHandler(false)
//                return
//            }
//            guard let accessToken = accessToken else {
//                completionHandler(false)
//                return
//            }
//            self.FreshToken = accessToken
//            self.logMessage("--------------")
//            self.logMessage("freshTokens")
//            self.logMessage("--------------")
//            self.logMessage(accessToken)
//            self.logMessage("--------------")
//            completionHandler(true)
//        })
        self.authState?.setNeedsTokenRefresh()
        self.authState?.performAction() { (accessToken, idToken, error) in

            if error != nil  {
                print("Error fetching fresh tokens: \(error?.localizedDescription ?? "Unknown error")")
                completionHandler(false)
                return
            }
            guard let accessToken = accessToken else {
                completionHandler(false)
                return
            }
            self.FreshToken = accessToken
            completionHandler(true)
        }
        
    }
}


extension AuthLoginClass
{
    func validateOAuthConfiguration() {
        assert(kIssuer != "https://issuer.example.com",
               "Update kIssuer with your own issuer.\n" +
                "Instructions: https://github.com/openid/AppAuth-iOS/blob/master/Examples/Example-iOS_Swift-Carthage/README.md");
        
        assert(kClientID != "YOUR_CLIENT_ID",
               "Update kClientID with your own client ID.\n" +
                "Instructions: https://github.com/openid/AppAuth-iOS/blob/master/Examples/Example-iOS_Swift-Carthage/README.md");
        
        assert(kRedirectURI != "com.example.app:/oauth2redirect/example-provider",
               "Update kRedirectURI with your own redirect URI.\n" +
                "Instructions: https://github.com/openid/AppAuth-iOS/blob/master/Examples/Example-iOS_Swift-Carthage/README.md");
        
        guard let urlTypes: [AnyObject] = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [AnyObject], urlTypes.count > 0 else {
            assertionFailure("No custom URI scheme has been configured for the project.")
            return
        }
        
        guard let items = urlTypes[0] as? [String: AnyObject],
              let urlSchemes = items["CFBundleURLSchemes"] as? [AnyObject], urlSchemes.count > 0 else {
            assertionFailure("No custom URI scheme has been configured for the project.")
            return
        }
        
        guard let urlScheme = urlSchemes[0] as? String else {
            assertionFailure("No custom URI scheme has been configured for the project.")
            return
        }
        assert(urlScheme != "com.example.app",
               "Configure the URI scheme in Info.plist (URL Types -> Item 0 -> URL Schemes -> Item 0) " +
                "with the scheme of your redirect URI. Full instructions: " +
                "https://github.com/openid/AppAuth-iOS/blob/master/Examples/Example-iOS_Swift-Carthage/README.md")
    }
}

//MARK: AppAuth Methods
extension AuthLoginClass {
    
    func doClientRegistration(configuration: OIDServiceConfiguration, callback: @escaping PostRegistrationCallback) {
        
        guard let redirectURI = URL(string: kRedirectURI) else {
            self.logMessage("Error creating URL for : \(kRedirectURI)")
            return
        }
        
        let request: OIDRegistrationRequest = OIDRegistrationRequest(configuration: configuration,
                                                                     redirectURIs: [redirectURI],
                                                                     responseTypes: ["code"],
                                                                     grantTypes: ["authorization_code"],
                                                                     subjectType: nil,
                                                                     tokenEndpointAuthMethod: "client_secret_post",
                                                                     additionalParameters: ["acr_values":"tenant:dev-myprofile.goftx.com"])
        // performs registration request
        self.logMessage("Initiating registration request")
        
        OIDAuthorizationService.perform(request) { response, error in
            
            if let regResponse = response {
                self.setAuthState(OIDAuthState(registrationResponse: regResponse))
                self.logMessage("Got registration response: \(regResponse)")
                callback(configuration, regResponse)
            } else {
                self.logMessage("Registration error: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
                self.setAuthState(nil)
            }
        }
    }
    
    func authAndTokenRetrived(vc:UIViewController,configuration: OIDServiceConfiguration, clientID: String, clientSecret: String?,completionHandler:@escaping (Bool) -> Void) {
        
        guard let redirectURI = URL(string: kRedirectURI) else {
            self.logMessage("Error creating URL for : \(kRedirectURI)")
            completionHandler(false)
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            self.logMessage("Error accessing AppDelegate")
            completionHandler(false)
            return
        }
        
        let config = OIDServiceConfiguration(authorizationEndpoint: configuration.authorizationEndpoint, tokenEndpoint: URL(string: "https://ftxidentity.goftx.com/connect/token")!, issuer: configuration.issuer, registrationEndpoint: configuration.registrationEndpoint, endSessionEndpoint: configuration.endSessionEndpoint)
        // builds authentication request
        let request = OIDAuthorizationRequest(configuration: config,
                                              clientId: clientID,
                                              clientSecret: clientSecret,
                                              scopes: [OIDScopeOpenID, OIDScopeProfile, "identity.api", "offline_access"],
                                              redirectURL: redirectURI,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: ["acr_values":"tenant:dev-myprofile.goftx.com","response_mode":"query"])
        
        logMessage("Initiating authorization request with scope: \(request.scope ?? "DEFAULT_SCOPE")")
        print("--------------------------")
        print("request = \(request)")
        print("--------------------------")
        appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: vc) { (authState, error) in
            if let authState = authState {
                self.setAuthState(authState)
                self.FreshToken = authState.lastTokenResponse?.accessToken ?? ""
                self.logMessage("Got authorization tokens. Access token: \(authState.lastTokenResponse?.accessToken ?? "DEFAULT_TOKEN")")
                self.logMessage("Got authorization tokens. refreshToken: \(authState.lastTokenResponse?.refreshToken ?? "refreshToken")")
                completionHandler(true)
            } else {
                self.logMessage("Authorization error: \(error?.localizedDescription ?? "DEFAULT_ERROR")")
                self.setAuthState(nil)
                completionHandler(false)
            }
        }
    }
}

//MARK: OIDAuthState Delegate
extension AuthLoginClass: OIDAuthStateChangeDelegate, OIDAuthStateErrorDelegate {
    
    func didChange(_ state: OIDAuthState) {
        self.stateChanged()
    }
    
    func authState(_ state: OIDAuthState, didEncounterAuthorizationError error: Error) {
        self.logMessage("Received authorization error: \(error)")
    }
}

//MARK: Helper Methods
extension AuthLoginClass {
    
    func saveState() {
        
        var data: Data? = nil
        
        if let authState = self.authState {
            data = try? NSKeyedArchiver.archivedData(withRootObject: authState, requiringSecureCoding: true)
            //            data = NSKeyedArchiver.archivedData(withRootObject: authState)
        }
        
        if let userDefaults = UserDefaults(suiteName: "group.net.openid.appauth.Example") {
            userDefaults.set(data, forKey: kAppAuthExampleAuthStateKey)
            userDefaults.synchronize()
        }
    }
    
    func loadState() {
        guard let data = UserDefaults(suiteName: "group.net.openid.appauth.Example")?.object(forKey: kAppAuthExampleAuthStateKey) as? Data else {
            return
        }
        do{
            let authState = try NSKeyedUnarchiver.unarchivedObject(ofClass: OIDAuthState.self, from: data)
            self.setAuthState(authState)
        }catch{
            self.logMessage(error.localizedDescription)
        }
    }
    
    func setAuthState(_ authState: OIDAuthState?) {
        if (self.authState == authState) {
            return;
        }
        self.authState = authState;
        self.authState?.stateChangeDelegate = self
        self.stateChanged()
        self.gettingFreshToken { (result) in
            
        }
    }
    
    func stateChanged() {
        self.saveState()
    }
    
    func logMessage(_ message: String?) {
        
        guard let message = message else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss";
        let dateString = dateFormatter.string(from: Date())
        print("\n\(dateString): \(message)")
    }
}
