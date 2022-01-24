//
//  QrCodeScannerVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 23/12/21.
//

import UIKit
import AVFoundation

protocol QrCodeScannerDelegate:class {
    func openQrCodeDisplay()
}

class QrCodeScannerVC: MainStuffViewController {
    
    @IBOutlet weak var priviewView: UIView!
    @IBOutlet weak var center_view: UIView!
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    weak var delegate:QrCodeScannerDelegate?
    
    let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                              AVMetadataObject.ObjectType.code39,
                              AVMetadataObject.ObjectType.code39Mod43,
                              AVMetadataObject.ObjectType.code93,
                              AVMetadataObject.ObjectType.code128,
                              AVMetadataObject.ObjectType.ean8,
                              AVMetadataObject.ObjectType.ean13,
                              AVMetadataObject.ObjectType.aztec,
                              AVMetadataObject.ObjectType.pdf417,
                              AVMetadataObject.ObjectType.itf14,
                              AVMetadataObject.ObjectType.dataMatrix,
                              AVMetadataObject.ObjectType.interleaved2of5,
                              AVMetadataObject.ObjectType.qr]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func open_qr_code_press(_ sender: Any) {
        self.dismiss(animated: true) {
            DispatchQueue.main.async {
                self.delegate?.openQrCodeDisplay()
            }
        }
    }
    @IBAction func btn_close_press(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupCameraView()
    }
    
}

