//
//  ArrowButton.swift
//  Checkout
//
//  Created by Jean-Louis Murphy on 2017-01-11.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit



public class ArrowButton: UIButton {
    
    fileprivate enum buttonSide {
        case left, right
    }
    
    var hasArrow = true
    fileprivate var side : buttonSide?
    var arrowLayer = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        side = .left
        print("frame")
        if hasArrow {
            print("frame 2222")
            if side! == .left {
                
                print("frame 22444422")
                leftArrow()
            } else {
                
                print("frame 233333222")
                rightArrow()
            }
            
            print("frame 2-0009222")
        }
    }
    
    func hasArrowRight() {
        hasArrow = true
        side = .right
    }
    
    private func leftArrow() {
        print("left arrow")
        let path = UIBezierPath()
        path.move(to: CGPoint(x: buttonSizes.mainheight * 0.55, y: buttonSizes.mainheight * 0.25))
        path.addLine(to: CGPoint(x: buttonSizes.mainheight * 0.3, y: buttonSizes.mainheight * 0.5))
        path.addLine(to: CGPoint(x: buttonSizes.mainheight * 0.55, y: buttonSizes.mainheight * 0.75))
        
        arrowLayer.frame = bounds
        arrowLayer.path = path.cgPath
        arrowLayer.lineWidth = 2
        arrowLayer.strokeColor = UIColor.white.cgColor
        arrowLayer.fillColor = nil
        arrowLayer.lineJoin = kCALineJoinBevel
        layer.addSublayer(arrowLayer)
    }
    
    private func rightArrow() {
        let path = UIBezierPath()
        let w = frame.width
        path.move(to: CGPoint(x: w - (buttonSizes.mainheight * 0.55), y: buttonSizes.mainheight * 0.25))
        path.addLine(to: CGPoint(x: w - (buttonSizes.mainheight * 0.3), y: buttonSizes.mainheight * 0.5))
        path.addLine(to: CGPoint(x: w - (buttonSizes.mainheight * 0.55), y: buttonSizes.mainheight * 0.75))
       
        arrowLayer.frame = bounds
        arrowLayer.path = path.cgPath
        arrowLayer.lineWidth = 2
        arrowLayer.strokeColor = UIColor.white.cgColor
        arrowLayer.fillColor = nil
        arrowLayer.lineJoin = kCALineJoinBevel
        layer.addSublayer(arrowLayer)
    }
    
    func turnArrowDown() {
        let animationFull : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animationFull.fromValue     = 0
        animationFull.toValue       = -M_PI * 0.5
        animationFull.duration      = 0.5 // this might be too fast
        animationFull.repeatCount   = 0
        animationFull.fillMode = kCAFillModeForwards
        animationFull.isRemovedOnCompletion = false
        arrowLayer.add(animationFull, forKey: "rotation")
        
    }
    
    func turnArrowUp(){
        let animationFull : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animationFull.fromValue     = -M_PI * 0.5
        animationFull.toValue       = 0
        animationFull.duration      = 0.5 // this might be too fast
        animationFull.repeatCount   = 0
        animationFull.fillMode = kCAFillModeForwards
        animationFull.isRemovedOnCompletion = false
        arrowLayer.add(animationFull, forKey: "rotation")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
