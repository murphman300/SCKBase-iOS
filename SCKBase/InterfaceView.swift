//
//  InterfaceView.swift
//  Checkout
//
//  Created by Jean-Louis Murphy on 2017-01-15.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit

public class InterfaceView : UIView, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    
    lazy var backbutton : UIButton = {
        var lab = UIButton()
        lab.setTitle("Back", for: .normal)
        lab.setTitleColor(UIColor.white, for: .normal)
        lab.titleLabel?.font = fonts.checkoutMerch
        lab.alpha = 0
        return lab
    }()
    
    var originInputY = CGFloat()
    var displacedInputY = CGFloat()
    
    var loginLab : UILabel = {
        var lab = UILabel()
        lab.textColor = UIColor.white
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 20)
        lab.text = ""
        lab.alpha = 0
        lab.numberOfLines = 0
        return lab
    }()
    
    var subLoginLab : UILabel = {
        var lab = UILabel()
        lab.textColor = UIColor.white
        lab.textAlignment = .center
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        lab.text = ""
        lab.alpha = 0
        lab.numberOfLines = 0
        return lab
    }()
    
    private var stringTag : String?
    
    var getStringTag : String? {
        get {
            guard stringTag != nil else {
                return nil
            }
            return stringTag!
        } set {
            guard stringTag != nil else {
                
                return
            }
        }
    }
    
    var notificationTag : String? {
        get {
            guard stringTag != nil else {
                return nil
            }
            return "\(stringTag!)IsRemovedFromSuperViewSoDeInit"
        } set {
            guard stringTag != nil else {
                return
            }
        }
    }
    
    var canNotifyDeinit = Bool()
    
    var toggleCanNotifyDeinit : Void {
        get {
            return ()
        } set {
            canNotifyDeinit = !canNotifyDeinit
        }
    }
    
    var tap = UITapGestureRecognizer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = "isInterfaceView"
        backgroundColor = UIColor.clear
        initialize()
        isUserInteractionEnabled = true
        tap.addTarget(self, action: #selector(tapDismiss))
        addGestureRecognizer(tap)
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func makeArrow() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: buttonSizes.mainheight * 0.55, y: buttonSizes.mainheight * 0.25))
        path.addLine(to: CGPoint(x: buttonSizes.mainheight * 0.3, y: buttonSizes.mainheight * 0.5))
        path.addLine(to: CGPoint(x: buttonSizes.mainheight * 0.55, y: buttonSizes.mainheight * 0.75))
        let shape = CAShapeLayer()
        shape.frame = backbutton.bounds
        shape.path = path.cgPath
        shape.lineWidth = 2
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = nil
        shape.lineJoin = kCALineJoinBevel
        backbutton.layer.addSublayer(shape)
    }
    
    private func findActiveTextField(subviews : [UIView], textField : inout UITextField?) {
        
        for view in subviews {
            if let tf = view as? UITextField {
                guard !tf.isFirstResponder else {
                    textField = tf; break
                    return
                }
            } else if !subviews.isEmpty {
                findActiveTextField(subviews: view.subviews, textField: &textField)
            }
        }
    }
    
    func findActiveSearchField(subviews : [UIView], textField : inout UISearchBar?) {
        
        for view in subviews {
            if let tf = view as? UISearchBar {
                guard !tf.isFirstResponder else {
                    textField = tf; break
                    return
                }
            } else if !subviews.isEmpty {
                findActiveSearchField(subviews: view.subviews, textField: &textField)
            }
        }
    }
    
    func turnDownArrow() {
        
        for layer in backbutton.layer.sublayers! {
            if let lay = layer as? CAShapeLayer {
                let animationFull : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
                animationFull.fromValue     = 0
                animationFull.toValue       = -M_PI * 0.5
                animationFull.duration      = 0.5 // this might be too fast
                animationFull.repeatCount   = 0
                animationFull.fillMode = kCAFillModeForwards
                animationFull.isRemovedOnCompletion = false
                lay.add(animationFull, forKey: "rotation")
                
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.backbutton.center.x -= self.backbutton.frame.width / 2
                }, completion: {
                    value in
                })
            }
        }
        
    }
    
    func turnUpArrow() {
        
        for layer in backbutton.layer.sublayers! {
            if let lay = layer as? CAShapeLayer {
                let animationFull : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
                animationFull.fromValue     = -M_PI * 0.5
                animationFull.toValue       = 0
                animationFull.duration      = 0.5 // this might be too fast
                animationFull.repeatCount   = 0
                animationFull.fillMode = kCAFillModeForwards
                animationFull.isRemovedOnCompletion = false
                lay.add(animationFull, forKey: "rotation")
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.backbutton.center.x += self.backbutton.frame.width / 2
                }, completion: {
                    value in
                })
            }
        }
    }
    
    func addSubLines(_ views: [UIView], makeLarger: [UIView]?, ref: UIView) {
        for view in views {
            
            let path = UIBezierPath()
            let pathlayer = CAShapeLayer()
            
            path.move(to: CGPoint(x: 0, y: view.frame.height))
            path.addLine(to: CGPoint(x: view.frame.width, y: view.frame.height))
            
            pathlayer.path = path.cgPath
            pathlayer.strokeColor = UIColor.white.cgColor
            pathlayer.lineCap = kCALineCapRound
            pathlayer.lineWidth = 2
            
            view.layer.addSublayer(pathlayer)
            view.tag = 1
        }
        
        guard makeLarger != nil else {return}
        
        for larger in makeLarger! {
            
            let path = UIBezierPath()
            let pathlayer = CAShapeLayer()
            let differ = (ref.frame.width - loginLab.frame.width) / 2
            path.move(to: CGPoint(x: -differ, y: larger.frame.height * 0.8))
            path.addLine(to: CGPoint(x: larger.frame.width + differ, y: larger.frame.height * 0.8))
            
            pathlayer.path = path.cgPath
            pathlayer.strokeColor = UIColor.white.cgColor
            pathlayer.lineWidth = 3
            
            larger.layer.addSublayer(pathlayer)
            larger.tag = 1
        }
    }
    
    override public func removeFromSuperview() {
        super.removeFromSuperview()
        guard canNotifyDeinit else {
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name.init("\(stringTag)IsRemovedFromSuperViewSoDeInit"), object: ["tag":stringTag!])
    }
    
    private func makeStringTag() {
        
        stringTag = UUID().uuidString
        
    }
    
    func tapDismiss() {
        self.endEditing(true)
    }
    
    
    private func initialize() {
        makeStringTag()
        canNotifyDeinit = true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
