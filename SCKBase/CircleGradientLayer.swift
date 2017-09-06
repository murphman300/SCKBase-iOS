//
//  CircleGradientLayer.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-09-04.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit

public protocol GradientLoaderDelegate {
    func gradient(loader: LinearGradientCircleLoader, hasAppeared: Bool)
}

open class LinearGradientCircleLoader: UIView, CAAnimationDelegate {
    
    var lay = LinearGradientLayer()
    
    var loadDelegate : GradientLoaderDelegate?
    
    private var hasLoaded : Bool = false
    
    var switchAnimation = CABasicAnimation(keyPath: "rotate")
    
    var time = Timer()
    
    var duration : Double?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let this = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let colors = ColorGradient(colors: UIColor.blue.withAlphaComponent(0.0), UIColor.blue)
        lay = LinearGradientLayer(bounds: this, position: center, colors: colors)
        lay.animationDelegate = self
        layer.addSublayer(lay)
    }
    
     public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if let dur = duration {
                applyAnimation(dur)
            } else {
                applyAnimation(1.0)
            }
        }
    }
    
    let kRotationAnimationKey = "com.myapplication.rotationanimationkey"
    
    private func applyAnimation(_ duration: Double) {
        if self.layer.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(Double.pi * 2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            self.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
    }
    
     public func stop(_ remove: Bool) {
        remove ?- stopAndRemove >< justStop
    }
    
    private func stopAndRemove() {
        UIView.animate(withDuration: 0.35, animations: {
            self.alpha = 0
        }) { (v) in
            self.lay.removeAllAnimations()
            self.lay.removeFromSuperlayer()
            self.removeFromSuperview()
        }
    }
    
    private func justStop() {
        UIView.animate(withDuration: 0.35) {
            self.alpha = 0
        }
    }
    
     public func start() {
        lay.animateCircle(duration: duration != nil ? duration! : 1.3, {
            
        })
    }
    
    required  public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
