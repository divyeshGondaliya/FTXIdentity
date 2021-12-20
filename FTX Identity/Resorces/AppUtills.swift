//
//  AppUtills.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 16/12/21.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

extension String
{
    func getFirstLetterOfTwoString()->String
    {
        var str = ""
        let arr = self.components(separatedBy: " ")
        if arr.count > 1
        {
            str = String(arr[0].prefix(1))
            str = "\(str)\(arr[1].prefix(1))"
        }else if arr.count > 0{
            str = String(arr[0].prefix(1))
        }
        return str
    }
}
