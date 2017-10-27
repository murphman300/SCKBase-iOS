//
//  LoginResponseObject-User.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-10-25.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

public enum LoginFollowUpAction {
    case login
    case newAccount
}

open class UserLoginResponse : SNKURLResponse {
    enum Keys : String, CodingKey {
        case resultCode = "resultCode"
        case message = "message"
        case result = "result"
    }
    enum UserLoginError : Error{
        case failed(String)
    }
    public var resultCode: Double
    public var message: String
    public let result : LoginResult
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.resultCode = try container.decode(Double.self, forKey: .resultCode)
        self.message = try container.decode(String.self, forKey: .message)
        if container.contains(.result) {
            self.result = try container.decode(LoginResult.self, forKey: .result)
        } else {
            throw UserLoginError.failed("\(self.resultCode) : \(self.message)")
        }
    }
    public func isReviewer() -> Bool{
        return result.info.isReviewer
    }
    public func loginOrNewAccount() -> LoginFollowUpAction {
        return message == "User Created" ? LoginFollowUpAction.newAccount : LoginFollowUpAction.login
    }
}

public enum LoggedInWith {
    case EmailPassword
    case Facebook
    case NotLoggedIn
}

public enum LoginResultError : Error {
    case failedToCastCreate
    case loginTypeTypeNotValid
}

open class LoginResult : Decodable {
    
    open var created : Date
    open var info : ProfileInfo
    open var token : String
    public let packet : BasicSecPacket
    open var needsUpdate : Bool
    public let auth : AuthenticationMethod
    
    public enum AuthenticationMethod : String {
        case SMS = "Expect SMS token"
        case Email = "Expect Email"
        case None = ""
    }
    
    
    enum Keys : String, CodingKey {
        case token = "token"
        case created = "created"
        case info = "info"
        case packet = "packet"
        case auth = "auth"
        case needsUpdate = "needsUpdate"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let createdString = try container.decode(String.self, forKey: .created)
        if let date = Date().dateFrom(utcString: createdString) {
            self.created = date
        } else {
            throw LoginResultError.failedToCastCreate
        }
        self.info = try container.decode(ProfileInfo.self, forKey: .info)
        self.token = try container.decode(String.self, forKey: .token)
        let updateString = try container.decode(String.self, forKey: .needsUpdate)
        self.needsUpdate = updateString.toBool()
        self.packet = try container.decode(BasicSecPacket.self, forKey: .packet)
        if container.contains(.auth), let type = AuthenticationMethod(rawValue : try container.decode(String.self, forKey: .auth)) {
            self.auth = type
        } else {
            self.auth = AuthenticationMethod.None
        }
    }
    
    public var loggedInWith : LoggedInWith {
        return self.info.login_type .last_type.toWith()
    }
    
}

open class ProfileInfo : Decodable {
    
    public let email : String
    public let login_type : LoginType
    public let isReviewer : Bool
    public let needsUpdateToComplete : Bool
    public let tos : Terms
    public let gender : String?
    public let firstname : String?
    public let lastname : String?
    public let dob : Date?
    public let age : Double?
    public let devices : DevicesObject?
    public let contact : ContactInfo?
    public let count : Int?
    
    public enum Keys : String, CodingKey {
        case firstname = "firstname"
        case lastname = "lastname"
        case gender = "gender"
        case age = "age"
        case dob = "dob"
        case email = "email"
        case isReviewer = "isReviewer"
        case tos = "tos"
        case contact = "contact"
        case devices = "devices"
        case count = "count"
        case login_type = "login_type"
        case needsUpdateToComplete = "needsUpdateToComplete"
    }
    
    public required init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.email = try container.decode(String.self, forKey: .email)
        self.login_type = try container.decode(LoginType.self, forKey: .login_type)
        self.tos = try container.decode(Terms.self, forKey: .tos)
        if container.contains(.needsUpdateToComplete) {
            let updateString = try container.decode(String.self, forKey: .needsUpdateToComplete)
            self.needsUpdateToComplete = updateString.toBool()
        } else {
            self.needsUpdateToComplete = false
        }
        if container.contains(.isReviewer) {
            let updateString = try container.decode(String.self, forKey: .isReviewer)
            self.isReviewer = updateString.toBool()
        } else {
            self.isReviewer = false
        }
        
        if container.contains(.count) {
            self.count = try container.decode(Int.self, forKey: .count)
        } else {
            self.count = nil
        }
        if container.contains(.firstname) {
            self.firstname = try container.decode(String.self, forKey: .firstname)
        } else {
            self.firstname = nil
        }
        if container.contains(.lastname) {
            self.lastname = try container.decode(String.self, forKey: .lastname)
        } else {
            self.lastname = nil
        }
        if container.contains(.gender) {
            self.gender = try container.decode(String.self, forKey: .gender)
        } else {
            self.gender = nil
        }
        if container.contains(.dob) {
            let thisdob = try container.decode(String.self, forKey: .dob)
            if let date = Date().dateFrom(utcString: thisdob) {
                self.dob = date
            } else {
                throw LoginResultError.failedToCastCreate
            }
        } else {
            self.dob = nil
        }
        if container.contains(.age) {
            self.age = try container.decode(Double.self, forKey: .age)
        } else {
            self.age = nil
        }
        if container.contains(.contact) {
            self.contact = try container.decode(ContactInfo.self, forKey: .contact)
        } else {
            self.contact = nil
        }
        if container.contains(.devices) {
            self.devices = try container.decode(DevicesObject.self, forKey: .devices)
        } else {
            self.devices = nil
        }
    }
    
}



open class LoginType : Decodable {
    public enum LastTypes : String {
        case social = "facebook"
        case password = "password"
        public func toWith() -> LoggedInWith {
            switch self {
            case .password:
                return LoggedInWith.EmailPassword
            case .social:
                return LoggedInWith.Facebook
            }
        }
    }
    enum Keys : String, CodingKey {
        case last_type = "last_type"
        case date = "date"
        case logged_in = "logged_in"
    }
    open var last_type : LastTypes
    open var date : Date
    open var logged_in : Bool
    public required init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.logged_in = try container.decode(String.self, forKey: .logged_in).toBool()
        let last = try container.decode(String.self, forKey: .last_type)
        if let type = LastTypes(rawValue: last) {
            self.last_type = type
        } else {
            throw LoginResultError.loginTypeTypeNotValid
        }
        let createdString = try container.decode(String.self, forKey: .date)
        if let date = Date().dateFrom(utcString: createdString) {
            self.date = date
        } else {
            throw LoginResultError.failedToCastCreate
        }
    }
}

open class Terms : Decodable {
    open var spotit : Object
    open var stripe : Object
    enum Keys : String, CodingKey {
        case spotit = "spotit"
        case stripe = "stripe"
    }
    public required init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.spotit = try container.decode(Object.self, forKey: .spotit)
        self.stripe = try container.decode(Object.self, forKey: .stripe)
    }
    open class Object : Decodable {
        open var value : Bool
        open var version : String
        enum Keys : String, CodingKey {
            case value = "value"
            case version = "version"
        }
        public required init(from decoder : Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            self.value = try container.decode(String.self, forKey: .value).toBool()
            self.version = try container.decode(String.self, forKey: .version)
        }
    }
}

open class DevicesObject : Decodable {
    open var id : String
    open var info : DevInfo
    open class DevInfo : Decodable {
        open var os : String
        open var version : String
        open var model : String
    }
}

open class ContactInfo : Decodable {
    open var cell : String
    open var language : String
}

extension String {
    
    public func toBool() -> Bool {
        let low = self.lowercased() as NSString
        return low.boolValue
    }
    
}

