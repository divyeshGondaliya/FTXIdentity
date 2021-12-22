//
//  TakeSelfieVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 22/12/21.
//

import UIKit
import AVFoundation

class TakeSelfieVC: UIViewController,AVCapturePhotoCaptureDelegate {

    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var btn_retake: UIButton!
    @IBOutlet weak var btn_takephoto: UIButton!
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var selected_img: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var bottom_view: UIView!
    @IBOutlet weak var capture_width: NSLayoutConstraint!
    @IBOutlet weak var capture_height: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_next_press(_ sender: Any) {
        SignUpData.shared.selfieImage = self.captureImageView.image
        self.navigationController?.popViewController(animated: true)
    }
    
    func retake()
    {
        self.selected_img.isHidden = true
        self.captureImageView.image = UIImage()
        self.btn_takephoto.alpha = 1
        self.btn_takephoto.isUserInteractionEnabled = true
        self.btn_retake.isHidden = true
        self.btn_next.isHidden = true
    }
    
    @IBAction func btn_retake_press(_ sender: Any) {
        self.retake()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.capture_width.constant = self.view.frame.width - 48
        self.capture_height.constant = self.view.frame.width - 48
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)//AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            //Step 9
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = previewView.frame
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.insertSublayer(videoPreviewLayer, at: 0)
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }
    }

    @IBAction func didTakePhoto(_ sender: Any) {
        self.selected_img.isHidden = false
        self.view.sendSubviewToBack(self.selected_img)
        LoadingOverlay.shared.showOverlay(view: self.view)
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        captureImageView.image = image
        captureImageView.contentMode = .scaleAspectFill
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.captureImageView.image = self.selected_img.snapshot(of: self.centerView.frame, afterScreenUpdates: false)
            self.captureImageView.contentMode = .scaleAspectFit
            LoadingOverlay.shared.hideOverlayView()
            self.view.bringSubviewToFront(self.selected_img)
            self.btn_next.isHidden = false
            self.view.bringSubviewToFront(self.bottom_view)
            self.btn_takephoto.alpha = 0.5
            self.btn_takephoto.isUserInteractionEnabled = false
            self.btn_retake.isHidden = false
        }
        
    }
}
