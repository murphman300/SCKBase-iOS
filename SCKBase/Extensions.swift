//
//  Extensions.swift
//  Spotit
//
//  Created by Jean-Louis Murphy on 2016-08-25.
//  Copyright © 2016 Jean-Louis Murphy. All rights reserved.
//

import UIKit
import CoreLocation



extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
        var coreImageColor: CIColor {
            return CIColor(color: self)
        }
        var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            let color = coreImageColor
            return (color.red, color.green, color.blue, color.alpha)
        }
}

extension UIView {
    
    func rotate(_ dur: CFTimeInterval,_ completion: CAAnimationDelegate?) {
        
        
        
        let rotateAnim = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnim.fromValue = 0.0
        rotateAnim.toValue = CGFloat(Double.pi)
        rotateAnim.duration = dur
        
        if let del = completion {
            rotateAnim.delegate = del
        }
        
        self.layer.add(rotateAnim, forKey: nil)
    }
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    
    func roundCorners(_ corner: UIRectCorner,_ radii: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.layer.bounds
        maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii)).cgPath
        
        self.layer.mask = maskLayer
        layer.masksToBounds = true
    }
    
    func ovalView(_ mult: CGFloat) {
        
        layer.cornerRadius = mult * (self.frame.height * 2)
        layer.masksToBounds = true
    }
    
    func clearViu() {
        
        if let window = UIApplication.shared.keyWindow {
            frame = CGRect(x: 0, y: 0, width: (window.frame.width), height: (window.frame.height))
            alpha = 0
            backgroundColor = colors.clearViu
            
        }
        
    }
    
    func sideCircleView(_ value: CGFloat?) {
        
        if let radius = value {
            
            layer.cornerRadius = radius//0.5 * frame.height
            layer.masksToBounds = true
        } else {
            
            layer.cornerRadius = 0.5 * frame.height
            layer.masksToBounds = true
        }
        
    }
    
    func sideCircleViewWithConstraints(_ height: CGFloat?) {
        
        if let radius = height {
            
            layer.cornerRadius = radius * 0.5
            layer.masksToBounds = true
        } else {
            
            layer.cornerRadius = 0.5 * frame.height
            layer.masksToBounds = true
        }
        
    }
    
    func backgroundWith(_ contrasts: [ContrastBackground]) {
        var ind : Int = 0
        for contrast in contrasts {
            contrastBackGround((contrast.side?.toContrast())!, contrast.fadeFrom, contrast.toColor, contrast.fadeAt, ind)
            ind += 1
        }
    }
    
    func contrastBackGround(_ startFrom: contrastSides,_ fadeFrom: UIColor,_ toColor: UIColor,_ fadeAt: [CGFloat],_ atIndex: Int) {
        var x = CGFloat()
        var y = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        var sX = CGFloat()
        var sY = CGFloat()
        var eX = CGFloat()
        var eY = CGFloat()
        x = 0
        y = 0
        width = frame.width
        height = frame.height
        switch startFrom {
        case .left:
            sX = 1.0
            sY = 0.5
            eX = 0
            eY = 0.5
        case .right:
            sX = 0
            sY = 0.5
            eX = 1.0
            eY = 0.5
        case .top:
            sX = 0.5
            sY = 0.0
            eX = 0.5
            eY = 1.0
        case .bottom:
            sX = 0.5
            sY = 1.0
            eX = 0.5
            eY = 0.0
        case .bottomLeft:
            sX = 0.0
            sY = 1.0
            eX = 1.0
            eY = 0.0
        case .bottomRight:
            sX = 1.0
            sY = 1.0
            eX = 0.0
            eY = 0.0
        case .topLeft:
            sX = 0.0
            sY = 0.0
            eX = 1.0
            eY = 1.0
        case .topRight:
            sX = 1.0
            sY = 0.0
            eX = 0.0
            eY = 1.0
            
        }
        
        
        let shadowBorder = CAGradientLayer()
        shadowBorder.frame = CGRect(x: x, y: y, width: width, height: height)
        let color1 = fadeFrom.cgColor as CGColor
        let color2 = toColor.cgColor as CGColor
        shadowBorder.colors = [color1, color2]
        shadowBorder.startPoint = CGPoint(x: sX, y: sY)
        shadowBorder.endPoint = CGPoint(x: eX, y: eY)
        shadowBorder.locations = fadeAt as [NSNumber]?
        layer.insertSublayer(shadowBorder, at: UInt32(atIndex))
        
    }
    
    func contrastBackGround(_ startFrom: contrastSides,_ fadeFrom: UIColor,_ toColor: UIColor,_ fadeAt: [CGFloat]) {
        var x = CGFloat()
        var y = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        var sX = CGFloat()
        var sY = CGFloat()
        var eX = CGFloat()
        var eY = CGFloat()
        x = 0
        y = 0
        width = frame.width
        height = frame.height
        switch startFrom {
        case .left:
            sX = 1.0
            sY = 0.5
            eX = 0
            eY = 0.5
        case .right:
            sX = 0
            sY = 0.5
            eX = 1.0
            eY = 0.5
        case .top:
            sX = 0.5
            sY = 0.0
            eX = 0.5
            eY = 1.0
        case .bottom:
            sX = 0.5
            sY = 1.0
            eX = 0.5
            eY = 0.0
        case .bottomLeft:
            sX = 0.0
            sY = 1.0
            eX = 1.0
            eY = 0.0
        case .bottomRight:
            sX = 1.0
            sY = 1.0
            eX = 0.0
            eY = 0.0
        case .topLeft:
            sX = 0.0
            sY = 0.0
            eX = 1.0
            eY = 1.0
        case .topRight:
            sX = 1.0
            sY = 0.0
            eX = 0.0
            eY = 1.0
            
        }
        
        
        let shadowBorder = CAGradientLayer()
        shadowBorder.frame = CGRect(x: x, y: y, width: width, height: height)
        let color1 = fadeFrom.cgColor as CGColor
        let color2 = toColor.cgColor as CGColor
        shadowBorder.colors = [color1, color2]
        shadowBorder.startPoint = CGPoint(x: sX, y: sY)
        shadowBorder.endPoint = CGPoint(x: eX, y: eY)
        shadowBorder.locations = fadeAt as [NSNumber]?
        layer.insertSublayer(shadowBorder, at: 0)
        
    }
    
    func contrastBackGroundForViewWithConstraints(_ startFrom: ContrastSides,_ fadeFrom: UIColor,_ toColor: UIColor,_ fadeAt: [CGFloat],_ h: CGFloat,_ w: CGFloat) {
        var x = CGFloat()
        var y = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        var sX = CGFloat()
        var sY = CGFloat()
        var eX = CGFloat()
        var eY = CGFloat()
        x = 0
        y = 0
        width = w
        height = h
        switch startFrom {
        case .left:
            sX = 0.0
            sY = 0.5
            eX = 1
            eY = 0.5
        case .right:
            sX = 1
            sY = 0.5
            eX = 0.0
            eY = 0.5
        case .top:
            sX = 0.5
            sY = 0
            eX = 0.5
            eY = 1
        case .bottom:
            sX = 0.5
            sY = 1.0
            eX = 0.5
            eY = 0
        case .bottomLeft:
            sX = 0.0
            sY = 1.0
            eX = 1.0
            eY = 0.0
        case .bottomRight:
            sX = 1.0
            sY = 1.0
            eX = 0.0
            eY = 0.0
        case .topLeft:
            sX = 0.0
            sY = 0.0
            eX = 1.0
            eY = 1.0
        case .topRight:
            sX = 1.0
            sY = 0.0
            eX = 0.0
            eY = 1.0
            
        }
        
        
        let shadowBorder = CAGradientLayer()
        shadowBorder.frame = CGRect(x: x, y: y, width: width, height: height)
        let color1 = fadeFrom.cgColor as CGColor
        let color2 = toColor.cgColor as CGColor
        shadowBorder.colors = [color1, color2]
        shadowBorder.startPoint = CGPoint(x: sX, y: sY)
        shadowBorder.endPoint = CGPoint(x: eX, y: eY)
        shadowBorder.locations = fadeAt as [NSNumber]?
        layer.insertSublayer(shadowBorder, at: 0)
        
    }
    
    func addShadow(_ side: viewSides) {
        var x = CGFloat()
        var y = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        var sX = CGFloat()
        var sY = CGFloat()
        var eX = CGFloat()
        var eY = CGFloat()
        
        switch side {
        case .left:
            x = -5
            y = 0
            width = 5
            height = frame.height
            sX = 1.0
            sY = 0.5
            eX = 0
            eY = 0.5
        case .right:
            x = frame.width
            y = 0
            width = 5
            height = frame.height
            sX = 0
            sY = 0.5
            eX = 1.0
            eY = 0.5
        case .top:
            x = 0
            y = -5
            width = frame.width
            height = 5
            sX = 0.5
            sY = 1.0
            eX = 0.5
            eY = 0.0
        case .bottom:
            x = 0
            y = frame.height
            width = frame.width
            height = 5
            sX = 0.5
            sY = 0.0
            eX = 0.5
            eY = 1.0
        }
    
        let shadowBorder = CAGradientLayer()
        shadowBorder.frame = CGRect(x: x, y: y, width: width, height: height)
        let color1 = UIColor.black.withAlphaComponent(0.4).cgColor as CGColor
        let color2 = UIColor.clear.cgColor as CGColor
        shadowBorder.colors = [color1, color2]
        shadowBorder.startPoint = CGPoint(x: sX, y: sY)
        shadowBorder.endPoint = CGPoint(x: eX, y: eY)
        shadowBorder.locations = [0, 0.3]
        layer.addSublayer(shadowBorder)
        
    }
    
    func addSolidBorder(_ side: viewSides, _ color: UIColor){
        var x = CGFloat()
        var y = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        
        
        switch side {
        case .left:
            x = 0
            y = 0
            width = 0.5
            height = frame.height
           
        case .right:
            x = frame.width
            y = 0
            width = 0.5
            height = frame.height
            
        case .top:
            x = 0
            y = 0
            width = frame.width
            height = 0.5
            
        case .bottom:
            x = 0
            y = frame.height - 0.5
            width = frame.width
            height = 0.5
            
        }
        
        let botBorder = CALayer()
        botBorder.frame = CGRect(x: x, y: y, width: width, height: height)
        botBorder.backgroundColor = color.cgColor
        layer.addSublayer(botBorder)
        
    }
    
    func addSolidBorderForViewWithConstraints(_ side: viewSides, _ color: UIColor,_ desiredHeight: CGFloat,_ desiredWidth: CGFloat?){
        var x = CGFloat()
        var y = CGFloat()
        var contWidth = CGFloat()
        var contHeight = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        let theWidth : CGFloat = 0.35
        
        if frame.width == 0 && frame.height == 0 {
            if let w = desiredWidth {
                contWidth = w
            } else {
                
                contWidth = screen.width
            }
            contHeight = desiredHeight
            
            switch side {
            case .left:
                x = 0
                y = 0
                width = theWidth
                height = contHeight
                
            case .right:
                x = contWidth
                y = 0
                width = theWidth
                height = contHeight
                
            case .top:
                x = 0
                y = -theWidth
                width = contWidth
                height = 0.5
                
            case .bottom:
                x = 0
                y = contHeight - theWidth
                width = contWidth
                height = theWidth
                
            }
            
        } else {
            switch side {
            case .left:
                x = 0
                y = 0
                width = 0.5
                height = frame.height
                
            case .right:
                x = frame.width
                y = 0
                width = 0.5
                height = frame.height
                
            case .top:
                x = 0
                y = 0
                width = frame.width
                height = 0.5
                
            case .bottom:
                x = 0
                y = frame.height - 0.5
                width = frame.width
                height = 0.5
                
            }
            
        }
        
        
        
        
        
        
        let botBorder = CALayer()
        botBorder.frame = CGRect(x: x, y: y, width: width, height: height)
        botBorder.backgroundColor = color.cgColor
        layer.insertSublayer(botBorder, above: layer)
        
    }
    
    func addSolidNavBorder(_ side: viewSides, _ color: UIColor){
        var x = CGFloat()
        var y = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        let value : CGFloat = 0.73439
        
        switch side {
        case .left:
            x = 0
            y = 0
            width = value
            height = frame.height
            
        case .right:
            x = frame.width
            y = 0
            width = value
            height = frame.height
            
        case .top:
            x = 0
            y = 0
            width = frame.width
            height = value
            
        case .bottom:
            x = 0
            y = frame.height - value
            width = frame.width
            height = value
            
        }
        
        let botBorder = CALayer()
        botBorder.frame = CGRect(x: x, y: y, width: width, height: height)
        botBorder.backgroundColor = color.cgColor
        layer.addSublayer(botBorder)
        
    }
    
    func addSolidCellBorder(_ side: viewSides, _ color: UIColor,_ percentOfWidth: CGFloat){
        var x = CGFloat()
        var y = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        let value : CGFloat = cells.chatcellBorder
        
        switch side {
        case .top:
            x = frame.width * (1 - percentOfWidth)
            y = 0
            width = frame.width * percentOfWidth
            height = value
            
        case .bottom:
            x = frame.width * (1 - percentOfWidth)
            y = frame.height
            width = frame.width * percentOfWidth
            height = value
        default:
            break
            
        }
        
        let botBorder = CALayer()
        botBorder.frame = CGRect(x: x, y: y, width: width, height: height)
        botBorder.backgroundColor = color.cgColor
        layer.addSublayer(botBorder)
    }
    
    func addCircleShadowToShadowContainer(_ size: CGFloat) {
        
        let shadowBorder = CAGradientLayer()
        shadowBorder.frame = CGRect(x: 0, y: 0, width: size, height: size)
        shadowBorder.cornerRadius = 0.5 * shadowBorder.bounds.size.width
        let color1 = UIColor.black.withAlphaComponent(0.3).cgColor as CGColor
        let color2 = UIColor.clear.cgColor as CGColor
        shadowBorder.colors = [color1, color2]
        shadowBorder.startPoint = CGPoint(x: 0.5, y: 1.0)
        shadowBorder.endPoint = CGPoint(x: 0.5, y: 0.0)
        shadowBorder.locations = [0, 0.5]
        layer.addSublayer(shadowBorder)
        
    }
    
    
    
    func disapear() {
        
        self.alpha = 0
        
    }
    


}

extension CALayer {
    
    func addSolidBorder(_ side: viewSides, _ color: UIColor){
        var x = CGFloat()
        var y = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        
        
        switch side {
        case .left:
            x = 0
            y = 0
            width = 0.5
            height = frame.height
            
        case .right:
            x = frame.width
            y = 0
            width = 0.5
            height = frame.height
            
        case .top:
            x = 0
            y = 0
            width = frame.width
            height = 0.5
            
        case .bottom:
            x = 0
            y = frame.height - 0.5
            width = frame.width
            height = 0.5
            
        }
        
        let botBorder = CALayer()
        botBorder.frame = CGRect(x: x, y: y, width: width, height: height)
        botBorder.backgroundColor = color.cgColor
        addSublayer(botBorder)
        
    }
    
    func addShadow(_ side: viewSides) {
        var x = CGFloat()
        var y = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        var sX = CGFloat()
        var sY = CGFloat()
        var eX = CGFloat()
        var eY = CGFloat()
        
        switch side {
        case .left:
            x = -5
            y = 0
            width = 5
            height = frame.height
            sX = 1.0
            sY = 0.5
            eX = 0
            eY = 0.5
        case .right:
            x = frame.width
            y = 0
            width = 5
            height = frame.height
            sX = 0
            sY = 0.5
            eX = 1.0
            eY = 0.5
        case .top:
            x = 0
            y = -5
            width = frame.width
            height = 5
            sX = 0.5
            sY = 1.0
            eX = 0.5
            eY = 0.0
        case .bottom:
            x = 0
            y = frame.height
            width = frame.width
            height = 5
            sX = 0.5
            sY = 0.0
            eX = 0.5
            eY = 1.0
        }
        
        let shadowBorder = CAGradientLayer()
        shadowBorder.frame = CGRect(x: x, y: y, width: width, height: height)
        let color1 = UIColor.black.withAlphaComponent(0.4).cgColor as CGColor
        let color2 = UIColor.clear.cgColor as CGColor
        shadowBorder.colors = [color1, color2]
        shadowBorder.startPoint = CGPoint(x: sX, y: sY)
        shadowBorder.endPoint = CGPoint(x: eX, y: eY)
        shadowBorder.locations = [0, 0.3]
        addSublayer(shadowBorder)
        
    }
    
    

    
}

extension UITextField {
    
   
    
}

extension UIButton{
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    func roundedButton(w: CGFloat, h: CGFloat){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: w, height: h))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
        
    }
    
    func set(_ title: String, back: UIColor, titleSel: UIColor, titleNorm: UIColor, to: UIView?) {
        
        backgroundColor = back
        setTitle(title, for: .normal)
        setTitleColor(titleNorm, for: .normal)
        setTitleColor(titleSel, for: .selected)
        if to != nil {
            to?.addSubview(self)
            
        }
    }
    
    func makeMainButton(_ string: String) {
        self.layer.cornerRadius = 0.5 * bounds.size.width
        self.backgroundColor = colors.mainButtonColor
        self.setTitle(string, for: .normal)
    }
    
    func addCircleShadow() {
        
        let shadowBorder = CAGradientLayer()
        shadowBorder.frame = CGRect(x: 0, y: 0, width: mainbuttonconf.size, height: mainbuttonconf.size)
        shadowBorder.cornerRadius = 0.5 * shadowBorder.bounds.size.width
        let color1 = UIColor.black.withAlphaComponent(0.3).cgColor as CGColor
        let color2 = UIColor.clear.cgColor as CGColor
        shadowBorder.colors = [color1, color2]
        shadowBorder.startPoint = CGPoint(x: 0.5, y: 1.0)
        shadowBorder.endPoint = CGPoint(x: 0.5, y: 0.0)
        shadowBorder.locations = [0, 0.5]
        layer.addSublayer(shadowBorder)
        
    }
    
    func changeColorTo(_ color: UIColor,_ forState: UIControlState) {
        
        if let imageToChange = backgroundImage(for: forState)?.withRenderingMode(.alwaysTemplate) {
            setImage(imageToChange, for: forState)
            tintColor = color
        }
    }
    
    func makeEditProfileAs(_ fromSide: contrastSides) {
        self.sideCircleView(nil)
        contrastBackGround(fromSide, colors.lightBlueMainColor, colors.purplishColor, [0.0, 0.7])
    }
    
    func makeEditProfileWithConstraints(_ fromSide: ContrastSides,_ h: CGFloat,_ w: CGFloat,_ fadeAt: [CGFloat]) {
        self.sideCircleViewWithConstraints(h)
        contrastBackGroundForViewWithConstraints(fromSide, colors.lightBlueMainColor, colors.purplishColor, fadeAt, h, w)
    }
    
    
    
    func makeHeaderButton() {
        
    }
}



extension Date {
    
    
    func dateFrom(string: String) -> Date? {
        
        guard string.characters.count == 10 else {
            return nil
        }
        let comps = string.components(separatedBy: "-")
        guard comps[0].characters.count == 4 else {
            return nil
        }
        guard comps[1].characters.count == 2 && comps[2].characters.count == 2 else {
            return nil
        }
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        guard let d = dateStringFormatter.date(from: string) else {
            return nil
        }
        
        return d
    }
    
    func dateFrom(utcString: String) -> Date? {
        
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        guard let d = dateStringFormatter.date(from: utcString) else {
            return nil
        }
        
        return d
    }
    
    func hasPast() -> Bool {
        
        //true if within time frame, false if beyond time frame
        let todaysDate = NSDate()
        var value = Int()
        var result = Bool()
        
        if #available(iOS 10.0, *) {
            
            var diffDateComponents = NSCalendar.current.dateComponents([Calendar.Component.second], from: todaysDate as Date, to: self)
            value = diffDateComponents.second!
            
            if value <= 0 {
                result = true
            } else {
                result = false
            }
            
        } else {
            
            var diffDateComponents = NSCalendar.current.dateComponents([Calendar.Component.second], from: todaysDate as Date, to: self)
            value = diffDateComponents.second!
            
            if value <= 0 {
                result = true
            } else {
                result = false
            }
        }
        return result
    }
    
}


extension NSLocale
{
    public class func localeForCountry(countryName : String) -> String?
    {
        return NSLocale.isoCountryCodes.filter{self.countryNameFromLocaleCode(localeCode: $0) == countryName}.first! as String
    }
    
    public class func countryNameFromLocaleCode(localeCode : String) -> String
    {
        return NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.countryCode, value: localeCode) ?? ""
    }
}

extension NSObject {
    
    func codeFor(countryName: String) -> String {
        let locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let countryName = Locale.current.regionCode
            if countryName?.lowercased() == countryName?.lowercased() {
                return localeCode
            }
        }
        return locales
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    func floatValueW(cgfloat: CGFloat) -> CGFloat{
        var result = CGFloat()
        if let window = UIApplication.shared.keyWindow {
            
            result = window.frame.width * (cgfloat / 375)
            
        }
        return result
    }
    
    func floatValueH(cgfloat: CGFloat) -> CGFloat{
        var result = CGFloat()
        if let window = UIApplication.shared.keyWindow {
            
            result = window.frame.width * (cgfloat / 667)
            
        }
        return result
    }
    
    func makeOvalLine(_ onView: UIView,_ viewTop: UIView,_ viewBottom: UIView,_ colorForView: Bool,_ arcHeight: CGFloat,_ stroke: CGFloat?,_ strokeColor: UIColor?) -> profileOvalDivider {
        
        
        var multiplier : CGFloat = arcHeight
        
        if !(multiplier <= viewTop.frame.height) {
            multiplier = viewTop.frame.height
        }
        
        let other : CGFloat = 1 + (multiplier / onView.frame.width)
        
        let xvalue = 0 - (multiplier / 2)
        let arcview = profileOvalDivider(frame: CGRect(x: xvalue, y: viewTop.center.y + (viewTop.frame.height / 2) - arcHeight, width: onView.frame.width * other, height: arcHeight * 2))
        arcview.backgroundColor = UIColor.clear
        
        
        if let line = stroke {
            arcview.shapeLayer.strokeColor = strokeColor?.cgColor
            arcview.shapeLayer.lineWidth = line
        } else {
            arcview.shapeLayer.borderWidth = 0
        }
        if onView == viewBottom {
            
            switch colorForView {
            case true:
                arcview.shapeLayer.fillColor = viewTop.backgroundColor?.cgColor
                
                onView.addSubview(arcview)
                onView.addSubview(viewTop)
            case false:
                arcview.shapeLayer.fillColor = viewBottom.backgroundColor?.cgColor
                onView.addSubview(viewTop)
                onView.addSubview(arcview)
                
            }
        } else if onView == viewTop {
            switch colorForView {
            case true:
                arcview.shapeLayer.fillColor = viewTop.backgroundColor?.cgColor
                
                onView.addSubview(viewBottom)
                onView.addSubview(arcview)
            case false:
                arcview.shapeLayer.fillColor = viewBottom.backgroundColor?.cgColor
                onView.addSubview(arcview)
                onView.addSubview(viewBottom)
            }
            
        } else {
            switch colorForView {
            case true:
                arcview.shapeLayer.fillColor = viewTop.backgroundColor?.cgColor
                onView.addSubview(viewBottom)
                onView.addSubview(arcview)
                onView.addSubview(viewTop)
            case false:
                arcview.shapeLayer.fillColor = viewBottom.backgroundColor?.cgColor
                onView.addSubview(viewTop)
                onView.addSubview(arcview)
                onView.addSubview(viewBottom)
                
            }
            
        }
        return arcview
    }
}

extension UIResponder {
    
    
}

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}

extension UISearchBar {
    /// Return text field inside a search bar
    var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else { return nil
        }
        return textField
    }
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}

extension String {
    
    func toDate() -> Date? {
        
        let date = NSDate(dateString: self)
        return date as Date
        
    }
    
    func dateIsValid() -> Bool {
        let date = toDate()
        guard date != nil else {
            return false
        }
        return date!.hasPast()
    }
    
    func hasDigits() -> Bool {
        let k = keyboard.digits
        var v = false
        for letter in self.characters {
            if k.contains("\(letter)") {
                v = true
                break
            }
        }
        return v
    }
    
    func hasSymbol() -> Bool {
        let k = keyboard.symbols
        var v = false
        for letter in self.characters {
            if k.contains("\(letter)") {
                v = true
                break
            }
        }
        return v
    }
    
    func isSymbol() -> Bool {
        let k = keyboard.symbols
        let a = keyboard.all
        var v = false
        for val in self.characters {
            for letter in k.characters {
                if letter == val {
                    v = true
                    break
                }
            }
        }
        if !v {
            var other : Bool = false
            for val in self.characters {
                for letter in a.characters {
                    if letter == val {
                        other = true
                        break
                    }
                }
            }
            if !other {
                v = true
            }
        }
        return v
    }
    
    func hasDigits(_ comp: @escaping (Bool) -> Void) {
        let k = keyboard.digits
        var v = false
        for letter in self.characters {
            if k.contains("\(letter)") {
                v = true
                break
            }
        }
        comp(v)
    }
    
    func hasLowerCase() -> Bool {
        let k = keyboard.lowercase
        var v = false
        for letter in self.characters {
            if k.contains("\(letter)") {
                v = true
                break
            }
        }
        return v
    }
    
    func hasUpperCase() -> Bool {
        let k = keyboard.uppercase
        var v = false
        for letter in self.characters {
            if k.contains("\(letter)") {
                v = true
                break
            }
        }
        return v
    }
    func hasSpecialChar() -> Bool {
        let k = keyboard.symbols
        var v = false
        for letter in self.characters {
            if k.contains("\(letter)") {
                v = true
                break
            }
        }
        return v
    }
    
    func hasSpecialChar(_ comp: @escaping (Bool) -> Void) {
        let k = keyboard.symbols
        var v = false
        for letter in self.characters {
            if k.contains("\(letter)") {
                v = true
                break
            }
        }
        comp(v)
    }
    
    func isOnlyUpperAndLowerCase() -> Bool {
        let k = keyboard.uppercase
        let o = keyboard.lowercase
        var yes = true
        for letter in self.characters {
            var v = false
            if k.contains("\(letter)"){
                v = true
            }
            v = false
            if o.contains("\(letter)"){
                v = true
            }
            if !v {
                yes = v
                break
            }
        }
        return yes
    }
    
    func isOnlyUpperAndLowerCase(_ comp: @escaping (Bool) -> Void){
        let k = keyboard.uppercase
        let o = keyboard.lowercase
        var yes = true
        for letter in self.characters {
            var v = false
            if k.contains("\(letter)"){
                v = true
            }
            if o.contains("\(letter)"){
                v = true
            }
            if !v {
                yes = v
                break
            }
        }
        comp(yes)
    }
    
    func isPostalCode(_ comp: @escaping (Bool) -> Void){
        let k = keyboard.uppercase
        let o = keyboard.digits
        var yes = true
        for letter in self.characters {
            var v = false
            if k.contains("\(letter)"){
                v = true
            }
            if o.contains("\(letter)"){
                v = true
            }
            if !v {
                yes = v
                break
            }
        }
        
        comp(yes)
    }
    
    func isPostalCode() -> Bool {
        let k = keyboard.uppercase
        let o = keyboard.digits
        var yes = true
        for letter in self.characters {
            var v = false
            if k.contains("\(letter)"){
                v = true
            }
            if o.contains("\(letter)"){
                v = true
            }
            if !v {
                yes = v
                break
            }
        }
        
        return yes
    }
    
    func isOnlyDigits() -> Bool{
        let k = keyboard.digits
        var yes = true
        for letter in self.characters {
            if !k.contains("\(letter)"){
                yes = false
                break
            }
        }
        return yes
    }
    
    func isOnlyDigits(_ comp: @escaping (Bool) -> Void){
        let k = keyboard.digits
        var yes = true
        for letter in self.characters {
            if !k.contains("\(letter)"){
                yes = false
                break
            }
        }
        comp(yes)
    }
    
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }

    func toDecimalNumber() -> NSDecimalNumber {
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        return formatter.number(from: (self as NSString) as String) as? NSDecimalNumber ?? 0
        
    }
    
    func keepString(asOf: Character) -> String {
        
        let c = self.characters
        var final = String()
        if let mark = c.index(of: asOf) {
            
            final = self[c.index(after: mark)..<self.endIndex]
            
        }
        return final
    }
    
    func base64Encoded() -> String {
        let plainData = data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    
    func base64Decoded() -> String {
        let decodedData = NSData(base64Encoded: self, options:NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)
        return decodedString! as String
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    
    func dateFromString() -> Date {
        var timeStamp = String()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
        var localTimeZoneName: String { return (NSTimeZone.local as NSTimeZone).name }
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        return dateFormatter.date(from: self)!// create date from string
    }
    
    func toLocalTimeLabelForCell() -> String {
        
        var timeStamp = String()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
        var localTimeZoneName: String { return (NSTimeZone.local as NSTimeZone).name }
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let date = dateFormatter.date(from: self) // create date from string
        
        let interdate = date?.timeIntervalSinceNow
        
        let intSecs = Int(interdate!)
        let intermins = intSecs / 60
        _ = intermins / 60
        let intdays = ((interdate! / 60) / 60) / 24
        _ = intdays / 7
        _ = intdays / 30
        
        let minute = Calendar.current.component(.minute, from: date!)
        let hour = Calendar.current.component(.hour, from: date!)
        let day = Calendar.current.component(.day, from: date!)
        let month = Calendar.current.component(.month, from: date!)
        let year = Calendar.current.component(.year, from: date!)
        
        let nMinute = Calendar.current.component(.minute, from: NSDate() as Date)
        let nHour = Calendar.current.component(.hour, from: NSDate() as Date)
        let nDay = Calendar.current.component(.day, from: NSDate() as Date)
        let nMonth = Calendar.current.component(.month, from: NSDate() as Date)
        let nYear = Calendar.current.component(.year, from: NSDate() as Date)
        
        let dif = (nDay - day)
        
        
        
        //make it general
        guard year != nYear || month != nMonth && dif > 7 else {
            
            guard (nDay - day) == 7 else {
                
                guard dif > 1 else {
                    
                    guard dif == 1 else {
                        
                        guard (nHour - hour) != 0 else {
                            guard (nMinute - minute) != 0 else {
                                return "Just Now"
                            }
                            return "\(minute) Minutes Ago"
                        }
                        
                        if nHour > 0 && nHour <= 12 {
                            guard hour > 12 else {
                                return "\(hour):\(minute) AM"
                            }
                            return "Yesterday"
                            
                        } else if nHour > 12 && nHour <= 17{
                            guard hour < 12 else {
                                
                                return "\(hour):\(minute) PM"
                            }
                            return "This Morning"
                        } else if nHour >= 18 {
                            
                            guard (nHour - hour) > 3 else {
                                
                                return "\(hour):\(minute) PM"
                            }
                            
                            guard hour > 12 else {
                                
                                return "This Morning"
                            }
                            
                            guard hour > 18 else {
                                
                                return "This Afternoon"
                            }
                        }
                        return "Yesterday"
                    }
                    
                    return "Yesterday"
                }
                
                return "\(dif) days ago"
            }
            
            return "A Week Ago"
        }
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        dateFormatter.timeZone = NSTimeZone.local
        timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    
    func chopSuffix(_ byPositiveCount: Int) -> String {
        return self.substring(to: self.characters.index(self.endIndex, offsetBy: -byPositiveCount))
    }
    func chopPrefix(_ count: Int) -> String {
        return self.substring(to: self.characters.index(self.startIndex, offsetBy: count))
    }
    
    func checkIfValidWaid() -> Bool {
        
        let count = self.characters.count - 1
        var new = self.chopSuffix(count - 4)
        guard new.characters.count == 5 else {
            print("Fatal Error: checking validWaid returned a string different then 5")
            return false
        }
        guard new.characters.popFirst() == "w" else {
            print("Fatal Error: the submitted waid string is invalid or not a waid - W was not present in the string")
            return false
        }
        guard new.characters.popFirst() == "a" else {
            print("Fatal Error: the submitted waid string is invalid or not a waid - A was not present in the string")
            return false
        }
        guard new.characters.popFirst() == "i" else {
            print("Fatal Error: the submitted waid string is invalid or not a waid - I was not present in the string")
            return false
        }
        guard new.characters.popFirst() == "d" else {
            print("Fatal Error: the submitted waid string is invalid or not a waid - D was not present in the string")
            return false
        }
        guard new.characters.popFirst() == "_" else {
            print("Fatal Error: the submitted waid string is invalid or not a waid - _ was not present in the string")
            return false
        }
        
        return true
    }
    
    func checkIfValidPrid() -> Bool {
        
        let count = self.characters.count - 1
        var new = self.chopSuffix(count - 4)
        guard new.characters.count == 5 else {
            print("Fatal Error: checking validPrid for /prid_/ returned a string different then 5")
            return false
        }
        guard new.characters.popFirst() == "p" else {
            print("Fatal Error: the submitted prid string is invalid or not a waid - P was not present in the string")
            return false
        }
        guard new.characters.popFirst() == "r" else {
            print("Fatal Error: the submitted prid string is invalid or not a waid - R was not present in the string")
            return false
        }
        guard new.characters.popFirst() == "i" else {
            print("Fatal Error: the submitted prid string is invalid or not a waid - I was not present in the string")
            return false
        }
        guard new.characters.popFirst() == "d" else {
            print("Fatal Error: the submitted prid string is invalid or not a waid - D was not present in the string")
            return false
        }
        guard new.characters.popFirst() == "_" else {
            print("Fatal Error: the submitted prid string is invalid or not a waid - _ was not present in the string")
            return false
        }
        
        return true
    }
    
    func zipped(_ with: String) -> String {
        var zipped = String()
        
        _ = UInt32(arc4random_uniform(3))
        
        var char = characters
        var char2 = randomString(length: char.count).characters
        
        var up : Bool = true
        
        while char2.count != 0 {
            if up {
                if char.count > 0 {
                    zipped.append(char.popFirst()!)
                }
                up = false
            } else {
                zipped.append(char2.popFirst()!)
                up = true
            }
        }
        
        return zipped
    }
    
    func zipped() -> String {
        var zipped = String()
        var char = characters
        var char2 = randomString(length: char.count).characters
        var up : Bool = true
        while char2.count != 0 {
            if up {
                if char.count > 0 {
                    zipped.append(char.popFirst()!)
                }
                up = false
            } else {
                zipped.append(char2.popFirst()!)
                up = true
            }
        }
        return zipped
    }
    
    func unzipped() -> String {
        var stri = self
        var result = String()
        var char2 = String()
        
        var up : Bool = true
        
        while stri.characters.count >= 1 {
            if up {
                result.append(stri.characters.popFirst()!)
                up = false
            } else {
                char2.append(stri.characters.popFirst()!)
                up = true
            }
        }
        
        return result
    }
    
    
    func zip(_ with: String) -> String {
        var zipped = String()
        
        var char = characters
        var char2 = with.characters
        var up : Bool = true
        while char2.count != 0 {
            if up {
                if char.count > 0 {
                    zipped.append(char.popFirst()!)
                }
                up = false
            } else {
                zipped.append(char2.popFirst()!)
                up = true
            }
        }
        zipped.append("@4OJKO")
        
        return zipped
    }
    
    func apiZip(_ with: String) -> String {
        var zipped = String()
        
        var char = characters
        var char2 = with.characters
        var up : Bool = true
        while char2.count != 0 {
            if up {
                if char.count > 0 {
                    zipped.append(char.popFirst()!)
                }
                up = false
            } else {
                zipped.append(char2.popFirst()!)
                up = true
            }
        }
        
        return zipped
    }
    
    func skipZip(_ with: String) -> String {
        var zipped = String()
        
        _ = UInt32(arc4random_uniform(3))
        
        var char = characters
        var char2 = with.characters
        
        var up : Bool = true
        
        while char2.count != 0 {
            if up {
                if char.count > 0 {
                    zipped.append(char.popLast()!)
                }
                up = false
            } else {
                zipped.append(char2.popFirst()!)
                up = true
            }
        }
        zipped.append("@NU89Q")
        
        return zipped
    }
    
    func unZippedPair() -> ZippedPair {
        var stri = self
        let res = ZippedPair()
        
        var up : Bool = true
        
        while stri.characters.count >= 1 {
            if up {
                res.other.append(stri.characters.popFirst()!)
                up = false
            } else {
                res.main.append(stri.characters.popFirst()!)
                up = true
            }
        }
        
        return res
    }
    
    public class ZippedPair {
        
        var main = String()
        var other = String()
    }
    
    func skipZipAlt(_ with: String) -> String {
        
        var zipped = String()
        
        _ = UInt32(arc4random_uniform(2))
        
        var char = characters
        var char2 = with.characters
        
        var up : Bool = true
        
        while char2.count != 0 {
            if up {
                if char.count > 0 {
                    zipped.append(char.popLast()!)
                }
                up = false
            } else {
                zipped.append(char2.popFirst()!)
                up = true
            }
        }
        zipped.append("@k?*q#")
        
        return zipped
    }
    
    func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!#$%^&*()><?.,.~"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    func eightBitRandom() -> String {
        return randomString(length: 8)
    }
    func sixteenBitRandom() -> String {
        return randomString(length: 16)
    }
    func twentyFourBitRandom() -> String {
        return randomString(length: 24)
    }
    func thirtyTwoBitRandom() -> String {
        return randomString(length: 32)
    }
    func sixtyFourBitRandom() -> String {
        return randomString(length: 64)
    }
}

extension UILabel {
    
    func payMethodLabel(_ text: String, color: UIColor, fontSize: CGFloat, align: NSTextAlignment, addTo: UIView) {
    
        self.text = text
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        textAlignment = .center
        numberOfLines = 0
        addTo.addSubview(self)
    }
}

extension UIImageView {
    
    
    func changeColorTo(_ color: UIColor) {
        
        if let imageToChange = image?.withRenderingMode(.alwaysTemplate) {
            image = imageToChange
            tintColor = color
        }
    }
}




extension Dictionary {
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
    
    
}

// Dismissal animators




public class Interactor: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}

extension UIViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    /*public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (Interactor?.hasStarted)
    }*/
    
    func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
            
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    func decodeJWTPart(_ value: String) throws -> [String: Any] {
        guard let bodyData = base64UrlDecode(value) else {
            throw DecodeError.invalidBase64Url(value)
        }
        print(bodyData)
        guard let json = try? JSONSerialization.jsonObject(with: bodyData, options: .mutableContainers), let payload = json as? [String: Any] else {
            throw DecodeError.invalidJSON(value)
        }
        print(json)
        
        return payload
    }
    
    enum DecodeError: LocalizedError {
        case invalidBase64Url(String)
        case invalidJSON(String)
        case invalidPartCount(String, Int)
        
        public var localizedDescription: String {
            switch self {
            case .invalidJSON(let value):
                return NSLocalizedString("Malformed jwt token, failed to parse JSON value from base64Url \(value)", comment: "Invalid JSON value inside base64Url")
            case .invalidPartCount(let jwt, let parts):
                return NSLocalizedString("Malformed jwt token \(jwt) has \(parts) parts when it should have 3 parts", comment: "Invalid amount of jwt parts")
            case .invalidBase64Url(let value):
                return NSLocalizedString("Malformed jwt token, failed to decode base64Url value \(value)", comment: "Invalid JWT token base64Url value")
            }
        }
    }
}

extension CLLocationManager {
    
}

public func arc4random<T: ExpressibleByIntegerLiteral>(_ type: T.Type) -> T {
    var r: T = 0
    arc4random_buf(&r, MemoryLayout<T>.size)
    return r
}

extension Double {
    
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    
    func setCurrencyLabel() -> CGFloat {
        
        let value = self * 100
        
        let subtotal = value * Double(1 - CanadianTaxRates.quebec.tps - CanadianTaxRates.quebec.tvq)
        let round = CGFloat(subtotal.rounded())
        return round / 100
        
    }
}
public extension UInt64 {
    public static func random(lower: UInt64 = min, upper: UInt64 = max) -> UInt64 {
        var m: UInt64
        let u = upper - lower
        var r = arc4random(UInt64.self)
        
        if u > UInt64(Int64.max) {
            m = 1 + ~u
        } else {
            m = ((max - (u * 2)) + 1) % u
        }
        
        while r < m {
            r = arc4random(UInt64.self)
        }
        
        return (r % u) + lower
    }
}

public extension Int64 {
    public static func random(lower: Int64 = min, upper: Int64 = max) -> Int64 {
        let (s, overflow) = Int64.subtractWithOverflow(upper, lower)
        let u = overflow ? UInt64.max - UInt64(~s) : UInt64(s)
        let r = UInt64.random(upper: u)
        
        if r > UInt64(Int64.max)  {
            return Int64(r - (UInt64(~lower) + 1))
        } else {
            return Int64(r) + lower
        }
    }
}

private let _wordSize = __WORDSIZE

public extension UInt32 {
    public static func random(lower: UInt32 = min, upper: UInt32 = max) -> UInt32 {
        return arc4random_uniform(upper - lower) + lower
    }
}

public extension Int32 {
    public static func random(lower: Int32 = min, upper: Int32 = max) -> Int32 {
        let r = arc4random_uniform(UInt32(Int64(upper) - Int64(lower)))
        return Int32(Int64(r) + Int64(lower))
    }
}

public extension UInt {
    public static func random(lower: UInt = min, upper: UInt = max) -> UInt {
        switch (_wordSize) {
        case 32: return UInt(UInt32.random(lower: UInt32(lower), upper: UInt32(upper)))
        case 64: return UInt(UInt64.random(lower: UInt64(lower), upper: UInt64(upper)))
        default: return lower
        }
    }
}

public extension Int {
    public static func random(lower: Int = min, upper: Int = max) -> Int {
        switch (_wordSize) {
        case 32: return Int(Int32.random(lower: Int32(lower), upper: Int32(upper)))
        case 64: return Int(Int64.random(lower: Int64(lower), upper: Int64(upper)))
        default: return lower
        }
    }
}
