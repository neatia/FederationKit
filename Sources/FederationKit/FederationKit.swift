//
//  FederationKit.swift
//  
//
//  Created by PEXAVC on 7/11/23.
//

import Foundation
import LemmyKit

public class FederationKit {
    public static var current: Federation = .init()
    
    public static func initialize(_ server: FederationServer) {
        current.set(server)
    }
    
    public static var host: String {
        current.currentServer?.host ?? ""
    }
    
    static func sanitize(_ base: String) -> (host: String?, baseUrl: String?) {
        let hasHttp: Bool = base.lowercased().range(of: "http")?.isEmpty == false
        let value: String = (hasHttp ? "" : "https://") + base
        let host: String = value.host
        let url: String = "https://" + host
        
        return (host, url)
    }
}

//MARK: helpers

public extension FederationKit {
    static var currentInstanceType: FederatedInstanceType {
        return current.currentInstanceType
    }
    
    static var currentServer: FederationServer? {
        return current.currentServer
    }
        
    //TODO:
    static func isAuthenticated(for server: FederationServer? = nil) -> Bool {
        return current.isAuthenticated(for: server)
    }
    
    static func auth(for server: FederationServer? = nil) -> String? {
        guard let server = server ?? current.currentServer else  { return nil }
        return current.auth(for: server)
    }
    
    static func setAuth(_ token: String, user resource: UserResource) {
        current.setAuth(token, user: resource)
    }
    
    static func user(for server: FederationServer? = nil) -> FederationUser? {
        guard let server = server ?? current.currentServer else  { return nil }
        return current.user(for: server)
    }

    static func logout(for server: FederationServer? = nil) {
        guard let server = server ?? current.currentServer else  { return }
        current.logout(for: server)
    }
    
    static func isMe(_ person: FederatedPerson) -> Bool {
        current.isMe(person)
    }
    
    static func isHome(_ person: FederatedPerson? = nil) -> Bool {
        current.isHome(person)
    }
    
    static func canInteract(_ host: String?) -> Bool {
        guard current.currentUser != nil else { return false }
        return current.currentUser?.host == host
    }
    
    static func addUser(_ user: FederationUser) {
        current.addUser(user.resource)
    }
    
    static func metadata(for server: FederationServer? = nil) -> FederationMetadata? {
        guard let server = server ?? current.currentServer else  { return nil }
        return current.metadata(for: server)
    }
}
