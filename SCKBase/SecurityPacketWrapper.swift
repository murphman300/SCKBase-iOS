//
//  SecurityPacketWrapper.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-11-02.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

public protocol SecurityPipelineWrapper {
    func pipeForKey() -> KeyPacketHandler?
    func pipeForID() -> IDPacketHandler?
    func pipeForPad() -> PadPacketHandler?
}

public class SecurityPacketWrapper : SecurityPacketDelegate {
    
    public var pipeLine : SecurityPipelineWrapper?
    
    public func handleID() -> SecurePacketHandler? {
        return pipeLine != nil ? pipeLine!.pipeForID() : nil
    }
    
    public func handleKey() -> SecurePacketHandler? {
        return pipeLine != nil ? pipeLine!.pipeForKey() : nil
    }
    
    public func handlePad() -> SecurePacketHandler? {
        return pipeLine != nil ? pipeLine!.pipeForPad() : nil
    }
    
}

open class IDPacketHandler : SecurePacketHandler {
    open func handleValue() -> ((String) -> ())? {
        return nil
    }
}

open class KeyPacketHandler : SecurePacketHandler {
    open func handleValue() -> ((String) -> ())? {
        return nil
    }
}

open class PadPacketHandler : SecurePacketHandler {
    open func handleValue() -> ((String) -> ())? {
        return nil
    }
}
