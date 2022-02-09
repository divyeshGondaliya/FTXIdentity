//
//  VerifyUserVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 07/02/22.
//

import UIKit
import AVFoundation

protocol VerifyUser:AnyObject {
    func compareFace(userVerfied:Bool)
}
var api_key = Data("75Kl4C0GID0tUvDF2wtBO2NLzcnzvTMjZXAbWLQS".utf8)
class VerifyUserVC: UIViewController {
    weak var delegate: VerifyUser?
    
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var img_view: UIImageView!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    let videoOutput = AVCaptureVideoDataOutput()
    
    var rocognice = false
    var faceFeatureGlobal:FMFaceFeature!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.captureSession?.stopRunning()
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        DispatchQueue.main.async {
            self.faceFeatureGlobal = nil
            self.captureSession?.stopRunning()
            self.dismiss(animated: true, completion: nil)
        }        
    }
    
}

extension VerifyUserVC
{
    func faceDetection(image:CIImage)
    {
        let classObj = FaceCompareHelper()
        if classObj.compareData(image, compareto: self.faceFeatureGlobal)
        {
            DispatchQueue.main.async {
                print("Compare Done")
                self.dismiss(animated: true) {
                    self.delegate?.compareFace(userVerfied: true)
                }
            }
        }else{
            DispatchQueue.main.async {
                self.delegate?.compareFace(userVerfied: false)
                print("Compare Not Done")
                self.rocognice = false
            }
        }
    }
}
