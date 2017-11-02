//
//  SNKURLReponse.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-10-25.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation


public protocol SNKURLResponse : Decodable {
    
    var resultCode : Double { get set }
    var message : String { get set }
    
}

open class BadURLResponse : SNKURLResponse {
    
    public var resultCode: Double
    
    public var message: String
    
    public init(code : Double, message: String) {
        self.resultCode = code
        self.message = message
    }
    
}

