//
//  SelectorButton.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-05-19.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit


public class SelectorButton: UIButton {
    
    public var currentURLString : String?
    
    open var shouldUseEmptyImage = true
    
    private var urlStringForChecking: String?
    
    private var emptyImage: UIImage?
    
    public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        self.emptyImage = emptyImage
    }
    
    public convenience init(cornerRadius: CGFloat = 0) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        isUserInteractionEnabled = true
    }
    
    public convenience init(cornerRadius: CGFloat = 0, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addTarget(self, action: #selector(handleTap), for: UIControlEvents.touchUpInside)
    }
    
    public convenience init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: emptyImage)
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addTarget(self, action: #selector(handleTap), for: UIControlEvents.touchUpInside)
    }
    
    public convenience init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil, colorScheme : SpotitColorScheme?, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: emptyImage)
        self.tapCallback = tapCallback
        isUserInteractionEnabled = true
        addTarget(self, action: #selector(handleTap), for: UIControlEvents.touchUpInside)
    }
    
    public func handleTap() {
        tapCallback?()
    }
    
    private var tapCallback: (() -> ())?
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


