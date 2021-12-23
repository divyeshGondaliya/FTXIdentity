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

extension String
{
    func generateQRCode()->UIImage?
    {
        // Get data from the string
        let data = self.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil}
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return nil}
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil}
        let processedImage = UIImage(cgImage: cgImage)
//        self.img_qrcode.image = processedImage
        return processedImage
    }
}

extension String
{
    func createImage()->UIImage
    {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        outerView.backgroundColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        lbl.font = UIFont(name: "SourceSansPro-Regular", size: 70)
        lbl.text = self
        lbl.textAlignment = .center
        lbl.textColor = UIColor.white
        
        outerView.addSubview(lbl)
        
        let renderer = UIGraphicsImageRenderer(size: outerView.bounds.size)
        let convertedImage = renderer.image { ctx in
            outerView.drawHierarchy(in: outerView.bounds, afterScreenUpdates: true)
            
        }
        return convertedImage
    }
}
