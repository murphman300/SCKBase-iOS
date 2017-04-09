//
//  ProfileOvalDivider.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-04-09.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit

class profileOvalDivider: UIView {
    
    var shapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        let ellipsePath = UIBezierPath(ovalIn: rect)
        shapeLayer.path = ellipsePath.cgPath
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
}

