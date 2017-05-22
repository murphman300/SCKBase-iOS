//
//  ModalViewInfo.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-05-22.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import UIKit

enum ModalViewInfoInitError : Error {
    
    case missing(String)
    
}

class CheckoutModalInfo {
    var storeName : String
    var by : String?
    var amount : Int
    var recieved = Date()
    var txid : String
    var locid : String
    
    init(from: [String:Any]) throws {
        print(from)
        if let name = from["locname"] as? String {
            storeName = name
        } else {
            throw ModalViewInfoInitError.missing("locname")
        }
        if let name = from["emp_name"] as? String {
            by = name
        }
        if let name = from["amount"] as? Int {
            amount = name
        } else if let name = from["amount"] as? Double {
            amount = Int(name)
        } else if let name = from["amount"] as? String, let value = Int(name){
            amount = value
        } else {
            throw ModalViewInfoInitError.missing("amount")
        }
        if let tx = from["txid"] as? String {
            txid = tx
        } else {
            throw ModalViewInfoInitError.missing("txid")
        }
        if let tx = from["locid"] as? String {
            locid = tx
        } else {
            throw ModalViewInfoInitError.missing("locid")
        }
        recieved = Date()
    }
}
