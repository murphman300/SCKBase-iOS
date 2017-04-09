//
//  DataExtensions.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-04-09.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

import Foundation

/// Hash functions to calculate Digest.

extension NSMutableData {
    
    func appendString(string: String) {
        guard let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
            return
        }
        append(data)
    }
}

extension Data {
    
    public var bytes: Array<UInt8> {
        return Array(self)
    }
    
    public func toHexString() -> String {
        return self.bytes.toHexString()
    }
}

public protocol CSArrayType: Collection, RangeReplaceableCollection {
    func cs_arrayValue() -> [Iterator.Element]
}

extension Array: CSArrayType {
    
    public func cs_arrayValue() -> [Iterator.Element] {
        return self
    }
}

public extension CSArrayType where Iterator.Element == UInt8 {
    
    public func toHexString() -> String {
        return self.lazy.reduce("") {
            var s = String($1, radix: 16)
            if s.characters.count == 1 {
                s = "0" + s
            }
            return $0 + s
        }
    }
}

extension Data {
    
    func parseOmnigateResponse(_ completion: @escaping(OmnigateResponse?) -> Void) {
        var rest : [String:Any]?
        do {
            let j = try JSONSerialization.jsonObject(with: self, options: .mutableLeaves) as? [String:Any]
            guard let json = j else {
                completion(nil)
                return
            }
            guard let code = json["code"] as? Int else {
                completion(nil)
                return
            }
            guard let message = json["resultmessage"] as? String else {
                completion(nil)
                return
            }
            guard json.count <= 2 else {
                rest = [String: Any]()
                for (key, value) in json {
                    if key != "resultcode" || key != "resultcode" {
                        rest?["\(key)"] = value
                    }
                }
                let r = OmnigateResponse()
                r.resultMessage = message
                r.resultCode = code
                if let re = rest {
                    r.body = re
                }
                completion(r)
                return
            }
            let r = OmnigateResponse()
            r.resultMessage = message
            r.resultCode = code
            completion(r)
        } catch {
            completion(nil)
        }
    }
    
    func parseResonse(_ completion: @escaping(OmnigateResponse?) -> Void) {
        var rest : [String:Any]?
        do {
            let j = try JSONSerialization.jsonObject(with: self, options: .mutableLeaves) as? [String:Any]
            
            guard let json = j else {
                completion(nil)
                return
            }
            guard let code = json["resultCode"] as? Int else {
                completion(nil)
                return
            }
            guard let message = json["message"] as? String else {
                completion(nil)
                return
            }
            guard let result = json["result"] as? [String:Any] else {
                guard let token = json["token"] as? String else {
                    let r = OmnigateResponse()
                    r.resultMessage = message
                    r.resultCode = code
                    completion(r)
                    return
                }
                let r = OmnigateResponse()
                r.resultMessage = message
                r.resultCode = code
                r.body["token"] = token
                completion(r)
                return
            }
            guard json.count <= 2 else {
                rest = [String: Any]()
                for (key, value) in result {
                    if let v = value as? [String:Any] {
                        rest?["\(key)"] = v
                    } else {
                        rest?["\(key)"] = value
                    }
                }
                let r = OmnigateResponse()
                r.resultMessage = message
                r.resultCode = code
                guard let re = rest else {
                    completion(r)
                    return
                }
                r.body = re
                completion(r)
                return
            }
            let r = OmnigateResponse()
            r.resultMessage = message
            r.resultCode = code
            completion(r)
        } catch {
            completion(nil)
        }
    }
    
    class OmnigateResponse {
        
        var resultCode = Int()
        var resultMessage = String()
        var body = [String:Any]()
        
    }
}

