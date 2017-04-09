//
//  Environment.swift
//  Spotit
//
//  Created by Jean-Louis Murphy on 2017-03-10.
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
    
    
    var root : String {
        get {
            
            guard ENVIRONMENT_VAR != "development" else {
                return servers.localDev + "/api"
            }
            
            guard ENVIRONMENT_VAR != "test" else {
                return servers.publicDev + "/api"
            }
            
            guard ENVIRONMENT_VAR != "production" else {
                return servers.publicDev + "/api"
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
            let request = NSMutableURLRequest(url: re)
            request.httpBody = nil
            request.addValue("bearer : request_versionType_Spotit_App", forHTTPHeaderField: "authorization")
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("spotit2016", forHTTPHeaderField: "Reciever_String")
            URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                guard error == nil else {
                    comp(nil)
                    return
                }
                guard let d = data else {
                    comp(nil)
                    return
                }
                d.parseResonse({ (resp) in
                    guard let r = resp else {
                        comp(nil)
                        return
                    }
                    guard r.resultCode == 200 else {
                        comp(nil)
                        return
                    }
                    
                    guard let vers = r.body["version"] as? String else {
                        comp(nil)
                        return
                    }
                    self.version = vers
                    comp(vers)
                })
                }.resume()
        }
    }
}
