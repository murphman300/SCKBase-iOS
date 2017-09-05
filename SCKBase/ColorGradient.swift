//
//  ColorGradient.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-09-04.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit
import CoreGraphics

public extension CGFloat {
    var double : Double {
        return Double(self)
    }
}

public extension Double {
    public var cgFloat : CGFloat {
        return CGFloat(self)
    }
}

public enum PercentageCoordinates {
    
    case noon
    case three
    case six
    case nine
    case other(CGPoint)
    
    public init() {
        self = .nine
    }
    
    public init(value: CGPoint) {
        let t = PercentageCoordinate(rawValue: value)
        if t == PercentageCoordinate.nine {
            self = .nine
        } else if t == PercentageCoordinate.six {
            self = .six
        } else if t == PercentageCoordinate.three {
            self = .three
        } else if t == PercentageCoordinate.noon {
            self = .noon
        } else {
            self = .other(value)
        }
    }
    
}

open class PercentageCoordinate : Equatable {
    
    public typealias StringLiteralType = Swift.String
    
    open var rawValue: CGPoint = .zero
    
    public typealias RawValue = CGPoint
    
    open var x : CGFloat = 0
    
    open var y : CGFloat = 0
    
    public static let noon = PercentageCoordinate(rawValue: CGPoint(x: 0, y: 1))
    public static let three = PercentageCoordinate(rawValue: CGPoint(x: 1, y: 0))
    public static let six = PercentageCoordinate(rawValue: CGPoint(x: 0, y: -1))
    public static let nine = PercentageCoordinate(rawValue: CGPoint(x: -1, y: 0 ))
    
    required public init(rawValue: CGPoint) {
        if rawValue.x <= 1 || rawValue.y <= 1 || rawValue.y >= -1 || rawValue.x >= -1 {
            self.x = rawValue.x
            self.y = rawValue.y
        }
    }
    
    static public func !=(lhs: PercentageCoordinate, rhs: PercentageCoordinate) -> Bool {
        return lhs.x != rhs.x || lhs.y != rhs.y
    }
    
    static public func ==(lhs: PercentageCoordinate, rhs: PercentageCoordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

public extension Int {
    public var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
public extension FloatingPoint {
    public var degreesToRadians: Self { return self * .pi / 180 }
    public var radiansToDegrees: Self { return self * 180 / .pi }
}

open class Percentage {
    
    private var pi = Double.pi
    
    private var circlePI : Double {
        return Double.pi * 2
    }
    
    private var _pastPercent : Double = 0
    
    private var _percent: Double = 0
    
    public var origin : PercentageCoordinates
    
    open var percent : Double {
        return _percent
    }
    
    open var pastPercent : Double {
        return _pastPercent
    }
    
    private var clockwise : Bool = true
    
    required public init() {
        _pastPercent = 0
        _percent = 0
        origin = .nine
    }
    
    convenience public init(value: Int) {
        self.init()
        if value <= 100 {
            let d = Double(value)
            _pastPercent = d
            _percent = d
        }
    }
    
    convenience public init(value: Int, origin: CGPoint) {
        self.init(value: value)
        self.origin = PercentageCoordinates(value: origin)
    }
    
    convenience public init(value: Double) {
        self.init()
        if value <= 1.0 {
            _pastPercent = value
            _percent = value
        }
    }
    
    convenience public init(value: Double, origin: CGPoint) {
        self.init(value: value)
        self.origin = PercentageCoordinates(value: origin)
    }
    
    convenience public init(value: CGFloat) {
        self.init()
        if value <= 1.0 {
            let d = Double(value)
            _pastPercent = d
            _percent = d
        }
    }
    
    convenience public init(value: CGFloat, origin: CGPoint) {
        self.init(value: value)
        self.origin = PercentageCoordinates(value: origin)
    }
    //when Applying an origin of the percentage
    convenience public init(origin: CGPoint, clockwise: Bool) {
        self.init(value: 0.0)
        self.clockwise = clockwise
        self.origin = PercentageCoordinates(value: origin)
    }
    
    private func startFromOriginForEndAngle() -> CGFloat {
        let transition = transitionPercentage.cgFloat
        let start = (_pastPercent * circlePI).cgFloat
        if clockwise {
            switch origin {
            case .noon:
                return (pi / Double(2)).cgFloat + start + transition
            case .three:
                return start + transition
            case .six:
                let new = (pi * Double(3.0)).cgFloat
                return new - (start + transition)
            case .nine:
                return pi.cgFloat + start + transition
            case .other(let point):
                if point.y == 0 {
                    if point.x == 1 {
                        return start + transition
                    } else {
                        return pi.cgFloat + start + transition
                    }
                } else {
                    let tangent = tan(point.x / point.y)
                    return tangent + start + transition
                }
            }
        } else {
            switch origin {
            case .noon:
                return (pi / Double(2)).cgFloat - start - transition
            case .three:
                return start + transition
            case .six:
                let new = (pi * Double(3.0)).cgFloat
                return new - start - transition
            case .nine:
                return pi.cgFloat + start + transition
            case .other(let point):
                if point.y == 0 {
                    if point.x == 1 {
                        return start + transition
                    } else {
                        return pi.cgFloat + start + transition
                    }
                } else {
                    let tangent = tan(point.x / point.y)
                    return tangent + start + transition
                }
            }
        }
    }
    
    public var transitionPercentage : Double {
        return circlePI * (_percent - _pastPercent)
    }
    
    public var startAndEndAngles : (Double,Double) {
        return (circlePI * _pastPercent, circlePI * _percent)
    }
    
    public var cgStartAndEndAngles : (CGFloat,CGFloat) {
        return (CGFloat(circlePI * _pastPercent), CGFloat(circlePI * _percent))
    }
    
    public func modify(_ value: Double) {
        if value > 1.0 || value < 0.0 {
            return
        }
        _pastPercent = _percent
        _percent = value
    }
    
    public func mod(_ value: Double) -> Percentage {
        guard value > 1.0 || value < 0.0 else {
            return self
        }
        _pastPercent = _percent
        _percent = value
        return self
    }
    
}

open class ColorGradient {
    
    open var colors = [UIColor]()
    
    public init(colors: UIColor...) {
        self.colors = colors
    }
    
    open var gradientLayer : CAGradientLayer {
        let l = CAGradientLayer()
        print(colors)
        for c in colors {
            l.colors?.append(c.cgColor as AnyObject)
        }
        return l
    }
    
    open var onlyColors : [CGColor] {
        var cols : [CGColor] = []
        for c in colors {
            cols.append(c.cgColor)
        }
        return cols
    }
    
}

