//
//  DisplayImageVC.swift
//  FTX Identity
//
//  Created by Darshan on 23/12/21.
//

import UIKit
import Kingfisher
class DisplayImageVC: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var container_view: UIView!
    
    var imageView: UIImageView!
    var scrollImg: UIScrollView!
    
    var imgStringUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: imgStringUrl)
        {
            LoadingOverlay.shared.showOverlay(view: self.view)
            KingfisherManager.shared.retrieveImage(with: url) { result in
                let image = try? result.get().image
                if let image = image {
                    self.setup_Image(img:image)
                }
                LoadingOverlay.shared.hideOverlayView()
            }
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setup_Image(img:UIImage)
    {
        // Do any additional setup after loading the view.
        let vWidth = self.container_view.frame.width
        let vHeight = self.container_view.frame.height
        
        scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
        scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0
        scrollImg.backgroundColor = .clear
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest)
        
        self.container_view.addSubview(scrollImg)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: vWidth, height: vHeight))
        imageView.image = UIImage(named: "cat")
        imageView!.layer.cornerRadius = 11.0
        imageView!.clipsToBounds = false
        scrollImg.addSubview(imageView!)
        imageView.backgroundColor = .clear
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = img
    }
    
    @IBAction func btn_back_press(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = imageView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
