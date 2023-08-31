//
//  Federation.swift
//  
//
//  Created by PEXAVC on 5/12/23.
//

import Foundation
import Combine
import LemmyKit

public class Federation {
    static var shared: Federation {
        FederationKit.current
    }
    
    public var getSiteTask: Task<Void, Error>? = nil
    public var siteLoaded: Bool = false
    
    //The keys are always the `host (domain)` variable of FederationServer
    private var metadatas: [String: FederationMetadata] = [:]
    private var servers: [String:FederationServer] = [:]
    //For now clients should handle multiple users per domain,
    //while this kit handles a single authentication per domain (not per instanceType)
    private var users: [String:FederationUser] = [:]
    private var auths: [String:String] = [:]
    
    internal var currentServer: FederationServer? = nil
    
    public init(_ server: FederationServer) {
        var mutableServer = server
        if mutableServer.isOnline == false {
            mutableServer.connect()
        }
        servers[server.host] = mutableServer
        self.currentServer = mutableServer
    }
    
    public convenience init(_ type: FederatedInstanceType, baseUrl: String) {
        let server: FederationServer = .init(type, host: baseUrl)
        self.init(server)
    }
    
    public init() {}
    
    /*
     When managing multiple "sites" from
     many instances, it might be best to
     use combine to manage site/metadata/user
     updates in each
     */
    public func getSite(_ server: FederationServer? = nil) {
        guard let server = server ?? currentServer else { return }
        getSiteTask?.cancel()
        getSiteTask = Task {
            let site = await Lemmy.site()
            
            update(site: site?.federated, for: server)
        }
    }
    public static func getSite(_ server: FederationServer? = nil) {
        shared.getSite(server)
    }
    
    internal func update(site: FederatedSiteResult?, for server: FederationServer) {
        if let site {
            if let resource = site.my_user {
                self.users[server.host] = .init(resource: resource, host: server.host)
            }
            
            self.metadatas[server.host] = .init(siteView: site.site_view)
        }
        
        getSiteTask = nil
        siteLoaded = true
    }
    
    /*
     If a client setups up account profiles
     */
    public func addUser(_ resource: UserResource) {
        let host = resource.user.person.actor_id.host
        FederationLog("Adding user: \(resource.user.person.username) for host: \(host)")
        servers[host] = .init(resource.instanceType, host: host)
        servers[host]?.connect()
        self.users[host] = .init(resource: resource, host: host)
    }
    
    func isMe(_ person: FederatedPerson, includeAll: Bool = false) -> Bool {
        let host = includeAll ? person.actor_id.host : (currentServer?.host ?? "")        
        return self.users[host]?.resource.user.person.equals(person) == true
    }
    
    public func user(for server: FederationServer? = nil) -> FederationUser? {
        guard let server = server ?? currentServer else { return nil }
        return self.users[server.host]
    }
    
    public func metadata(for server: FederationServer? = nil) -> FederationMetadata? {
        guard let server = server ?? currentServer else { return nil }
        return self.metadatas[server.host]
    }
    
    public func setAuth(for server: FederationServer, token: String) {
        self.auths[server.host] = token
    }
    
    public func auth(for server: FederationServer) -> String? {
        return self.auths[server.host]
    }
    
    public func isAuthenticated(for server: FederationServer) -> Bool {
        self.auths[server.host] != nil
    }
    
    public func logout(for server: FederationServer) {
        self.auths[server.host] = nil
    }
    
    public var currentInstanceType: FederatedInstanceType {
        currentServer?.type ?? .unknown
    }
    
    //TODO:
    public static func isBlocked(_ person: FederatedPersonResource) -> Bool {
        return false
    }
}
