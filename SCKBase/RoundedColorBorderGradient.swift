//
//  RoundedColorBorderGradient.swift
//  Checkout
//
//  Created by Jean-Louis Murphy on 2017-01-25.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit


extension UIView {
    
    public func gradientBorder(_ withColors : [UIColor],_ inDirection: ContrastSides,_ withRadius: CGFloat?) {
        var radius = CGFloat()
        if let rad = withRadius {
            radius = rad
        } else {
            radius = frame.height / 2
        }
        guard withColors.count > 0 else {
            return
        }
        layer.cornerRadius = radius
        layer.masksToBounds = true
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
        var cgColors = [CGColor]()
        if withColors.count == 1 {
            cgColors.append(withColors[0].cgColor)
            cgColors.append(withColors[0].withAlphaComponent(0).cgColor)
        } else if withColors.count > 1 {
            for color in withColors {
                cgColors.append(color.cgColor)
            }
        }
        var sX = CGFloat()
        var sY = CGFloat()
        var eX = CGFloat()
        var eY = CGFloat()
        switch inDirection {
        case .left:
            sX = 1.0
            sY = 0.5
            eX = 0.0
            eY = 0.5
        case .right:
            sX = 0.0
            sY = 0.5
            eX = 1.0
            eY = 0.5
        case .top:
            sX = 0.5
            sY = 1.0
            eX = 0.5
            eY = 0
        case .bottom:
            sX = 0.5
            sY = 0
            eX = 0.5
            eY = 1
        case .bottomLeft:
            sX = 1.0
            sY = 0.0
            eX = 0.0
            eY = 1.0
        case .bottomRight:
            sX = 0.0
            sY = 0.0
            eX = 1.0
            eY = 1.0
        case .topLeft:
            sX = 1.0
            sY = 1.0
            eX = 0.0
            eY = 0.0
        case .topRight:
            sX = 0.0
            sY = 1.0
            eX = 1.0
            eY = 0.0
        }
        gradient.colors = cgColors
        gradient.startPoint = CGPoint(x: sX, y: sY)
        gradient.endPoint = CGPoint(x: eX, y: eY)
        if withColors.count == 1 || withColors.count == 0 {
            let num = Double((frame.height - radius) / frame.height)
            gradient.locations = [0.7, NSNumber(value: num)] as [NSNumber]?
        } else if withColors.count > 1 {
            var db = [CGFloat]()
            let part : CGFloat = 1 * (1 / CGFloat(withColors.count - 1))
            while db.count < (withColors.count) {
                if db.isEmpty {
                    db.append(0.0)
                } else if db.count == withColors.count {
                    db.append(1.0)
                } else {
                    let num = part * CGFloat(db.count)
                    db.append(num)
                }
            }
            gradient.locations = db as [NSNumber]?
        }
        gradient.backgroundColor = UIColor.clear.cgColor
        let shape = CAShapeLayer()
        shape.lineWidth = 6
        shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        layer.addSublayer(gradient)
    }
    
    public func gradientBorder(_ withColors : [UIColor],_ inDirection: ContrastSides,_ withGradientLayout: [CGFloat], _ withRadius: CGFloat?) {
        var radius = CGFloat()
        if let rad = withRadius {
            radius = rad
        } else {
            radius = frame.height / 2
        }
        guard withColors.count > 0 else {
            return
        }
        layer.cornerRadius = radius
        layer.masksToBounds = true
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
        var cgColors = [CGColor]()
        if withColors.count == 1 {
            cgColors.append(withColors[0].cgColor)
            cgColors.append(withColors[0].withAlphaComponent(0).cgColor)
        } else if withColors.count > 1 {
            for color in withColors {
                cgColors.append(color.cgColor)
            }
        }
        var sX = CGFloat()
        var sY = CGFloat()
        var eX = CGFloat()
        var eY = CGFloat()
        switch inDirection {
        case .left:
            sX = 1.0
            sY = 0.5
            eX = 0.0
            eY = 0.5
        case .right:
            sX = 0.0
            sY = 0.5
            eX = 1.0
            eY = 0.5
        case .top:
            sX = 0.5
            sY = 1.0
            eX = 0.5
            eY = 0
        case .bottom:
            sX = 0.5
            sY = 0
            eX = 0.5
            eY = 1
        case .bottomLeft:
            sX = 1.0
            sY = 0.0
            eX = 0.0
            eY = 1.0
        case .bottomRight:
            sX = 0.0
            sY = 0.0
            eX = 1.0
            eY = 1.0
        case .topLeft:
            sX = 1.0
            sY = 1.0
            eX = 0.0
            eY = 0.0
        case .topRight:
            sX = 0.0
            sY = 1.0
            eX = 1.0
            eY = 0.0
        }
        gradient.colors = cgColors
        gradient.startPoint = CGPoint(x: sX, y: sY)
        gradient.endPoint = CGPoint(x: eX, y: eY)
        if withColors.count == 1 || withColors.count == 0 {
            gradient.locations = [0.8, 0.99] as [NSNumber]?
        } else if withColors.count > 1 {
            var db = [CGFloat]()
            let part : CGFloat = 1 * (1 / CGFloat(withColors.count - 1))
            while db.count < (withColors.count) {
                if db.isEmpty {
                    db.append(0.0)
                } else if db.count == withColors.count {
                    db.append(1.0)
                } else {
                    let num = part * CGFloat(db.count)
                    db.append(num)
                }
            }
            gradient.locations = db as [NSNumber]?
        }
        gradient.locations = withGradientLayout as [NSNumber]?
        gradient.backgroundColor = UIColor.clear.cgColor
        let shape = CAShapeLayer()
        shape.lineWidth = 6
        shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        layer.addSublayer(gradient)
    }
}
