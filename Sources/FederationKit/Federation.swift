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
    //TODO: Should this be UserResource or FederationUser?
    internal var currentUser: UserResource? {
        currentServer?.currentUser
    }
    
    public init(_ server: FederationServer) {
        set(server)
    }
    
    @discardableResult
    public func add(_ server: FederationServer) -> FederationServer {
        var mutableServer = server
        if mutableServer.isOnline == false {
            mutableServer.connect()
        }
        servers[server.host] = mutableServer
        
        return mutableServer
    }
    
    public func set(_ server: FederationServer) {
        self.currentServer = add(server)
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
    public func addUser(_ resource: UserResource, auth token: String? = nil) {
        let host = resource.user.person.actor_id.host
        FederationLog("Adding user: \(resource.user.person.username) for host: \(host)")
        servers[host] = .init(resource.instanceType, host: host)
        servers[host]?.connect()
        self.users[host] = .init(resource: resource, host: host)
        
        if let token {
            servers[host]?.updateAuth(auth: token, user: resource)
        }
    }
    
    func isMe(_ person: FederatedPerson, includeAll: Bool = false) -> Bool {
        if includeAll {
            return self.users[person.actor_id.host]?.resource.user.person.equals(person) == true
        } else {
            return self.currentUser?.user.person.equals(person) == true
        }
    }
    
    public func user(for server: FederationServer? = nil) -> FederationUser? {
        guard let server = server ?? currentServer,
              let user = server.currentUser else { return nil }
        return .init(resource: user, host: server.host)
    }
    
    public func metadata(for server: FederationServer? = nil) -> FederationMetadata? {
        guard let server = server ?? currentServer else { return nil }
        return self.metadatas[server.host]
    }
    
    public func setAuth(for server: FederationServer, auth token: String, user resource: UserResource) {
        self.auths[server.host] = token
        self.servers[server.host]?.updateAuth(auth: token, user: resource)
        if server.host == currentServer?.host {
            currentServer?.updateAuth(auth: token, user: resource)
        }
    }
    
    public func auth(for server: FederationServer) -> String? {
        return self.auths[server.host]
    }
    
    public func isAuthenticated(for server: FederationServer) -> Bool {
        server.currentUser != nil || auth(for: server) != nil
    }
    
    public func logout(for server: FederationServer) {
        self.auths[server.host] = nil
        self.servers[server.host]?.removeAuth()
        if server.host == currentServer?.host {
            currentServer?.removeAuth()
        }
    }
    
    public var currentInstanceType: FederatedInstanceType {
        currentServer?.type ?? .unknown
    }
    
    //TODO:
    public static func isBlocked(_ person: FederatedPersonResource) -> Bool {
        return false
    }
}
