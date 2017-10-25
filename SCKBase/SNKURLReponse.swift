//
//  SNKURLReponse.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-10-25.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation


public protocol SNKURLResponse : Decodable {
    
    var code : Int { get set }
    var message : String { get set }
    
}

open class BadURLResponse : SNKURLResponse {
    
    public var code: Int
    
    public var message: String
    
    init(code : Int, message: String) {
        self.code = code
        self.message = message
    }
    
}
