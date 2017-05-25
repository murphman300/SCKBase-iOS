//
//  TimeVariables.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-05-24.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

public struct TimeVariables {
    
}
public struct days {
    public static let inAWeek : Int = 7
}
public struct hours {
    public static let inADay : Int = 24
    public static let inAWeek : Int = inADay * days.inAWeek
}
public struct minutes {
    static let inAnHour: Int = 60
    static let inADay : Int = inAnHour * 60
    static let inAWeek : Int = inADay * days.inAWeek
}
public struct seconds {
    public static let inAMinute : Int = 60
    public static let inAnHour : Int = minutes.inAnHour * inAMinute
    public static let inADay : Int = inAnHour * hours.inADay
    public static let inAWeek : Int = inADay * days.inAWeek
}
public struct milliseconds {
    public static let inASecond : Int = 1000
    public static let inAMinute : Int = inASecond * seconds.inAMinute
    public static let inAnHour : Int = minutes.inAnHour * inAMinute
    public static let inADay : Int = inAnHour * hours.inADay
    public static let inAWeek : Int = inADay * days.inAWeek
}


public enum GregorianDictionaryError : Error {
    case because(String)
}

public struct GregorianDictionary {
    
    public var one : LocationTimeComponents?
    
    public var two : LocationTimeComponents?
    
    public var three : LocationTimeComponents?
    
    public var four : LocationTimeComponents?
    
    public var five : LocationTimeComponents?
    
    public var six : LocationTimeComponents?
    
    public var seven : LocationTimeComponents?

    public init(values: [LocationTimeComponents]) {
        for comp in values {
            if let week = comp.weekday {
                switch week.lowercased() {
                case "monday" :
                    one = comp
                case "tuesday" :
                    two = comp
                case "wednesday" :
                    three = comp
                case "thursday" :
                    four = comp
                case "friday" :
                    five = comp
                case "saturday" :
                    six = comp
                case "sunday" :
                    seven = comp
                default :
                    break
                }
            }
        }
    }
    
}

public enum LocationHoursError : Error {
    case because(String)
}

open class LocationHours {
    
    var values = [LocationTimeComponents]()
    
    public convenience init(data : [[String:Any]]) throws {
        self.init()
        for item in data {
            do {
                let new = try LocationTimeComponents(info: item)
                values.append(new)
            } catch {
                print("Failed to cast one")
            }
        }
        let v = values
        values = v.sorted(by: { (a, b) -> Bool in
            if let t = a.weekday, let r = b.weekday, let tg = t.gregorianValue(), let rg = r.gregorianValue() {
                return tg < rg
            } else {
                return false
            }
        })
        if values.count != 7 {
           throw LocationHoursError.because("Invalid count")
        }
    }
}
