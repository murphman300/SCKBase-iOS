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

public protocol SecurityPacketDelegate {
    func handlePad() -> SecurePacketHandler?
    func handleKey() -> SecurePacketHandler?
    func handleID() -> SecurePacketHandler?
}

open class BasicSecPacket : Decodable {
    
    public var delegate : SecurityPacketDelegate? {
        didSet {
            guard let del = self.delegate else { return }
            if let padExec = del.handlePad(), let handle = padExec.handleValue(), let value = self._pad {
                handle(value)
            }
            if let padExec = del.handleID(), let handle = padExec.handleValue(), let value = self._id {
                handle(value)
            }
            if let padExec = del.handleKey(), let handle = padExec.handleValue(), let value = self._key {
                handle(value)
            }
        }
    }
    
    fileprivate var _pad : String?
    
    fileprivate var _key : String?
    
    fileprivate var _id : String?
    
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
    
    enum Keys : String, CodingKey {
        case pad = "pad"
        case key = "key"
        case id = "id"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.pad = try container.decode(String.self, forKey: .pad)
        self.key = try container.decode(String.self, forKey: .key)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    private func applyDelegate() {
        
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
