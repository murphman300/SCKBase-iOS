//
//  Constrainable.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-07-09.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit

public protocol Constrainable {
    var block : ConstraintBlock { get set }
    init(secondaries: Bool)
    init(frame: CGRect, secondaries: Bool)
    init(frame: CGRect, cornerRadius: CGFloat, secondaries: Bool)
    init(frame: CGRect, cornerRadius: CGFloat, secondaries: Bool, callBack: (()->())?)
    func activateConstraints()
}

extension Constrainable where Self : UIView {
    
    public init(secondaries: Bool) {
        self.init(frame: .zero)
        hasSecondaries = secondaries
    }
    
    
    public init(frame: CGRect, secondaries: Bool) {
        self.init(frame: frame)
        hasSecondaries = secondaries
    }
    
    public init(frame: CGRect, cornerRadius: CGFloat, secondaries: Bool) {
        self.init(frame: frame, secondaries: secondaries)
        layer.cornerRadius = cornerRadius
    }
    
    public init(frame: CGRect, cornerRadius: CGFloat, secondaries: Bool, callBack: (()->())?) {
        self.init(frame: frame, secondaries: secondaries)
        layer.cornerRadius = cornerRadius
    }
    
    
    public func activateConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        block.activate()
    }
    
    public var hasSecondaries : Bool {
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
    
}

open class View : UIView, Constrainable {
    
    open var block = ConstraintBlock()
    
}

open class Button : UIButton, Constrainable {
    
    open var block =  ConstraintBlock()
    
}

open class ImageView : UIImageView, Constrainable {
    
    open var block =  ConstraintBlock()
    
}

open class CollectionView : UICollectionView, Constrainable {
    
    open var block = ConstraintBlock()
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        block.secondaries = ConstraintBlock()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
