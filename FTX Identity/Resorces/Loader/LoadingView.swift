//
//  LoadingView.swift
//  FTX Identity
//
//  Created by Divyesh Gondaliya on 15/12/21.
//

import Foundation
import UIKit
import Lottie

public class LoadingOverlay{
    var overlayView : UIView!
    private var animationView: AnimationView?
    var mainView = UIView()
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

    init(){
        self.overlayView = UIView()
        overlayView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        overlayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1
        animationView = .init(name: "loading_animation")
        animationView!.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        animationView?.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 3
        overlayView.addSubview(animationView!)
        overlayView.layer.cornerRadius = 125
        overlayView.clipsToBounds = true
        overlayView.setshadow()
    }

    public func showOverlay(view: UIView) {
        overlayView.center = view.center
        mainView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        mainView.frame = view.frame
        mainView.addSubview(overlayView)
        view.addSubview(mainView)
        animationView!.play()
    }

    public func hideOverlayView() {
        animationView?.pause()
        mainView.removeFromSuperview()
    }
}

extension UIView {
    func setshadow() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)//UIColor.white.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize.zero//CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5
    }
}

func hideOverlay()
{
    DispatchQueue.main.async {
        LoadingOverlay.shared.hideOverlayView()
    }    
}
