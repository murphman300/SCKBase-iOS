//
//  SpotitLinkers.swift
//  SCKBase
//
//  Created by Jean-Louis Murphy on 2017-05-22.
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//

import Foundation

let ENVIRONMENT_VAR : String = "test"

var ENVIRONMENT_VERSION_STATE : String {
    get {
        var comps = Connections.node.api.version.components(separatedBy: ".")
        guard let state = Int("\(comps[1])") else {
            return ""
        }
        _ = comps.remove(at: 0)
        _ = comps.remove(at: 0)
        let t = comps.reduce("", {$0 + $1})
        guard state >= 5 else {
            return " - ALPHA .\(t)"
        }
        guard state > 5 else {
            return " - BETA .\(t)"
        }
        return ""
    }
}

class Connections {
    
    static let node = Connections()
    
    static var api_version = String()
    
    var api = Api()
    
    private struct servers {
        
        static let localDev : String = "http://192.168.2.208:3000"
        
        static let publicDev : String = "https://spotitbackendnode.herokuapp.com"
        
        static let production : String = ""
        
    }
    
    private struct paymentNode {
        
        static let localDev : String = "http://192.168.2.208:3000"
        
        static let publicDev : String = "https://spotitcheckoutpaymentnode.herokuapp.com"
        
        static let production : String = "https://spotitcheckoutpaymentnode.herokuapp.com"
    }
    
    
    var root : String {
        get {
            
            guard ENVIRONMENT_VAR != "development" else {
                return servers.localDev + "/api"
            }
            
            guard ENVIRONMENT_VAR != "test" else {
                return servers.publicDev + "/api"
            }
            
            guard ENVIRONMENT_VAR != "production" else {
                return servers.production + "/api"
            }
            
            return "No root configured"
            
        }
    }
    
    var paymentRoot: String {
        get {
            guard ENVIRONMENT_VAR != "development" else {
                return paymentNode.localDev + "/central/payment"
            }
            
            guard ENVIRONMENT_VAR != "test" else {
                return paymentNode.publicDev + "/central/payment"
            }
            
            guard ENVIRONMENT_VAR != "production" else {
                return paymentNode.production + "/central/payment"
            }
            
            return "No root configured"
        }
    }
    
    
    static var root_version : String {
        get {
            
            guard ENVIRONMENT_VAR != "test" else {
                return servers.localDev + "/api_version/get"
            }
            
            guard ENVIRONMENT_VAR != "development" else {
                return servers.publicDev + "/api_version"
            }
            
            guard ENVIRONMENT_VAR != "production" else {
                return servers.publicDev + "/api_version"
            }
            
            return "No root configured"
            
        }
    }
    
    class Api {
        var version = String()
        func configure() {
            versionGet { (v) in
                guard let vers = v else {
                    return
                }
                Connections.api_version = vers
            }
        }
        
        private func versionGet(_ comp : @escaping(_ vers: String?) -> Void) {
            guard let re = URL(string: "") else {
                return
            }
            do {
                let request = try DefaultRequest(url: "", method: .get, authToken: "request_versionType_Spotit_App", empToken: nil, payload: nil)
                request.addValue("spotit2016", forHTTPHeaderField: "Reciever_String")
                DefaultNetwork.operation.perform(request: request, { (code, message, body, other, array) in
                    guard code == 200 else {
                        comp(nil)
                        return
                    }
                    guard let vers = body["version"] as? String else {
                        comp(nil)
                        return
                    }
                    self.version = vers
                    comp(vers)
                }, { (reason) in
                    comp(nil)
                })
            } catch {
                comp(nil)
            }
        }
    }
}
