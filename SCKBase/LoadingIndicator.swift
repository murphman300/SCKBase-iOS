//
//  LoadingIndicator.swift
//  Spotit
//
//  Created by Jean-Louis Murphy on 2017-04-05.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//


import UIKit
import CoreGraphics

public class LoadingIndicator : UIView, CAAnimationDelegate{
    
    var fillColor : UIColor = UIColor.clear
    var stroke : UIColor = UIColor.clear
    var lineWidth : CGFloat = 1
    var viewCount : Int = 0
    var halfSize = CGFloat()
    var thecenter = CGPoint()
    var factor : CGFloat = 0.2
    var begin = Timer()
    
    //Circle Dimension Values
    var circlePortion = CGFloat()
    var portionUnit = CGFloat()
    var halfCPortion = CGFloat()
    
    //Ripple Vars
    var hasRipple : Bool = false
    
    var rippleColor: UIColor = UIColor.black
    var rippleThickness: Float = 0.5
    var rippleTimer: Float = 1
    var rippleEndScale: Float = 5
    var rippleTrailColor: UIColor = UIColor.clear
    var rippleFillColor = UIColor()
    var animationDuration: TimeInterval = 2.5
    var timer = Timer()
    var originalSize: CGRect?
    
    var view1 = UIView()
    var view2 = UIView()
    var view3 = UIView()
    var view4 = UIView()
    var rect = CGRect()
    
    override init(frame: CGRect) {
        print("B")
        super.init(frame: frame)
        rect = frame
        backgroundColor = UIColor.clear
        
        
        print("C")
    }
    
    override public func draw(_ rect: CGRect) {
        print("A")
        drawRingFittingInsideView()
        print("D")
    }
    
    internal func drawRingFittingInsideView() -> () {
        halfSize = min(bounds.size.width/2, bounds.size.height/2)
        let desiredWidth = lineWidth
        thecenter = CGPoint(x:halfSize, y:halfSize)
        let second = CGPoint(x: halfSize * 0.15, y: halfSize)
        let portionMult = 1 / circlePortion
        portionUnit = portionMult * circlePortion
        halfCPortion = circlePortion / 2
        let circlePath = UIBezierPath(arcCenter: thecenter, radius: CGFloat(halfSize - (lineWidth/2)), startAngle: CGFloat(Double.pi * Double((portionUnit - halfCPortion)/portionUnit)), endAngle: CGFloat(Double.pi * Double((portionUnit + halfCPortion)/portionUnit)), clockwise: false)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = stroke.cgColor
        shapeLayer.lineWidth = desiredWidth
        shapeLayer.lineCap = kCALineCapRound
        layer.addSublayer(shapeLayer)
        if hasRipple {
            initRipple()
        }
        
        guard viewCount != 1 else {
            makeOne()
            return
        }
        guard viewCount != 2 else {
            makeOne()
            makeTwo()
            return
        }
        guard viewCount != 3 else {
            makeOne()
            makeTwo()
            makeThree()
            return
        }
        guard viewCount != 4 else {
            makeOne()
            makeTwo()
            makeThree()
            makeFour()
            return
        }
    }
    
    internal func rotate() -> () {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.1))
    }
    
    func rotateAnimation(check : Bool) -> Bool {
        
        guard check else {
            switch viewCount {
            case 1:
                outerAddAnim()
                oneAddAnim()
            case 2:
                outerAddAnim()
                oneAddAnim()
                twoAddAnim()
            case 3:
                outerAddAnim()
                oneAddAnim()
                twoAddAnim()
                threeAddAnim()
            case 4:
                outerAddAnim()
                oneAddAnim()
                twoAddAnim()
                threeAddAnim()
                fourAddAnim()
            default:
                break
            }
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.alpha = 1
            }, completion: { (finished) in
                
            })
            return true
            
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0
            self.layer.removeAllAnimations()
            self.view1.layer.removeAllAnimations()
            self.view2.layer.removeAllAnimations()
            self.view2.layer.removeAllAnimations()
            self.view4.layer.removeAllAnimations()
        }, completion: { (finished) in
            
        })
        return !check
    }
    
    func chainDelayedRotateAnimation(check : Bool) -> Bool {
        print("A")
        guard check else {
            print("B")
            DispatchQueue.main.async(execute: {
                switch self.viewCount {
                case 1:
                    print("C")
                    self.outerAddAnim()
                    self.perform(#selector(self.oneAddAnim), with: nil, afterDelay: 0.7 * 1)
                    
                case 2:
                    print("D")
                    self.outerAddAnim()
                    self.perform(#selector(self.oneAddAnim), with: nil, afterDelay: 0.7 * 1)
                    self.perform(#selector(self.twoAddAnim), with: nil, afterDelay: 0.7 * 2)
                case 3:
                    print("E")
                    self.outerAddAnim()
                    self.perform(#selector(self.oneAddAnim), with: nil, afterDelay: 0.6 * 1)
                    self.perform(#selector(self.twoAddAnim), with: nil, afterDelay: 0.6 * 2)
                    self.perform(#selector(self.threeAddAnim), with: nil, afterDelay: 0.6 * 3)
                case 4:
                    self.outerAddAnim()
                    self.perform(#selector(self.oneAddAnim), with: nil, afterDelay: 0.6 * 1)
                    self.perform(#selector(self.twoAddAnim), with: nil, afterDelay: 0.6 * 2)
                    self.perform(#selector(self.threeAddAnim), with: nil, afterDelay: 0.6 * 3)
                    self.perform(#selector(self.fourAddAnim), with: nil, afterDelay: 0.6 * 4)
                default:
                    print("F")
                    self.outerAddAnim()
                    break
                }
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    self.alpha = 1
                }, completion: { (finished) in
                })
            })
            return true
            
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0
            self.layer.removeAllAnimations()
            self.view1.layer.removeAllAnimations()
            self.view2.layer.removeAllAnimations()
            self.view2.layer.removeAllAnimations()
            self.view4.layer.removeAllAnimations()
        }, completion: { (finished) in
        })
        return !check
    }
    
    func removeAll(_ completion: @escaping (Bool) -> Void) {
        self.layer.removeAllAnimations()
        self.view1.layer.removeAllAnimations()
        self.view2.layer.removeAllAnimations()
        self.view2.layer.removeAllAnimations()
        self.view4.layer.removeAllAnimations()
        completion(true)
    }
    
    func outerAddAnim() {
        let animationFull : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animationFull.fromValue     = 0
        animationFull.toValue       = 2*Double.pi
        animationFull.duration      = 1.5 // this might be too fast
        animationFull.repeatCount   = Float.infinity
        layer.add(animationFull, forKey: "rotation")
    }
    
    func makeOne() {
        let count : CGFloat = 1
        view1.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        view1.backgroundColor = UIColor.clear
        let thisSize = halfSize * (1 - (count * factor))
        let circlePath = UIBezierPath(arcCenter: thecenter, radius: CGFloat(thisSize - (lineWidth/2)), startAngle: CGFloat(Double.pi * Double((portionUnit - halfCPortion)/portionUnit)), endAngle: CGFloat(Double.pi * Double((portionUnit + halfCPortion)/portionUnit)), clockwise: false)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = stroke.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapRound
        view1.layer.addSublayer(shapeLayer)
        addSubview(view1)
    }
    
    func oneAddAnim() {
        let animationFull : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animationFull.fromValue     = 0
        animationFull.toValue       = 2*Double.pi
        let count : CGFloat = 1
        animationFull.duration      = 1.5 * Double(1 - (count * factor)) // this might be too fast
        animationFull.repeatCount   = Float.infinity
        view1.layer.add(animationFull, forKey: "rotation")
    }
    
    func makeTwo() {
        let count : CGFloat = 2
        view2.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        view2.backgroundColor = UIColor.clear
        let thisSize = halfSize * (1 - (count * factor))
        let circlePath = UIBezierPath(arcCenter: thecenter, radius: CGFloat(thisSize - (lineWidth/2)), startAngle: CGFloat(Double.pi * Double((portionUnit - halfCPortion)/portionUnit)), endAngle: CGFloat(Double.pi * Double((portionUnit + halfCPortion)/portionUnit)), clockwise: false)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = stroke.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapRound
        view2.layer.addSublayer(shapeLayer)
        addSubview(view2)
    }
    
    func twoAddAnim() {
        let animationFull : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animationFull.fromValue = 2*Double.pi
        animationFull.toValue = 0
        let count : CGFloat = 2
        animationFull.duration = 1.5 * Double(1 - (count * (factor + 0.1)))// this might be too fast
        animationFull.repeatCount = Float.infinity
        view2.layer.add(animationFull, forKey: "rotation")
    }
    
    func makeThree() {
        let count : CGFloat = 3
        view3.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        view3.backgroundColor = UIColor.clear
        let thisSize = halfSize * (1 - (count * factor))
        let circlePath = UIBezierPath(arcCenter: thecenter, radius: CGFloat(thisSize - (lineWidth/2)), startAngle: CGFloat(Double.pi * Double((portionUnit - halfCPortion)/portionUnit)), endAngle: CGFloat(Double.pi * Double((portionUnit + halfCPortion)/portionUnit)), clockwise: false)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = stroke.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapRound
        view3.layer.addSublayer(shapeLayer)
        addSubview(view3)
    }
    
    func threeAddAnim() {
        let animationFull : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animationFull.fromValue     = 2*Double.pi
        animationFull.toValue       = 0
        let count : CGFloat = 3
        animationFull.duration      = 1.5 * Double(1 - (count * (factor + 0.2))) // this might be too fast
        animationFull.repeatCount   = Float.infinity
        view3.layer.add(animationFull, forKey: "rotation")
    }
    
    func makeFour() {
        let count : CGFloat = 4
        view4.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        view4.backgroundColor = UIColor.clear
        let thisSize = halfSize * (1 - (count * factor))
        let circlePath = UIBezierPath(arcCenter: thecenter, radius: CGFloat(thisSize - (lineWidth/2)), startAngle: CGFloat(.pi * Double((portionUnit - halfCPortion)/portionUnit)), endAngle: CGFloat(Double.pi * Double((portionUnit + halfCPortion)/portionUnit)), clockwise: false)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = stroke.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapRound
        view4.layer.addSublayer(shapeLayer)
        addSubview(view4)
    }
    
    func fourAddAnim() {
        let animationFull : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animationFull.fromValue = 0
        animationFull.toValue = 2 * Double.pi
        let count : CGFloat = 4
        animationFull.duration      = 1.5 * Double(1 - (count * (factor + 0.3))) // this might be too fast
        animationFull.repeatCount   = Float.infinity
        view4.layer.add(animationFull, forKey: "rotation")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }
    
    func initRipple() {
        
        self.originalSize = rect
        self.rippleFillColor = stroke
        self.rippleColor = stroke
        self.rippleTimer = 1.5
        self.rippleThickness = Float((self.originalSize?.width)! / 3)
        self.drawWithFrame(frame: rect)
        
        let maxSize = min(frame.width, frame.height)
        self.rippleEndScale = Float(maxSize - (self.originalSize?.width)!) / Float(self.frame.width)
        
    }
    
    func continuousRipples() {
        let pathFrame: CGRect = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        let path = UIBezierPath(roundedRect: pathFrame, cornerRadius: self.frame.size.height)
        let shapePosition = self.convert(self.center, from: nil)
        
        let circleShape = CAShapeLayer()
        circleShape.path = path.cgPath
        circleShape.position = shapePosition
        circleShape.fillColor = self.fillColor.cgColor
        circleShape.opacity = 0
        circleShape.zPosition = -1
        circleShape.strokeColor = self.rippleColor.cgColor
        circleShape.lineWidth = CGFloat(self.rippleThickness)
        
        self.layer.addSublayer(circleShape)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = NSValue(caTransform3D:CATransform3DMakeScale(CGFloat(self.rippleEndScale), 1, 1))
        scaleAnimation.toValue = NSValue(caTransform3D:CATransform3DIdentity)
        let alphaAnimation = CABasicAnimation(keyPath:"opacity")
        alphaAnimation.fromValue = 1
        alphaAnimation.toValue = 0
        
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, alphaAnimation]
        animation.duration = self.animationDuration
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        circleShape.add(animation, forKey:nil)
        
    }
    
    func drawWithFrame(frame: CGRect) {
        self.timer = Timer.scheduledTimer(timeInterval: Double(self.rippleTimer), target: self, selector: #selector(continuousRipples), userInfo: nil, repeats: true)
    }
}
