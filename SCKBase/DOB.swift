//
//  DOB.swift
//  Checkout
//
//  Created by Jean-Louis Murphy on 2017-01-17.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit

public class DOB {
    var day = Day()
    var month = Month()
    var year = Year()
    var timeZone = String()
    
    private var dat: Date?
    
    var utc : String {
        get {
            return stringIn(.utc)
        }
    }
    
    var local : String {
        get {
            return stringIn(.local)
        }
    }
    
    var short : String {
        get {
            return stringIn(.short)
        }
    }
    
    var literal : String {
        get {
            return "\(day.literal) of \(month.monthString) \(year.integer)"
        }
    }
    
    var date : Date? {
        get {
            guard dat != nil else {
                return nil
            }
            return dat!
        } set {
            dat = newValue
            dateToMultiVars()
        }
    }
    
    private func stringIn(_ format: TimeZoneFormat) -> String {
        
        let y = year.integer
        let m = month.integer
        let d = day.integer
        var str = String()
        switch format {
        case .utc:
            str = "\(y)-0\(m)-0\(d)T12:00:00.000Z"
        case .local:
            str = "\(y)-0\(m)-0\(d)T12:00:00.000Z"
        case .short:
            str = "\(y)-\(m)-\(d)"
            
        }
        datatoDate()
        return str
    }
    
    func start() {
        datatoDate()
    }
    
    private func dateToMultiVars() {
        guard let d = dat else {
            return
        }
        let da = Calendar.current.component(.day, from: d)
        let mo = Calendar.current.component(.month, from: d)
        let ye = Calendar.current.component(.year, from: d)
        _ = Calendar.current.component(.timeZone, from: d)
        
        day.set(da)
        month.set(mo)
        year.set(ye)
        
        
        
        
    }
    
    private func datatoDate() {
        dat = NSDate(dateString: "\(year.integer)-\(month.integer)-\(day.integer)") as Date
    }
    
    var canBeObject: Bool {
        get {
            guard dat != nil else {
                return false
            }
            return true
        }
    }
}

enum TimeZoneFormat {
    case utc, local, short
}

public class MultiDate: MultiVar {
    override public func set(_ i: Any) {
        super.set(i)
        
    }
}

public class Day: MultiDate {
    
    var literal : String {
        get {
            var suff = String()
            guard integer != 1 else {
                suff = "st"
                return "\(integer)\(suff)"
            }
            guard integer != 21 else {
                suff = "st"
                return "\(integer)\(suff)"
            }
            guard integer != 31 else {
                suff = "st"
                return "\(integer)\(suff)"
            }
            guard integer != 2 else {
                suff = "nd"
                return "\(integer)\(suff)"
            }
            guard integer != 22 else {
                suff = "nd"
                return "\(integer)\(suff)"
            }
            guard integer != 3 else {
                suff = "rd"
                return "\(integer)\(suff)"
            }
            guard integer != 23 else {
                suff = "rd"
                return "\(integer)\(suff)"
            }
            suff = "th"
            return "\(integer)\(suff)"
        }
    }
    
    override public func set(_ i: Any) {
        super.set(i)
    }
}

public class Month: MultiDate {
    
    private var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var monthString : String {
        get {
            return months[integer - 1]
        }
    }
    
    override public func set(_ i: Any) {
        super.set(i)
        if nulls {
            
        }
    }
    
}


public class Year: MultiDate {

}

