//
//  BaseCell.swift
//  Checkout
//
//  Created by Jean-Louis Murphy on 2016-12-07.
//  Copyright © 2016 Jean-Louis Murphy. All rights reserved.
//

import UIKit


public protocol LoadingInterfacer {
    typealias loadingCallbackUIComponent = (() -> ())?
    typealias loadedCallbackUIComponent = (() -> ())?
    func fetching(completionHandler: () -> ())
}

enum BaseCellLoader : LoadingInterfacer {
    
    case loading(execute: loadingCallbackUIComponent?)
    
    case loaded(execute: loadedCallbackUIComponent?)
    
    func fetching(completionHandler: () -> ()) {
        switch self {
        case .loaded(execute: let callback):
            callback()
        case .loading(execute: let callback):
            callback()
            
        }
    }
    
}



open class BaseCell: UICollectionViewCell {
    
    
    public func asLoading() {
        
    }
    
    public func finishedLoading() {
        loadingCallbackUIComponent?()
    }
    
    private var loadingCallbackUIComponent: (() -> ())?
    
    public var loadingCallback : (() -> ())? {
        get {
            return loadingCallbackUIComponent
        } set {
            loadingCallbackUIComponent = newValue
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    open func setupViews(){
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
