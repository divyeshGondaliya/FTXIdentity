//
//  VideoRecordingVC.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 15/12/21.
//

import AVFoundation
import AssetsLibrary
import UIKit
import Photos

class VideoRecordingVC: MainStuffViewController {

    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var previewImageView: UIImageView!
//    @IBOutlet weak var toggleCameraButton: UIButton!
//
//    @IBOutlet weak var galleryButton: UIButton!
//    @IBOutlet weak var cameraSelectionButton: UIButton!
//    @IBOutlet weak var videoCameraButton: UIButton!
//    @IBOutlet weak var toggleFlashButton: UIButton!
    
    var cameraConfig: CameraConfiguration!
    let imagePickerController = UIImagePickerController()
    
    var videoRecordingStarted: Bool = false {
        didSet{
            if videoRecordingStarted {
                self.cameraButton.tintColor = UIColor.red
            } else {
                self.cameraButton.tintColor = UIColor.white
            }
        }
    }
    
    func checkPermission(completion: @escaping ()->Void) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
            completion()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    completion()
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        case .limited:
            print("User has denied the permission.")
        @unknown default:
            fatalError()
        }
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    fileprivate func registerNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: NSNotification.Name(rawValue: "App is going background"), object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        if videoRecordingStarted {
            videoRecordingStarted = false
            self.cameraConfig.stopRecording { (error) in
                print(error ?? "Video recording error")
            }
        }
    }
    
    @objc func appCameToForeground() {
        print("app enters foreground")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraConfig = CameraConfiguration()
        cameraConfig.setup { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            try? self.cameraConfig.displayPreview(self.previewImageView)
        }
        self.cameraButton.setImage(#imageLiteral(resourceName: "videoRecoder"), for: .normal)
        self.cameraButton.tintColor = UIColor.white
//        self.galleryButton.setImage(#imageLiteral(resourceName: "photo_icon"), for: .normal)
        registerNotification()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.cameraButton.setImage(#imageLiteral(resourceName: "videoRecoder"), for: .normal)
        self.lbl_code.text = "\(SignUpData.shared.biometricCode)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

//    @IBAction func toggleFlash(_ sender: Any) {
//        if cameraConfig.flashMode == .on {
//            cameraConfig.flashMode = .off
//            self.toggleFlashButton.setImage(#imageLiteral(resourceName: "flash_off"), for: .normal)
//        } else if cameraConfig.flashMode == .off {
//            cameraConfig.flashMode = .on
//            self.toggleFlashButton.setImage(#imageLiteral(resourceName: "flash_on"), for: .normal)
//        } else {
//            cameraConfig.flashMode = .auto
//            self.toggleFlashButton.setImage(#imageLiteral(resourceName: "flash_auto"), for: .normal)
//        }
//    }
    
    @objc fileprivate func showToastForSaved() {
//        showToast(message: "Saved!", fontSize: 12.0)
    }
    
    @objc fileprivate func showToastForRecordingStopped() {
        showToast(message: "Recording Stopped", fontSize: 12.0)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showToast(message: "Could not save!! \n\(error)", fontSize: 12)
        } else {
            showToast(message: "Saved", fontSize: 12.0)
            
//            self.galleryButton.setImage(image, for: .normal)
        }
    }
    
    @objc func video(_ video: String, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            
            showToast(message: "Could not save!! \n\(error)", fontSize: 12)
        } else {
            showToast(message: "Saved", fontSize: 12.0)
//            self.playVideo()
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileUrl = paths[0].appendingPathComponent("output.mp4")
            
            if let videoData = try? Data(contentsOf: fileUrl) {
                SignUpData.shared.videoSelfie = videoData
                print(SignUpData.shared.videoSelfie.count)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }                
            }
        }
        print(video)
        
    }
    
    @IBAction func didTapOnTakePhotoButton(_ sender: Any) {
        if self.cameraConfig.outputType == .photo {
            self.cameraConfig.captureImage { (image, error) in
                guard let image = image else {
                    
                    print(error ?? "Image capture error")
                    return
                }
//                self.previewImageView.image = image
//                try? PHPhotoLibrary.shared().performChangesAndWait {
//                    PHAssetChangeRequest.creationRequestForAsset(from: image)
//                }
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        } else {
            if videoRecordingStarted {
                videoRecordingStarted = false
                self.cameraConfig.stopRecording { (error) in
                    print(error ?? "Video recording error")
                }
            } else if !videoRecordingStarted {
                videoRecordingStarted = true
                self.cameraConfig.recordVideo { (url, error) in
                    guard let url = url else {
                        print(error ?? "Video recording error")
                        return
                    }
                    if let videoData = try? Data(contentsOf: url) {
                        SignUpData.shared.videoSelfie = videoData
                        LoadingOverlay.shared.showOverlay(view: self.view)
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                            LoadingOverlay.shared.hideOverlayView()
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
//                    UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(self.video(_:didFinishSavingWithError:contextInfo:)), nil)
                }
            }
        }
    }
    
    
    @IBAction func toggleCamera(_ sender: Any) {
        do {
            try cameraConfig.switchCameras()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func selectVideoMode(_ sender: Any) {
        self.cameraConfig.outputType = .video
        self.cameraButton.setImage(#imageLiteral(resourceName: "videocam"), for: .normal)
    }
    
    @IBAction func selectCameraMode(_ sender: Any) {
        self.cameraConfig.outputType = .photo
        self.cameraButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
    }
    
    @IBAction func btn_retake_press(_ sender: Any) {
//        self.videoView.isHidden = true
    }
    
//    @IBOutlet var videoView: UIView!
//    var phasset: PHAsset?
//    var player : AVPlayer!
//    var url:URL?
//    var avPlayerLayer : AVPlayerLayer!
//    @IBOutlet var videoendTime: UILabel!
//    @IBOutlet var videostartTime: UILabel!
//    @IBOutlet var slider: UISlider!
//    @IBOutlet var playPause: UIButton!
//    var videoTimer : Timer?
    
    @objc func donenavigation()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
//    func playVideo()
//    {
//        let button1 = UIBarButtonItem(image: UIImage(named: "imagename"), style: .plain, target: self, action: #selector(self.donenavigation)) // action:#selector(Class.MethodName) for swift 3
//        self.navigationItem.rightBarButtonItem  = button1
//        self.view.bringSubviewToFront(self.videoView)
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let fileUrl = paths[0].appendingPathComponent("output.mp4")
//        player = AVPlayer(url: fileUrl)
//
//        avPlayerLayer = AVPlayerLayer(player: player)
//        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
//        videoView.layer.insertSublayer(avPlayerLayer, at: 0)//addSublayer(avPlayerLayer)
//        videoTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateVideoSlider), userInfo: nil, repeats: true)
//
//        let currentTimeInSeconds = CMTimeGetSeconds((self.player.currentItem?.asset.duration)!)
//        slider.maximumValue = Float(currentTimeInSeconds)
//        slider.minimumValue = 0
//        slider.value = 0
//
//        let mins = currentTimeInSeconds / 60
//        let secs = currentTimeInSeconds.truncatingRemainder(dividingBy: 60)
//        let timeformatter = NumberFormatter()
//        timeformatter.minimumIntegerDigits = 2
//        timeformatter.minimumFractionDigits = 0
//        timeformatter.roundingMode = .down
//        guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else
//        {
//            return
//        }
//        player.play()
//        videostartTime.font = videostartTime.font.withSize(0.0375 * UIScreen.main.bounds.width)
//        videoendTime.font = videoendTime.font.withSize(0.0375 * UIScreen.main.bounds.width)
//        videoendTime.text = "\(minsStr):\(secsStr)"
//
//        self.videoView.isHidden = false
//    }
//    override func viewDidLayoutSubviews() {
//        if videoView.isHidden == false
//        {
//            avPlayerLayer.frame = videoView.layer.bounds
//        }
//
//    }
//
//
//    @objc func updateVideoSlider()
//    {
//        if self.player.isPlaying
//        {
//            let currentTimeInSeconds = CMTimeGetSeconds(self.player.currentTime())
//            slider.value = Float(currentTimeInSeconds)
//            let mins = currentTimeInSeconds / 60
//            let secs = currentTimeInSeconds.truncatingRemainder(dividingBy: 60)
//            let timeformatter = NumberFormatter()
//            timeformatter.minimumIntegerDigits = 2
//            timeformatter.minimumFractionDigits = 0
//            timeformatter.roundingMode = .down
//            guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
//                return
//            }
//            videostartTime.text = "\(minsStr):\(secsStr)"
//        }
//        if self.player.currentTime() >= (self.player.currentItem?.duration)! {
//            slider.value = 0
//            videostartTime.text = "00:00"
//            playPause.setTitle("Play", for: .normal)
//            videoTimer?.invalidate()
//        }
//
//    }
//
//    @IBAction func playPauseVideo(_ sender: UIButton) {
//        if player.isPlaying
//        {
//            player.pause()
//            playPause.setTitle("Play", for: .normal)
//        }else{
//            videoTimer?.invalidate()
//            if player.currentTime() == player.currentItem?.asset.duration
//            {
//                player.seek(to: CMTimeMake(value: 0, timescale: 1))
//            }
//            videoTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateVideoSlider), userInfo: nil, repeats: true)
//            player.play();
//            playPause.setTitle("Pause", for: .normal)
//        }
//    }
//
//    @IBAction func videoSliderChanged(_ sender: UISlider) {
//        videoTimer?.invalidate()
//        videoTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateVideoSlider), userInfo: nil, repeats: true)
//        let seconds : Int64 = Int64(sender.value)
//        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
//
//        player!.seek(to: targetTime)
//
//        if player!.rate == 0
//        {
//            playPause.setTitle("Pause", for: .normal)
//            player?.play()
//        }
//    }
    
    
}


//extension AVPlayer {
//
//    var isPlaying: Bool {
//        if (self.rate != 0 && self.error == nil) {
//            return true
//        } else {
//            return false
//        }
//    }
//
//}
//extension VideoRecodingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            self.galleryButton.contentMode = .scaleAspectFit
//            self.galleryButton.setImage( pickedImage, for: .normal)
//        }
//        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
//            print("videoURL:\(String(describing: videoURL))")
//        }
//
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//
//}




