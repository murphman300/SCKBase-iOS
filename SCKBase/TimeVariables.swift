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
    
    public var allHere : Bool {
        get {
            guard one == nil || two == nil ||  three == nil || four == nil || five == nil || six == nil || seven == nil else {
                return true
            }
            return false
        }
    }

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
    
    public func now() -> LocationTimeComponents? {
        guard let su = one, let mo = two, let tu = three, let wed = four, let thu = five, let fri = six, let sat = seven else {
            return nil
        }
        let now = AcuteTimeValues()
        switch now.gregorian {
        case 1:
            return su
        case 2:
            return mo
        case 3:
            return tu
        case 4:
            return wed
        case 5:
            return thu
        case 6:
            return fri
        case 7:
            return sat
        default :
            return nil
        }
    }
    
    func dayFromValue(_ i : Int) -> LocationTimeComponents? {
        guard let su = one, let mo = two, let tu = three, let wed = four, let thu = five, let fri = six, let sat = seven else {
            return nil
        }
        switch i {
        case 1:
            return su
        case 2:
            return mo
        case 3:
            return tu
        case 4:
            return wed
        case 5:
            return thu
        case 6:
            return fri
        case 7:
            return sat
        default :
            return nil
        }
    }
    
    public func nextOpenDay() -> LocationTimeComponents? {
        let now = AcuteTimeValues()
        var int = now.gregorian
        var steps: Int = 0
        var found : LocationTimeComponents?
        while found == nil || steps < 6 {
            if int == 8 {
                int = 1
            }
            if let day = dayFromValue(int) {
                if day.is_open {
                    found = day
                    break
                } else {
                    int += 1
                }
            } else {
                int += 1
            }
            steps += 1
        }
        return found
    }
}

public enum LocationHoursError : Error {
    case because(String)
}

open class LocationHours {
    
    public var values = [LocationTimeComponents]()
    public var list : GregorianDictionary?
    
    public var today : LocationTimeComponents? {
        get {
            guard let l = list else {
                return nil
            }
            return l.now()
        }
    }
    
    public var currentState : String {
        guard let l = today else {
            return "Closed"
        }
        let current = l.currentLabel
        if current == "Closed", let li = list {
            if let next = li.nextOpenDay(), let ng = next.gregorian, let tg = l.gregorian {
                if ng == tg {
                    return "Opens \(l.currentLabel)"
                } else {
                    return next.currentLabel
                }
            } else {
                return "Temporarily closed"
            }
        } else {
            return current
        }
    }
    
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
        list = GregorianDictionary(values: values)
        if let lis = list, lis.one == nil || lis.two == nil ||  lis.three == nil || lis.four == nil || lis.five == nil || lis.six == nil || lis.seven == nil {
            throw LocationHoursError.because("Invalid list casting")
        }
    }
}
