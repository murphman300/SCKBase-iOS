//
//  LoginResponseParser.swift
//  Spotit
//
//  Created by Jean-Louis Murphy on 2017-04-05.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit
/*import SwiftyJSON

public struct LoginResponseParser {
    
    var resultCode : Int
    var resultMessage : String
    var body : [String:Any]?
    var bodyValue : Any?
    var jsonResult : JSON?
    
    init(data: Data) throws {
        let json = JSON(data: data)
        do {
            try self.init(json: json)
        } catch {
            throw LoginResponseParserErrors.dataFailed
        }
    }
    
    init(json: JSON) throws {
        
        if let code = json["resultCode"].int {
            resultCode = code
        } else {
            throw LoginResponseParserErrors.noCode
        }
        if let message = json["message"].string {
            resultMessage = message
        } else {
            throw LoginResponseParserErrors.noMessage
        }
        if let bod = json["result"].dictionaryObject {
            body = bod
        } else if (resultCode == 200 || resultCode >= 300) {
            return
        } else if json["result"].exists() {
            do {
                let data = try JSONSerialization.data(withJSONObject: json["result"].rawValue, options: .prettyPrinted)
                jsonResult = JSON(data: data)
            } catch {
                throw LoginResponseParserErrors.invalidBody
            }
        } else {
            throw LoginResponseParserErrors.invalidBody
        }
    }
    
    enum LoginResponseParserErrors : Error {
        case dataFailed, noCode, noMessage, invalidBody
        
    }
}*/
