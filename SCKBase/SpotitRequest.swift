//
//  SpotitRequest.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-10-25.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

@objc public protocol AssignableNetwork {
    @objc optional var root : String? { get }
}

@objc public protocol UserEndPoint : AssignableNetwork {
    @objc optional var userLogin : String? { get }
}

open class SpotitRequest : DefaultRequest, UserEndPoint {
    
    convenience public init(email:String, password: String) throws {
        if email.isEmpty || password.isEmpty {
            throw DefaultRequestError.badPayload(["Invalid" : "Email & Pass"])
        }
        var payload : [String: Any]? = [:]
        if email.contains("reviewer") {
            payload = ["email" : email, "password" : password, "info" : "reviewer"]
        } else {
            payload = ["email" : email, "password" : password]
        }
        do {
            self.init()
            let json = try JSONSerialization.data(withJSONObject: payload!, options: .prettyPrinted)
            guard let jsonOb = try JSONSerialization.jsonObject(with: json, options: .mutableLeaves) as? [String:Any] else {
                throw DefaultRequestError.badPayload(payload!)
            }
            httpBody = json
        } catch {
            throw DefaultRequestError.badPayload(payload!)
        }
    }
    
    //TODO : Make sure the facebook init sets the right headers
    convenience public init(facebookToken: String) throws {
        self.init()
        addValue("@socialnet", forHTTPHeaderField: "tokentype")
        addValue("Facebook : \(facebookToken)", forHTTPHeaderField: "Authorization")
    }
    
    open func login(_ completion: @escaping (UserLoginResponse)->(),_ reason: @escaping (_ response: SNKURLResponse) -> ()) {
        guard value(forHTTPHeaderField: "tokenType") == nil else {
            reason(BadURLResponse(code: 5000, message: "Bad Process : Trying to login with EmailPass with a Facebook Token"))
            return
        }
        guard let url = realURL(forPath: userLogin) else {
            reason(BadURLResponse(code: 5000, message: "Missing Key URL Components for Login"))
            return
        }
        self.url = url
        addValue("@emailpass", forHTTPHeaderField: "tokenType")
        httpMethod = httpMet.post.rawValue
        URLSession.shared.dataTask(with: self as URLRequest, completionHandler: { (d, response, err) in
            if let e = err {
                reason(BadURLResponse(code: 3000, message: e.localizedDescription))
            }
            guard let data = d else {
                reason(BadURLResponse(code: 2000, message: "No Data"))
                return
            }
            do {
                completion(try JSONDecoder().decode(UserLoginResponse.self, from: data))
            } catch let err {
                reason(BadURLResponse(code: 5000, message: err.localizedDescription))
            }
        }).resume()
    }
    
    open func signup(_ completion: @escaping (UserLoginResponse)->(),_ reason: @escaping (_ response: SNKURLResponse) -> ()) {
        guard value(forHTTPHeaderField: "tokenType") == nil else {
            reason(BadURLResponse(code: 5000, message: "Bad Process : Trying to SignUp with EmailPass with a Facebook Token"))
            return
        }
        guard let url = realURL(forPath: userLogin) else {
            reason(BadURLResponse(code: 5000, message: "Missing Key URL Components for Login"))
            return
        }
        self.url = url
        addValue("@emailpasssignup", forHTTPHeaderField: "tokenType")
        httpMethod = httpMet.post.rawValue
        URLSession.shared.dataTask(with: self as URLRequest, completionHandler: { (d, response, err) in
            if let e = err {
                reason(BadURLResponse(code: 3000, message: e.localizedDescription))
            }
            guard let data = d else {
                reason(BadURLResponse(code: 2000, message: "No Data"))
                return
            }
            do {
                completion(try JSONDecoder().decode(UserLoginResponse.self, from: data))
            } catch let err {
                reason(BadURLResponse(code: 5000, message: err.localizedDescription))
            }
        }).resume()
    }
    
    open func facebook(_ completion: @escaping (UserLoginResponse)->(),_ reason: @escaping (_ response: SNKURLResponse) -> ()) {
        guard value(forHTTPHeaderField: "tokenType") != nil else {
            reason(BadURLResponse(code: 5000, message: "Bad Process : Trying to Login with Facebook with Type Already Present"))
            return
        }
        self.url = realURL(forPath: userLogin)
        httpMethod = httpMet.get.rawValue
        URLSession.shared.dataTask(with: self as URLRequest, completionHandler: { (d, response, err) in
            if let e = err {
                reason(BadURLResponse(code: 3000, message: e.localizedDescription))
            }
            guard let data = d else {
                reason(BadURLResponse(code: 2000, message: "No Data"))
                return
            }
            do {
                completion(try JSONDecoder().decode(UserLoginResponse.self, from: data))
            } catch let err {
                reason(BadURLResponse(code: 5000, message: err.localizedDescription))
            }
        }).resume()
    }
    
    private func realURL(forPath: String?) -> URL? {
        guard let r = root, let suffix = forPath else { return nil }
        return URL(string: r + suffix)
    }
    
    public var root: String? {
        get {
            return nil
        }
    }
    
    public var userLogin: String? {
        get {
            return nil
        }
    }
    
}

