//
//  BaseCell.swift
//  Checkout
//
//  Created by Jean-Louis Murphy on 2016-12-07.
//  Copyright © 2016 Jean-Louis Murphy. All rights reserved.
//

import UIKit

open class BaseCell: UICollectionViewCell {
    
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
