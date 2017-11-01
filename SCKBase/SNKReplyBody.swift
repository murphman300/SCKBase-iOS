//
//  SNKReplyBody.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-10-27.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

open class SNKReplyBody<T : Decodable> : SNKURLResponse {
    public var resultCode: Double
    public var message: String
    public let result : T
    public enum Keys: String, CodingKey {
        case resultCode = "resultCode"
        case message = "message"
        case result = "result"
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.resultCode = try container.decode(Double.self, forKey: .resultCode)
        self.message = try container.decode(String.self, forKey: .message)
        self.result = try container.decode(T.self, forKey: .result)
    }
}
