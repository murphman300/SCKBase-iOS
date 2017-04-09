//
//  Phone.swift
//  Checkout
//
//  Created by Jean-Louis Murphy on 2017-01-17.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit


public class Phone {
    var number = MainDigits()
    var regional = RegionalCode()
    private var isSet : Bool = false
    
    var display : String {
        get {
            return "\(regional.display)-\(number.prefixes)-\(number.suffixes)"
        }
    }
    
    var compact : String {
        get {
            return "\(regional.compact)\(number.prefixes)\(number.suffixes)"
        }
    }
    
    var stpCompact : String {
        get {
            return "\(regional.area)\(number.prefixes)\(number.suffixes)"
        }
    }
    
    func set(_ code: String,_ pref: String,_ suf: String) {
        number.set(pref, suf)
        regional.set(code)
        isSet = true
    }
    
    func set(_ code: Int,_ pref: Int,_ suf: Int) {
        number.set(pref, suf)
        regional.set(code)
        isSet = true
    }
    
    var suffix: Int {
        get {
            return number.suffixes
        } set {
            number.suffixes = suffix
        }
    }
    
    var prefix: Int {
        get {
            return number.prefixes
        } set {
            number.prefixes = prefix
        }
    }
    
    
    
    var code: Int {
        get {
            return regional.code
        }
    }
    
    var canBeObject: Bool {
        get {
            guard isSet else {
                return false
            }
            return true
        }
    }
    
    var dict : [String:String] {
        get {
            guard canBeObject else {
                return [:]
            }
            return ["compact": compact, "display": display]
        }
    }
    
    var dataObject : Data? {
        get {
            let obj = dict
            do {
                guard dict.isEmpty else {
                    let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    return data
                }
                return nil
            } catch {
                return nil
            }
        }
    }
    
    
    public class MainDigits {
        private var pre = MultiVar()
        var prefixes : Int {
            get {
                return pre.integer
            } set {
                pre.set(newValue)
            }
        }
        private var suf  = MultiVar()
        
        var suffixes : Int {
            get {
                return suf.integer
            } set {
                suf.set(newValue)
            }
        }
        
        func set(_ pref: Int, _ sufx: Int) {
            pre.set(pref)
            suf.set(sufx)
        }
        
        func set(_ pref: String, _ sufx: String) {
            pre.set(pref)
            suf.set(sufx)
        }
        
        deinit {
            
        }
    }
    public class RegionalCode {
        private var co  = MultiVar()
        private var reg = String()
        
        func set(_ code: Int) {
            co.set(code)
            if canada.contains(code) {
                reg = "+1"
            }
        }
        
        func set(_ code: String) {
            co.set(code)
            if stCanada.contains(code) {
                guard reg.isEmpty else {
                    return
                }
                reg = "+1"
            }
        }
        
        var code : Int {
            get {
                return co.integer
            }
        }
        
        var display : String {
            get {
                var st = String()
                guard reg.isEmpty else {
                    st = reg
                    
                    return "\(st)-\(co.string)"
                }
                return "\(co.string)"
            }
        }
        
        var compact : String {
            get {
                var st = String()
                guard reg.isEmpty else {
                    st = reg
                    return "\(st)\(co.string)"
                }
                return "\(co.string)"
            }
        }
        
        var area : String {
            get {
                var st = String()
                guard reg.isEmpty else {
                    st = reg
                    return "\(co.string)"
                }
                return "\(co.string)"
            }
        }
        
        private var canada = [514, 613, 819]
        private var stCanada = ["514", "613", "819"]
    }
    
    deinit {
    }
}
