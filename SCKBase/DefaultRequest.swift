//
//  DefaultRequest.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-05-19.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

enum NSMutableRequestInitializationError : Error {
    case failedToConvertPackage, employeeTokenNotAJWT, invalidURL
}

open class DefaultRequest : NSMutableURLRequest {

    convenience public init(url: String, method: httpMet, authToken: String, empToken: String?, payload: [String:Any]?) throws {
        var ur : URL?
        if let u = URL(string: url) {
            ur = u
        } else {
            throw NSMutableRequestInitializationError.invalidURL
        }
        if let u = ur {
            self.init(url: u)
        } else {
            throw NSMutableRequestInitializationError.invalidURL
        }
        switch method {
        case .get:
            httpMethod = "GET"
        case.post :
            httpMethod = "POST"
        case .delete :
            httpMethod = "DELETE"
        }
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        addValue("Bearer : \(authToken)" , forHTTPHeaderField: "Authorization")
        if let emp = empToken {
            let comps = emp.components(separatedBy: ".")
            if comps.count == 3 {
                addValue(emp , forHTTPHeaderField: "token_accessor")
            } else {
                throw NSMutableRequestInitializationError.employeeTokenNotAJWT
            }
        }
        if let p = payload {
            do {
                let json = try JSONSerialization.data(withJSONObject: p, options: .prettyPrinted)
                httpBody = json
            } catch {
                throw NSMutableRequestInitializationError.failedToConvertPackage
            }
        }
    }
    
    convenience public init(url: String, method: httpMet, authToken: String, locToken: String?, payload: [String:Any]?) throws {
        var ur : URL?
        if let u = URL(string: url) {
            ur = u
        } else {
            throw NSMutableRequestInitializationError.invalidURL
        }
        if let u = ur {
            self.init(url: u)
        } else {
            throw NSMutableRequestInitializationError.invalidURL
        }
        switch method {
        case .get:
            httpMethod = "GET"
        case.post :
            httpMethod = "POST"
        case .delete :
            httpMethod = "DELETE"
        }
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        addValue("Bearer : \(authToken)" , forHTTPHeaderField: "Authorization")
        if let emp = locToken {
            let comps = emp.components(separatedBy: ".")
            if comps.count == 3 {
                addValue(emp , forHTTPHeaderField: "location_accessor")
            } else {
                throw NSMutableRequestInitializationError.employeeTokenNotAJWT
            }
        }
        if let p = payload {
            do {
                let json = try JSONSerialization.data(withJSONObject: p, options: .prettyPrinted)
                httpBody = json
            } catch {
                throw NSMutableRequestInitializationError.failedToConvertPackage
            }
        }
    }
}
