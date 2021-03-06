//
//  LinearGradientLayer.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-09-04.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit


open class LinearGradientLayer: CALayer, CAAnimationDelegate {
    
    private var startValue: CGFloat = 0.01
    
    open var animationDelegate : CAAnimationDelegate?
    
    open var lineWidth : CGFloat = 10
    
    open var circumference : CGFloat = 0
    
    open var lineRatio : CGFloat = 0
    
    override public init(){
        super.init()
    }
    
    convenience public init(bounds: CGRect, position: CGPoint, colors: ColorGradient) {
        self.init()
        self.bounds = bounds
        self.position = position
        let cols = colors.colors
        print(cols)
        let colors : [UIColor] = self.graint(fromColor: cols[0], toColor: cols[1], count: 4)
        lineWidth = lineWidth > bounds.height * 0.1 ? (bounds.height * 0.1 > 6 ? 6 : bounds.height * 0.1) : lineWidth
        print(colors.count)
        for i in 0..<colors.count-1 {
            let graint = CAGradientLayer()
            graint.bounds = CGRect(origin:CGPoint(x: 0, y: 0), size: CGSize(width:bounds.width/2,height:bounds.height/2))
            let valuePoint = self.positionArrayWith(bounds: self.bounds)[i]
            graint.position = valuePoint
            let fromColor = colors[i]
            let toColor = colors[i+1]
            let colors : [CGColor] = [fromColor.cgColor,toColor.cgColor]
            let stopOne: CGFloat = 0.0
            let stopTwo: CGFloat = 1.0
            let locations : [CGFloat] = [stopOne,stopTwo]
            graint.colors = colors
            graint.locations = locations as [NSNumber]?
            graint.startPoint = self.startPoints()[i]
            graint.endPoint = self.endPoints()[i]
            self.addSublayer(graint)
            let shapelayer = CAShapeLayer()
            let rect = CGRect(origin:CGPoint(x: 0, y: 0),size:CGSize(width:self.bounds.width - 2 * lineWidth,height: self.bounds.height - 2 * lineWidth))
            shapelayer.bounds = rect
            shapelayer.position = CGPoint(x:self.bounds.width/2,y: self.bounds.height/2)
            shapelayer.strokeColor = UIColor.blue.cgColor
            shapelayer.fillColor = UIColor.clear.cgColor
            shapelayer.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.width/2).cgPath
            shapelayer.lineWidth = lineWidth
            shapelayer.lineCap = kCALineCapRound
            circumference = (2 * Double.pi).cgFloat * (rect.width / 2)
            lineRatio = (lineWidth) / circumference
            shapelayer.strokeStart = lineRatio/2
            shapelayer.strokeEnd = 0.0
            self.mask = shapelayer
        }
    }
    
    internal func actualRatiofromCircumference(_ ratio: CGFloat) -> CGFloat {
        if ratio > 1.0 {
            return (circumference - (lineWidth / 2)) / circumference
        } else {
            return ((circumference - (lineWidth / 2)) / circumference) * ratio
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func layerWithWithBounds(bounds:CGRect, position:CGPoint, colors: ColorGradient, linewidth : CGFloat,toValue:CGFloat) -> LinearGradientLayer {
        let layer = LinearGradientLayer(bounds: bounds, position: position, colors: colors)
        return layer
    }
    
    internal func graint(fromColor:UIColor, toColor:UIColor, count:Int) -> [UIColor] {
        var fromR : CGFloat = 0.0, fromG : CGFloat = 0.0, fromB : CGFloat = 0.0, fromAlpha : CGFloat = 0.0
        fromColor.getRed(&fromR,green: &fromG,blue: &fromB,alpha: &fromAlpha)
        var toR : CGFloat = 0.0, toG : CGFloat = 0.0, toB : CGFloat = 0.0, toAlpha : CGFloat = 0.0
        toColor.getRed(&toR,green: &toG,blue: &toB,alpha: &toAlpha)
        var result : [UIColor]! = [UIColor]()
        for i in 0...count {
            let oneR:CGFloat = fromR + (toR - fromR)/CGFloat(count) * CGFloat(i)
            let oneG : CGFloat = fromG + (toG - fromG)/CGFloat(count) * CGFloat(i)
            let oneB : CGFloat = fromB + (toB - fromB)/CGFloat(count) * CGFloat(i)
            let oneAlpha : CGFloat = fromAlpha + (toAlpha - fromAlpha)/CGFloat(count) * CGFloat(i)
            let oneColor = UIColor.init(red: oneR, green: oneG, blue: oneB, alpha: oneAlpha)
            result.append(oneColor)
        }
        return result
    }
    
    internal func positionArrayWith(bounds:CGRect) -> [CGPoint]{
        let first = CGPoint(x:(bounds.width/4)*3, y: (bounds.height/4)*1)
        let second = CGPoint(x:(bounds.width/4)*3, y: (bounds.height/4)*3)
        let third = CGPoint(x:(bounds.width/4)*1, y: (bounds.height/4)*3)
        let fourth = CGPoint(x:(bounds.width/4)*1, y: (bounds.height/4)*1)
        return [first,second,third,fourth]
    }
    
    internal func startPoints() -> [CGPoint] {
        return [CGPoint.zero,CGPoint(x:1,y:0),CGPoint(x:1,y:1),CGPoint(x:0,y:1)]
    }
    
    internal func endPoints() -> [CGPoint] {
        return [CGPoint(x:1,y:1),CGPoint(x:0,y:1),CGPoint.zero,CGPoint(x:1,y:0)]
    }
    
    internal func midColorWithFromColor(fromColor:UIColor, toColor:UIColor, progress:CGFloat) -> UIColor {
        var fromR:CGFloat = 0.0,fromG:CGFloat = 0.0,fromB:CGFloat = 0.0,fromAlpha:CGFloat = 0.0
        fromColor.getRed(&fromR,green: &fromG,blue: &fromB,alpha: &fromAlpha)
        var toR:CGFloat = 0.0,toG:CGFloat = 0.0,toB:CGFloat = 0.0,toAlpha:CGFloat = 0.0
        toColor.getRed(&toR,green: &toG,blue: &toB,alpha: &toAlpha)
        let oneR = fromR + (toR - fromR) * progress
        let oneG = fromG + (toG - fromG) * progress
        let oneB = fromB + (toB - fromB) * progress
        let oneAlpha = fromAlpha + (toAlpha - fromAlpha) * progress
        let oneColor = UIColor.init(red: oneR, green: oneG, blue: oneB, alpha: oneAlpha)
        return oneColor
    }
    
    public func animateCircle(duration: TimeInterval) {
        animateCircleTo(duration: duration, toValue: 0.99)
    }
    
    public func animateCircle(duration: TimeInterval,_ completion: (()->())?) {
        animateCircleTo(duration: duration, toValue: 0.99)
    }
    
    open var tempValue : CGFloat?
    
    open var animationTime : Double = 1.5
    
    public func animateCircleTo(duration: TimeInterval, toValue: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.isRemovedOnCompletion = true
        animation.duration = duration
        animation.fromValue = startValue
        let new = actualRatiofromCircumference(toValue)
        animation.toValue = new
        animation.delegate = self
        let circleMask = self.mask as! CAShapeLayer
        circleMask.strokeEnd = new
        circleMask.removeAllAnimations()
        circleMask.add(animation, forKey: "strokeEnd")
        startValue = new
    }
    
    public func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let d = self.animationDelegate {
            d.animationDidStop!(anim, finished: flag)
        }
    }
    
}

