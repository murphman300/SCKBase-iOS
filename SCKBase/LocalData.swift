//
//  LocalData.swift
//  Checkout
//
//  Created by Jean-Louis Murphy on 2017-01-17.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit

public class LocalData {
    var isAssigned : Bool = false
    var street = String()
    var number = String()
    var municipality = String()
    var unit = String()
    var state = State()
    var country = Country()
    var postalcode = PostalCode()
    
    var fullAddress : String {
        get {
            guard unit.isEmpty else {
                
                return "\(number) \(street), #\(unit), \(municipality), \(state), \(country), \(postalcode)"
            }
            
            return "\(number) \(street), \(municipality), \(state), \(country), \(postalcode)"
        }
    }
    var canBeObject: Bool {
        get {
            guard isAssigned else {
                return false
            }
            return true
        }
    }
    
    private var hasUnit: Bool {
        get {
            return unit.isEmpty
        }
    }
    
    var streetAddress: String {
        get {
            return "\(number) \(street)"
        }
    }
    
    var dict : [String:Any] {
        get {
            guard canBeObject else {
                return [:]
            }
            guard hasUnit else {
                return ["street": street, "number": number, "municipality": municipality, "state": state, "country": country, "postalcode": postalcode]
            }
            return ["street": street, "number": number, "municipality": municipality, "unit": unit, "state": state, "country": country, "postalcode": postalcode]
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
}

public class PostalCode {
    
    
    private var suff : String?
    private var pref : String?
    
    var code : String? {
        get {
            guard let su = suff, let pr = pref else {
                return nil
            }
            
            return "\(su)-\(pr)"
        } set {
            guard let p = newValue else {
                return
            }
            guard p.contains("-") else {
                var n = p
                suff = String()
                pref = String()
                while (suff?.characters.count)! < n.characters.count {
                    if let ne = n.characters.popFirst() {
                        suff?.append(ne)
                    }
                }
                while n.characters.count != 0 {
                    if let ne = n.characters.popFirst() {
                        pref?.append(ne)
                    }
                }
                return
            }
            let co = p.components(separatedBy: "-")
            guard co.count == 2 else {
                return
            }
            suff = String()
            pref = String()
            suff = co[0]
            pref = co[1]
        }
    }
    
    var compact : String? {
        get {
            guard let su = suff else {
                return nil
            }
            
            guard let pr = pref else {
                return nil
            }
            
            return "\(su)\(pr)"
        }
    }
    
    var isCode : Bool {
        get {
            guard let c = compact else {
                return false
            }
            return c.isPostalCode()
        }
    }
}

public class State {
    private var geo = GeoVar()
    
    var str = String()
    func set(_ name: String) {
        geo.province = name
    }
    var name : String? {
        get {
            guard let n = geo.province else {
                return nil
            }
            return n
        }
    }
    
    var code : String? {
        get {
            guard let n = geo.short else {
                return nil
            }
            return n
        }
    }
}

public class Country {
    private var geo = GeoVar()
    func set(_ name: String) {
        geo.country = name
    }
    func setCode(_ name: String) {
        
    }
    var str = String()
    var name : String? {
        get {
            guard let n = geo.country else {
                return nil
            }
            return n
        }
    }
    
    var code : String? {
        get {
            guard let n = geo.short else {
                return nil
            }
            return n
        }
    }
}

enum Provinces: String {
    case qc = "Quebec"
    case ont = "Ontario"
    case bc = "British Columbia"
    case mani = "Manitoba"
    case nflab = "Newfoundland and Labrador"
    case nv = "Nova Scotia"
    case sask = "Saskatchewan"
    case alb = "Alberta"
    case pei = "Prince Edward Island"
    case nb = "New Brunswick"
    case nun = "Nunavut"
    case nwt = "Northwest Territories"
    case yuk = "Yukon"
    
    
    init() {
        self = Provinces(rawValue: "Quebec")!
    }
    
    public func parseToPair(_ value: String) -> GeoVar.StatePair? {
        var n : GeoVar.StatePair?
        for v in array() {
            if v.rawValue.contains(value) {
                let short = shorts()
                if let sc = short[v] {
                    n = GeoVar.StatePair()
                    n?.chortCode = sc
                    n?.state = v.rawValue
                }
                break
            }
        }
        return n
    }
    
    private func array() -> [Provinces] {
        return [.qc, .ont, .bc, .mani, .nflab, .nv, .sask, .alb, .pei, .nb, .nun, .nwt, .yuk]
    }
    
    private func shorts() -> [Provinces: String] {
        
        return [.qc: "QC", .ont: "ON", .bc: "BC", .mani: "MA", .nflab: "NL", .nv: "NV", .sask: "SK", .alb: "AB", .pei: "PE", .nb: "NB", .nun: "NV", .nwt: "NT", .yuk: "YK"]
        
    }
}



enum States {
    
    
}

enum Countries: String {
    
    case can = "Canada"
    
    init() {
        self = Countries(rawValue: "Canada")!
    }
    
    public func parseToPair(_ value: String) -> GeoVar.CountryPair? {
        var n : GeoVar.CountryPair?
        for v in array() {
            if v.rawValue.contains(value) {
                let short = shorts()
                if let sc = short[v] {
                    n = GeoVar.CountryPair()
                    n?.chortCode = sc
                    n?.country = v.rawValue
                }
                break
            }
        }
        return n
    }
    
    private func array() -> [Countries] {
        return [.can]
    }
    
    private func shorts() -> [Countries: String] {
        
        return [.can: "CA"]
        
    }
    
}

