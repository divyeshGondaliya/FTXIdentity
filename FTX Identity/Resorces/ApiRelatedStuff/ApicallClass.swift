//
//  ApicallClass.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 14/12/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON



class AFWrapper: NSObject {

    static let sharedInstance = AFWrapper()

    //TODO :-
    /* Handle Time out request alamofire */

    func requestDelete(_ strURL: String, parma:[String : AnyObject]? = [String : AnyObject](),success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void)
    {
        AuthLoginClass.shared.gettingFreshToken { (result) in
        }
        
        let headers:HTTPHeaders = [APIConstant.contentType: APIHeader.contentType,
                       APIConstant.authorization: "Bearer " + AuthLoginClass.shared.FreshToken]
        
        print("-----------")
        print("calling url - \(APIEnvironment.mainURL+strURL)")
        print("header = \(headers.dictionary)")
        print("Param - \(parma ?? [String : AnyObject]())")
        print("-----------")
        
        AF.request(APIEnvironment.mainURL+strURL, method: .delete,parameters: parma, headers: headers).responseJSON { (responseObject) in
            switch responseObject.result {
            case .success(let value):
                let resJson = JSON(value)
                //let title = resJson["title"].string
                //print(title!)
                success(resJson)
            case .failure(let error):
                let error : Error = responseObject.error ?? error
                failure(error)
            }
        }
    }

    func requestGETURL(_ strURL: String, parma:[String : AnyObject]? = [String : AnyObject](),success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void)
    {
        AuthLoginClass.shared.gettingFreshToken { (result) in
        }
        
        let headers:HTTPHeaders = [APIConstant.contentType: APIHeader.contentType,
                       APIConstant.authorization: "Bearer " + AuthLoginClass.shared.FreshToken]
        
        print("-----------")
        print("calling url - \(APIEnvironment.mainURL+strURL)")
        print("header = \(headers.dictionary)")
        print("Param - \(parma ?? [String : AnyObject]())")
        print("-----------")
        
        AF.request(APIEnvironment.mainURL+strURL, method: .get,parameters: parma, headers: headers).responseJSON { (responseObject) in
            switch responseObject.result {
            case .success(let value):
                let resJson = JSON(value)
                //let title = resJson["title"].string
                //print(title!)
                success(resJson)
            case .failure(let error):
                let error : Error = responseObject.error ?? error
                failure(error)
            }
        }
    }

    func requestPOSTURL(_ strURL : String,accessTokenSignup : String? = "", params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        AuthLoginClass.shared.gettingFreshToken { (result) in
        }
        
        var headers:HTTPHeaders  = []
        
        if AuthLoginClass.shared.FreshToken.count > 0
        {
            headers.add(name: APIConstant.authorization, value: "Bearer " + AuthLoginClass.shared.FreshToken)
        }
        if accessTokenSignup?.count ?? 0 > 0
        {
            headers.add(name: APIConstant.authorization, value: "Bearer " + accessTokenSignup!)
        }
        
        var finalUrl = APIEnvironment.mainURL + strURL
        
        switch strURL {
        case ApiURls.guestToken:
            finalUrl = APIEnvironment.serverUrl + strURL
            headers.add(name: APIConstant.contentType, value: APIHeader.contentTypeGuestToken)
        default:
            headers.add(name: APIConstant.contentType, value: APIHeader.contentType)
        }
        
        print("-----------")
        print("calling url - \(finalUrl)")
        print("header = \(headers.dictionary)")
        print("Param - \(params ?? [String : AnyObject]())")
        print("-----------")
        
        if ApiURls.guestToken == strURL
        {
            AF.request(finalUrl, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
                switch responseObject.result {
                case .success(let value):
                    let resJson = JSON(value)
                    success(resJson)
                case .failure(let error):
                    let error : Error = responseObject.error ?? error
                    failure(error)
                }
            }
        }else{
            AF.request(finalUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
                switch responseObject.result {
                case .success(let value):
                    let resJson = JSON(value)
                    success(resJson)
                case .failure(let error):
                    let error : Error = responseObject.error ?? error
                    failure(error)
                }
            }
        }
    }
}


extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}
