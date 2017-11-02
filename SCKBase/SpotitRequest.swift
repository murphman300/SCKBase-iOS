//
//  SpotitRequest.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-10-25.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

public enum TokenTypes {
    case fb, spotit, device, generic
    public func authTag() -> String {
        switch self {
        case .fb:
            return "Facebook : "
        case .spotit:
            return "Bearer : "
        case .device:
            return "Device : "
        case .generic:
            return Bundle.main.bundleIdentifier != nil ? Bundle.main.bundleIdentifier! : ""
        }
    }
}

public struct PathPair {
    public let path : String
    public let type : httpMet
    public let auth : TokenTypes
    public init(path: String, type: httpMet, auth: TokenTypes) {
        self.path = path
        self.type = type
        self.auth = auth
    }
}

@objc public protocol AssignableNetwork {
    @objc optional var root : String? { get }
}

@objc public protocol UserEndPoint : AssignableNetwork {
    @objc optional var userLogin : String? { get }
    @objc optional var userBatchUpdate : String? { get }
}

open class SpotitRequest : DefaultRequest, UserEndPoint {
    
    enum TokenCheckError : Error {
        case notImplemented
    }
    
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
            self.init(url: URL(string: "http://localhost:3000")!)
            addValue("application/json", forHTTPHeaderField: "Content-Type")
            let json = try JSONSerialization.data(withJSONObject: payload!, options: [])
            httpBody = json
        } catch {
            throw DefaultRequestError.badPayload(payload!)
        }
    }
    
    //TODO : Make sure the facebook init sets the right headers
    convenience public init(facebookToken: String) throws {
        self.init(url: URL(string: "http://localhost:3000")!)
        addValue("@socialnet", forHTTPHeaderField: "tokentype")
        addValue("Facebook : \(facebookToken)", forHTTPHeaderField: "Authorization")
    }
    
    convenience public init(post: Decodable.Type) throws {
        self.init(url: URL(string: "http://localhost:3000")!)
        addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    convenience public init() {
        self.init(url: URL(string: "http://localhost:3000")!)
        addValue("application/json", forHTTPHeaderField: "Content-Type")
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
            self.handleResponse(d, response, err, completion, reason)
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
        addValue("@emailpasssignup", forHTTPHeaderField: "tokentype")
        httpMethod = httpMet.post.rawValue
        URLSession.shared.dataTask(with: self as URLRequest, completionHandler: { (d, response, err) in
            self.handleResponse(d, response, err, completion, reason)
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
            self.handleResponse(d, response, err, completion, reason)
        }).resume()
    }
    
    open func perform<T>(_ from : T.Type,_ addedPath: PathPair,_ completion: @escaping (T)->(),_ reason: @escaping (_ response: SNKURLResponse) -> ()) where T : Decodable {
        do {
            try setUpCall(addedPath)
            URLSession.shared.dataTask(with: self as URLRequest, completionHandler: { (d, response, err) in
                self.handleResponse(d, response, err, completion, reason)
            }).resume()
        } catch let err as TokenCheckError {
            print(err)
            reason(BadURLResponse(code: 0000, message: err.localizedDescription))
        } catch let err {
            print(err)
            reason(BadURLResponse(code: 0000, message: err.localizedDescription))
        }
    }
    
    private func checkToken(_ source: TokenTypes) throws -> String {
        guard let token = userTokenSource(source) else {
            throw TokenCheckError.notImplemented
        }
        return token
    }
    
    public func handleResponse<T>(_ data: Data?,_ response: URLResponse?,_ err: Error?,_ completion: @escaping (T)->(),_ reason: @escaping (_ response: SNKURLResponse) -> ()) where T : Decodable {
        if let e = err {
            reason(BadURLResponse(code: 3000, message: e.localizedDescription))
        }
        guard let dat = data else {
            reason(BadURLResponse(code: 2000, message: "No Data"))
            return
        }
        do {
            completion(try JSONDecoder().decode(T.self, from: dat))
        } catch let err {
            do {
                reason(try JSONDecoder().decode(BadURLResponse.self, from: dat))
            } catch {
                reason(BadURLResponse(code: 5000, message: err.localizedDescription))
            }
        }
    }
    
    public func setUpCall(_ from: PathPair) throws {
        let token = try checkToken(from.auth)
        addValue(from.auth.authTag() + token, forHTTPHeaderField: "Authorization")
        self.url = realURL(forPath: from.path)
        httpMethod = from.type.rawValue
    }
    
    private func realURL(forPath: String?) -> URL? {
        guard let r = root, let suffix = forPath else { return nil }
        return URL(string: r + suffix)
    }
    
    open var root: String? {
        get {
            return nil
        }
    }
    
    open var userLogin: String? {
        get {
            return nil
        }
    }
    
    open var userBatchUpdate : String? {
        get {
            return nil
        }
    }
    
    open func userTokenSource(_ tokenType: TokenTypes) -> String? {
        return nil
    }
    
}

