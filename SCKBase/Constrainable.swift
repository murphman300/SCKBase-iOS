//
//  Constrainable.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-07-09.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit

protocol Constrainable {
    var block : ConstraintBlock { get set }
}

extension Constrainable where Self : UIView {
    
    internal init(secondaries: Bool) {
        self.init(frame: .zero)
        hasSecondaries = secondaries
    }
    
    
    internal init(frame: CGRect, secondaries: Bool) {
        self.init(frame: frame)
        hasSecondaries = secondaries
    }
    
    internal init(frame: CGRect, cornerRadius: CGFloat, secondaries: Bool) {
        self.init(frame: frame, secondaries: secondaries)
        layer.cornerRadius = cornerRadius
    }
    
    internal init(frame: CGRect, cornerRadius: CGFloat, secondaries: Bool, callBack: (()->())?) {
        self.init(frame: frame, secondaries: secondaries)
        layer.cornerRadius = cornerRadius
    }
    
    internal var hasSecondaries : Bool {
        get {
            guard block.secondaries != nil else {
                return false
            }
            return true
        } set {
            if newValue {
                block.secondaries = ConstraintBlock()
            } else {
                block.secondaries = nil
            }
        }
    }
    
}

open class Label : UILabel, Constrainable {
    
    open var block = ConstraintBlock()
    
    public func activateConstraints() {
        block.activate()
    }
}

open class View : UIView, Constrainable {
    
    open var block = ConstraintBlock()
    
    public func activateConstraints() {
        block.activate()
    }
    
}

open class Button : UIButton, Constrainable {
    
    open var block =  ConstraintBlock()
    
    public func activateConstraints() {
        block.activate()
    }
    
}

open class ImageView : UIImageView, Constrainable {
    
    open var block =  ConstraintBlock()
    
    public func activateConstraints() {
        block.activate()
    }
    
    
}

open class CollectionView : UICollectionView, Constrainable {
    
    open var block = ConstraintBlock()
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        block.secondaries = ConstraintBlock()
    }
    
    public func activateConstraints() {
        block.activate()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
