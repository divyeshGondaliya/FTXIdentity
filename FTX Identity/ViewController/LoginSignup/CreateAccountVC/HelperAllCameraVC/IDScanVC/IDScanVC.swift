//
//  IDScanVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 15/12/21.
//

import UIKit
import AVFoundation

enum ForImage {
    case FRONT
    case BACK
}
class IDScanVC: UIViewController,AVCapturePhotoCaptureDelegate {

    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var lbl_instruction: UILabel!
    @IBOutlet weak var btn_retake: UIButton!
    @IBOutlet weak var btn_takephoto: UIButton!
    @IBOutlet weak var btn_next: UIButton!
    @IBOutlet weak var selected_img: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var bottom_view: UIView!
    
//    var img_front:UIImage!
//    var img_back:UIImage!
    
    var forimg = ForImage.FRONT
    
    @IBOutlet weak var img_front_side: UIImageView!
    @IBOutlet weak var img_back_side: UIImageView!
    @IBOutlet weak var lbl_back_side: UILabel!
    @IBOutlet weak var lbl_front_side: UILabel!
    
    let selectedcolor = #colorLiteral(red: 0.05490196078, green: 0.1921568627, blue: 0.4705882353, alpha: 1)
    let unselectedcolor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_instruction.text = "Take the photo of front side of your ID Card"
        self.selected_img.isHidden = true
//        navigationController?.setNavigationBarHidden(false, animated: true)
        self.btn_next.isHidden = true
        self.btn_retake.isHidden = true
        self.setupviewFrontBack()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_back_side_press(_ sender: Any) {
        if SignUpData.shared.frontIDImg == nil
        {
            showalert(vc: self, title: "FTX Identity", subTitle: "Please first capture image for front side.")
        }else{
            self.forimg = .BACK
            self.setupviewFrontBack()
        }        
    }
    
    @IBAction func front_side_press(_ sender: Any) {
        self.forimg = .FRONT
        self.setupviewFrontBack()
    }
    
    @IBAction func btn_next_press(_ sender: Any) {
        switch self.forimg {
        case .FRONT:
            SignUpData.shared.frontIDImg = self.captureImageView.image
            self.retake()
            self.forimg = .BACK
            self.setupviewFrontBack()
        case .BACK:
            self.lbl_instruction.text = "Turn the back side of your ID Card and capture the photo"
            SignUpData.shared.backIDImg = self.captureImageView.image
            if SignUpData.shared.selfieImage != nil
            {
                self.navigationController?.popViewController(animated: true)
            }else{
                self.navigationController?.popViewController(animated: true)
//                let vc = VideoRecordingVC(nibName: "VideoRecordingVC", bundle: nil)
                let vc = TakeSelfieVC(nibName: "TakeSelfieVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
//            let vc = IDPreviewVC(nibName: "IDPreviewVC", bundle: nil)
//            vc.frontimg = self.img_front
//            vc.backimg = self.img_back
//            self.navigationController?.pushViewController(vc, animated: true)
        }
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
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
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
//        previewView.layer.addSublayer(videoPreviewLayer)
        previewView.layer.insertSublayer(videoPreviewLayer, at: 0)
        //Step12
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            //Step 13
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
//            self.captureImageView.backgroundColor = .white
            LoadingOverlay.shared.hideOverlayView()
            self.view.bringSubviewToFront(self.selected_img)
            self.btn_next.isHidden = false
            self.view.bringSubviewToFront(self.bottom_view)
            self.btn_takephoto.alpha = 0.5
            self.btn_takephoto.isUserInteractionEnabled = false
            self.btn_retake.isHidden = false
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView {

    /// Create snapshot
    ///
    /// - Parameters:
    ///   - rect: The coordinates (in the view's own coordinate space) to be captured. If omitted, the entire `bounds` will be captured.
    ///   - afterScreenUpdates: A Boolean value that indicates whether the snapshot should be rendered after recent changes have been incorporated. Specify the value false if you want to render a snapshot in the view hierarchy’s current state, which might not include recent changes. Defaults to `true`.
    ///
    /// - Returns: Returns `UIImage` of the specified portion of the view.

    func snapshot(of rect: CGRect? = nil, afterScreenUpdates: Bool = true) -> UIImage? {
        // snapshot entire view

        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
        let wholeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // if no `rect` provided, return image of whole view

        guard let image = wholeImage, let rect = rect else { return wholeImage }

        // otherwise, grab specified `rect` of image

        guard let cgImage = image.cgImage?.cropping(to: rect * image.scale) else { return nil }
        return UIImage(cgImage: cgImage, scale: image.scale, orientation: .up)
    }

}
extension CGRect {
    static func * (lhs: CGRect, rhs: CGFloat) -> CGRect {
        return CGRect(x: lhs.minX * rhs, y: lhs.minY * rhs, width: lhs.width * rhs, height: lhs.height * rhs)
    }
}


extension IDScanVC
{
    func setupviewFrontBack()
    {
        self.lbl_front_side.textColor = self.unselectedcolor
        self.img_front_side.tintColor = self.unselectedcolor
        self.lbl_back_side.textColor = self.unselectedcolor
        self.img_back_side.tintColor = self.unselectedcolor
        
        switch self.forimg {
        case .FRONT:
            self.lbl_instruction.text = "Take the photo of front side of your ID Card"
            self.lbl_front_side.textColor = self.selectedcolor
            self.img_front_side.tintColor = self.selectedcolor
        case .BACK:
            self.lbl_instruction.text = "Turn the back side of your ID Card and capture the photo"
            self.lbl_back_side.textColor = self.selectedcolor
            self.img_back_side.tintColor = self.selectedcolor
        }
    }
}
