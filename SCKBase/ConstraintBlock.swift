//
//  ConstraintBlock.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-07-09.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit


enum ConstraintToggleState : Int {
    case primary = 0
    case secondary = 1
    case none = 2
    
    init() {
        guard let this = ConstraintToggleState(rawValue: 2) else {
            self = ConstraintToggleState(rawValue: 1)!
            return
        }
        self = this
    }
    
    mutating public func mutate() {
        if self.rawValue == 0, let new = ConstraintToggleState(rawValue: 1) {
            self = new
        } else if self.rawValue == 1 && self.rawValue == 2, let new = ConstraintToggleState(rawValue: 0) {
            self = new
        }
    }
    
    mutating public func mutate(_ completion : @escaping (_ this: ConstraintToggleState) -> Void) {
        if self.rawValue == 0, let new = ConstraintToggleState(rawValue: 1) {
            self = new
        } else if self.rawValue == 1 && self.rawValue == 2, let new = ConstraintToggleState(rawValue: 0) {
            self = new
        }
        completion(self)
    }
}

public class ConstraintBlock : NSObject {
    
    /*
     The constraint sides here
    */
    open var topConstraint: NSLayoutConstraint?
    open var bottomConstraint: NSLayoutConstraint?
    open var leftConstraint: NSLayoutConstraint?
    open var rightConstraint: NSLayoutConstraint?
    open var heightConstraint: NSLayoutConstraint?
    open var widthConstraint: NSLayoutConstraint?
    
    //Allows for a better integration of transitions between two states of constraints
    open var secondaries : ConstraintBlock?
    
    open var primary : (()->())?
    open var secondary : (()->())?
    
    private var toggleBoth = Bool()
    private var toggledState = ConstraintToggleState()
    
    open var primaryAndSecondaryCanToggle : Bool {
        get {
            guard primary != nil else { return false }
            guard secondary != nil else { return false }
            return toggleBoth
        } set {
            guard primary != nil else { return }
            guard secondary != nil else { return }
            toggleBoth = newValue
        }
    }
    
    public func toggle() {
        toggledState.mutate({ (this) in
            switch this {
            case .primary :
                self.performMain()
            case .secondary :
                self.performSecondary()
            case .none :
                return
            }
        })
    }
    
    public func performMain() {
        guard let it = primary else { return }
        it()
    }
    
    public func performSecondary() {
        guard let it = secondary else { return }
        it()
    }
    
    public func toggle(_ constraint: ConstraintSide) {
        switch constraint {
        case .top :
            if let top = topConstraint {
                top.isActive = !top.isActive
            }
        case .bottom :
            if let bottom = bottomConstraint {
                bottom.isActive = !bottom.isActive
            }
        case .left :
            if let left = leftConstraint {
                left.isActive = !left.isActive
            }
        case .right :
            if let right = rightConstraint {
                right.isActive = !right.isActive
            }
        case .width :
            if let width = widthConstraint {
                width.isActive = !width.isActive
            }
        case .height :
            if let height = heightConstraint {
                height.isActive = !height.isActive
            }
        }
    }
    
    public func activate() {
        
        for item in ConstraintSide.all() {
            toggle(item)
        }
        
    }
    
    open var block : Bool = true
    
    public func switchState(_ constraint: ConstraintSide) {
        switch constraint {
        case .top :
            guard let secondary = secondaries else {
                toggleHandler(constraint, topConstraint, nil)
                return
            }
            toggleHandler(constraint, topConstraint, secondary.topConstraint)
        case .bottom :
            guard let secondary = secondaries else {
                toggleHandler(constraint, bottomConstraint, nil)
                return
            }
            toggleHandler(constraint, bottomConstraint, secondary.bottomConstraint)
        case .left :
            guard let secondary = secondaries else {
                toggleHandler(constraint, leftConstraint, nil)
                return
            }
            toggleHandler(constraint, leftConstraint, secondary.leftConstraint)
        case .right :
            guard let secondary = secondaries else {
                toggleHandler(constraint, rightConstraint, nil)
                return
            }
            toggleHandler(constraint, rightConstraint, secondary.rightConstraint)
        case .width :
            guard let secondary = secondaries else {
                toggleHandler(constraint, widthConstraint, nil)
                return
            }
            toggleHandler(constraint, widthConstraint, secondary.widthConstraint)
            
        case .height :
            guard let secondary = secondaries else {
                toggleHandler(constraint, heightConstraint, nil)
                return
            }
            toggleHandler(constraint, heightConstraint, secondary.heightConstraint)
        }
        block = !block
    }
    
    public func switchStates(_ first: ConstraintSide,_ second: ConstraintSide?) {
        if let sec = second {
            if let v1 = returnConstraint(first) {
                v1.isActive = !v1.isActive
            }
            if let v2 = returnConstraint(sec) {
                v2.isActive = !v2.isActive
            } else if let others = secondaries, let v2a = others.returnConstraint(sec) {
                v2a.isActive = !v2a.isActive
            }
        } else {
            switchState(first)
        }
    }
    
    public func toggle(_ constraints : ConstraintSide...) {
        for item in constraints {
            if let t = returnConstraint(item) {
                t.isActive = !t.isActive
            }
        }
    }
    
    public func returnConstraint(_ constraint : ConstraintSide) -> NSLayoutConstraint? {
        switch constraint {
        case .top :
            return topConstraint
        case .bottom :
            return bottomConstraint
        case .left :
            return leftConstraint
        case .right :
            return rightConstraint
        case .width :
            return widthConstraint
        case .height :
            return heightConstraint
        }
    }
    
    private func toggleHandler(_ constraint: ConstraintSide,_ first: NSLayoutConstraint?,_ secondary: NSLayoutConstraint?) {
        guard let second = secondary else {
            toggle(constraint)
            return
        }
        guard block else {
            return
        }
        block = !block
        if let top = first {
            if (top.isActive && !second.isActive) {
                top.isActive = !top.isActive
                second.isActive = !second.isActive
            } else if (!top.isActive && second.isActive){
                second.isActive = !second.isActive
                top.isActive = !top.isActive
            } else {
                top.isActive = true
            }
        } else {
            print("top Constraint is not active")
        }
    }
}

