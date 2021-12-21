//
//  PersonalInfoVC+Helper.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 21/12/21.
//

import Foundation
import UIKit
import Photos

extension PersonalInfoVC
{
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension PersonalInfoVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    //MARK:-- ImagePicker delegate
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        if let pickedImage = info[.originalImage] as? UIImage {
            let pickedImage = pickedImage.fixedOrientation
            if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                if let imgData = pickedImage.pngData()
                {
                    self.uploadProfilePic(imgData: imgData, fileName: url.pathExtension)
                }
            }else{
                if let imgData = pickedImage.pngData()
                {
                    self.uploadProfilePic(imgData: imgData, fileName: "png")
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

