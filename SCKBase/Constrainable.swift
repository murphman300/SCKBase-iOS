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
    
    private var emptyImage: UIImage?
    
    public var hasSecondaries: Bool {
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
    
    public convenience init(cornerRadius: CGFloat = 0) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        isUserInteractionEnabled = true
    }
    
    public convenience init(secondaries: Bool, cornerRadius: CGFloat = 0) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        self.hasSecondaries = secondaries
        isUserInteractionEnabled = true
    }
    
    public convenience init(cornerRadius: CGFloat = 0, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        self.hasSecondaries = true
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    public convenience init(secondaries: Bool, cornerRadius: CGFloat = 0, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        self.hasSecondaries = secondaries
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    public convenience init(secondaries: Bool, emptyImage: UIImage? = nil) {
        self.init(cornerRadius: 0, emptyImage: emptyImage)
        self.hasSecondaries = secondaries
    }
    
    public convenience init(secondaries: Bool, emptyImage: UIImage? = nil, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: 0, emptyImage: emptyImage)
        self.hasSecondaries = secondaries
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    public convenience init(secondaries: Bool, cornerRadius: CGFloat, emptyImage: UIImage? = nil, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: emptyImage)
        self.hasSecondaries = secondaries
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        self.emptyImage = emptyImage
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func handleTap() {
        tapCallback?()
    }
    
    private var tapCallback: (() -> ())?
    
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
