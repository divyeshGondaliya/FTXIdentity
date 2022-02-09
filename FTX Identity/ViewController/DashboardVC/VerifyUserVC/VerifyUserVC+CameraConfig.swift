//
//  VerifyUserVC+CameraConfig.swift
//  FTX Identity
//
//  Created by Darshan on 07/02/22.
//

import Foundation
import AVFoundation

extension VerifyUserVC
{
    func startVideo()
    {
        if let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        {
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                previewView.layer.addSublayer(videoPreviewLayer!)
                captureSession?.startRunning()
                
                self.addVideoOutput()
            } catch {
                print(error)
            }
        }
    }
    
    private func addVideoOutput() {
        self.videoOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        self.videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "my.image.handling.queue"))
        self.captureSession?.addOutput(self.videoOutput)
        
    }
}

extension VerifyUserVC: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        connection.videoOrientation = .portrait
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        DispatchQueue.main.async {
            let attachments = CMCopyDictionaryOfAttachments(allocator: kCFAllocatorDefault, target: sampleBuffer, attachmentMode: kCMAttachmentMode_ShouldPropagate)
            let ciImage = CIImage(cvImageBuffer: frame, options: (attachments as! [CIImageOption : Any]))
        
            if self.rocognice == false && self.faceFeatureGlobal != nil
            {
                self.rocognice = true
                self.faceDetection(image: ciImage)
            }
        }
            
    }
}
