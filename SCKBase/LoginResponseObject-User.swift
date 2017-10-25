//
//  LoginResponseObject-User.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-10-25.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

open class UserLoginResponse : Decodable {

    open var resultCode : Int
    open var message : String
    open var result : LoginResult
    
}

public enum LoggedInWith {
    case EmailPassword
    case Facebook
    case NotLoggedIn
}

open class LoginResult : Decodable {
    
    open var token : String?
    
    public var loggedInWith : LoggedInWith {
        guard let type = self.login_type else { return .NotLoggedIn }
        if type.last_type == "facebook" {
            return .Facebook
        }
        return .EmailPassword
    }
    
    open var login_type : LoginType?
    open class LoginType : Decodable {
        open var last_type : String
        private var _date : Date?
        open var date : String {
            get {
                return _date != nil ? "Applied" : "Not Applied"
            } set {
                let new = Date()
                _date = new.dateFrom(utcString: newValue)
            }
        }
        open var _logged_in = Bool()
        open var logged_in : String {
            get {
                return _logged_in ? "yes" : "no"
            } set {
                _logged_in = newValue.toBool()
            }
        }
    }
    
    private var _created : Date?
    open var created : String {
        get {
            return _created != nil ? "Applied" : "Not Applied"
        } set {
            let new = Date()
            _created = new.dateFrom(utcString: newValue)
        }
    }
    
    open var profile : ProfileInfo
    open class ProfileInfo : Decodable {
        open var message : String?
        open var _needsUpdate = Bool()
        open var email : String
        open var gender : String?
        open var needsUpdate : String {
            get {
                return _needsUpdate ? "yes" : "no"
            } set {
                _needsUpdate = newValue.toBool()
            }
        }
        open var info : Info
        open class Info : Decodable {
            open var firstname : String?
            open var gender : String?
            open var age : Double?
            private var _dob : Date?
            open var dob : String? {
                get {
                    return _dob != nil ? "Applied" : "Not Applied"
                } set {
                    if let newv = newValue {
                        let new = Date()
                        _dob = new.dateFrom(utcString: newv)
                    }
                }
            }
        }
        open var tos : Terms
        open class Terms : Decodable {
            open var spotit : Object
            open var stripe : Object
            open class Object : Decodable {
                open var _value = Bool()
                open var value : String {
                    get {
                        return _value ? "yes" : "no"
                    } set {
                        _value = newValue.toBool()
                    }
                }
                open var version : String
            }
        }
        open var devices : Devices?
        open class Devices : Decodable {
            open var id : String
            open var info : DevInfo
            open class DevInfo : Decodable {
                open var os : String
                open var version : String
                open var model : String
            }
        }
        open var contact : ContactInfo
        open class ContactInfo : Decodable {
            open var cell : String
            open var language : String
        }
    }
    
    public var packet : BasicSecPacket?

}


extension String {
    
    public func toBool() -> Bool {
        let low = self.lowercased() as NSString
        return low.boolValue
    }
    
}
