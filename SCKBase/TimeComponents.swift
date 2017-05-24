//
//  TimeComponents.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-05-24.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit


open class LocationTimeComponents : NSObject {
    
    public var is_open : Bool
    public var opening : Int?
    public var openingVals : AcuteTimeValues?
    public var closing : Int?
    public var closingVals : AcuteTimeValues?
    public var timezone : String?
    public var weekday : String?
    
    public init(info: [String:Any]) throws {
        if let isOp = info["is_open"] as? Bool {
            self.is_open = isOp
            super.init()
            if let closing = info["timezone"] as? String {
                self.timezone = closing
            } else {
                throw LocationTimesComponentError.missing("No timezone")
            }
            if let weekd = info["weekday"] as? String{
                self.weekday = weekd
                if let close = info["closing"] as? Int, let open = info["opening"] as? Int, let int = weekd.gregorianValue() {
                    self.closing = close
                    self.opening = open
                    openingVals = AcuteTimeValues(from: open, meridiem: true)
                    closingVals = AcuteTimeValues(from: close, meridiem: true)
                    if close < open {
                        openingVals?.gregorianDay = 0
                        closingVals?.gregorianDay = 1
                        
                        if int <= 6 {
                            closingVals?.gregorianValue = int + 1
                            openingVals?.gregorianValue = int
                        } else {
                            closingVals?.gregorianValue = 1
                            openingVals?.gregorianValue = 7
                        }
                    } else {
                        closingVals?.gregorianValue = int
                        openingVals?.gregorianValue = int
                    }
                } else {
                    throw LocationTimesComponentError.missing("No closing")
                }
            } else {
                throw LocationTimesComponentError.missing("No weekday")
            }
        } else {
            throw LocationTimesComponentError.missing("No Status")
        }
    }
    
    open var withinTimeFrame : Bool {
        if let openings = openingVals, let closings = closingVals {
            let now = AcuteTimeValues()
            return now > openings && now < closings
        } else {
            return false
        }
    }
    
    open var beforeTimeFrame : Bool {
        if let openings = openingVals{
            let now = AcuteTimeValues()
            return now < openings
        } else {
            return false
        }
    }
    
    open var afterTimeFrame : Bool {
        if let closings = closingVals {
            let now = AcuteTimeValues()
            return now > closings
        } else {
            return false
        }
    }
    
    private func dayFrom(gregorian: Int) -> String? {
        switch gregorian {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return nil
        }
    }
    private func gregorian(fromDay: String) -> Int? {
        switch fromDay.lowercased() {
        case "sunday":
            return 1
        case "monday":
            return 2
        case "tuesday":
            return 3
        case "wednesday":
            return 4
        case "thursday":
            return 5
        case "friday":
            return 6
        case "saturday":
            return 7
        default:
            return nil
        }
    }
}
