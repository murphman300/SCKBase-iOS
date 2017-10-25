//
//  SecurityPacket.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-10-25.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

// TODO : Apply the proper methods here....

public protocol SecurePacketHandler {
    func handleValue() -> ((String)->())?
}

open class BasicSecPacket : Decodable {
    
    fileprivate var _pad : String? {
        didSet {
            guard let handler = self.manipulatePadOnSet(), let exec = handler.handleValue(), let value = self._pad else { return }
            exec(value)
        }
    }
    
    fileprivate var _key : String? {
        didSet {
            guard let handler = self.manipulateIDOnSet(), let exec = handler.handleValue(), let value = self._key else { return }
            exec(value)
        }
    }
    
    fileprivate var _id : String? {
        didSet {
            guard let handler = self.manipulatePadOnSet(), let exec = handler.handleValue(), let value = self._id else { return }
            exec(value)
        }
    }
    
    public var pad : String {
        get {
            return _pad != nil ? "Applied" : "Not Applied"
        } set {
            _pad = newValue
        }
    }
    
    public var key : String {
        get {
            return _key != nil ? "Applied" : "Not Applied"
        } set {
            _key = newValue
        }
    }
    
    public var id : String {
        get {
            return _id != nil ? "Applied" : "Not Applied"
        } set {
            _id = newValue
        }
    }
    
    open func manipulatePadOnSet() -> SecurePacketHandler? {
        return nil
    }
    
    open func manipulateIDOnSet() -> SecurePacketHandler? {
        return nil
    }
    
    open func manipulateKeyOnSet() -> SecurePacketHandler?{
        return nil
    }
    
}
