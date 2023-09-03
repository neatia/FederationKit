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
    internal var servers: [String:FederationServer] = [:]
    //For now clients should handle multiple users per domain,
    //while this kit handles a single authentication per domain (not per instanceType)
    private var users: [String:FederationUser] = [:]
    internal var auths: [String:String] = [:]
    
    internal var currentServer: FederationServer? = nil
    
    //TODO: Should this be UserResource or FederationUser?
    internal var currentUser: FederationUser? = nil
    
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
        if let existingServer = servers[server.host] {
            //expected to have authentication if switching from and to
            self.currentServer = existingServer
        } else {
            self.currentServer = add(server)
        }
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
                self.users[server.host] = .init(resource, host: server.host)
            }
            
            self.metadatas[server.host] = .init(siteView: site.site_view)
        }
        
        getSiteTask = nil
        siteLoaded = true
    }
    
    //MARK: Users
    public func addUser(_ resource: UserResource, auth token: String? = nil) {
        let host = resource.user.person.actor_id.host
        FederationLog("Adding user: \(resource.user.person.username) for host: \(host)")
        servers[host] = .init(resource.instanceType, host: host)
        servers[host]?.connect()
        self.users[host] = .init(resource)
        
        if let token {
            auths[host] = token
            servers[host]?.updateAuth(auth: token, user: resource)
        }
    }
    
    public func setUser(_ resource: UserResource, auth token: String? = nil) {
        self.addUser(resource, auth: token)
        
        if let token,
           currentServer?.host == resource.host {
            currentServer?.updateAuth(auth: token, user: resource)
        }
        
        self.currentUser = .init(resource)
    }
    
    func isMe(_ person: FederatedPerson, includeAll: Bool = false) -> Bool {
        if includeAll {
            return self.users[person.actor_id.host]?.resource.user.person.equals(person) == true
        } else {
            return self.currentUser?.resource.user.person.equals(person) == true
        }
    }
    
    func isHome(_ person: FederatedPerson? = nil) -> Bool {
        let resource = self.users[person?.actor_id.host ?? ""]
        return (resource ?? currentUser)?.host == currentServer?.host
    }
    
    public func user(for server: FederationServer? = nil) -> FederationUser? {
        guard let server = server ?? currentServer,
              let user = server.currentUser else { return nil }
        return .init(user, host: server.host)
    }
    
    //MARK: metadata
    public func metadata(for server: FederationServer? = nil) -> FederationMetadata? {
        guard let server = server ?? currentServer else { return nil }
        return self.metadatas[server.host]
    }
    
    public func server(for host: String) -> FederationServer? {
        return servers[host]
    }
    
    public func setAuth(_ token: String, user resource: UserResource) {
        addUser(resource, auth: token)
        
        let host = resource.host
        
        if host == currentServer?.host {
            currentServer?.updateAuth(auth: token, user: resource)
        }
        currentUser = .init(resource)
    }
    
    public func auth(for server: FederationServer) -> String? {
        return self.auths[server.host]
    }
    
    public func isAuthenticated(for server: FederationServer? = nil) -> Bool {
        if let server {
            return auth(for: server) != nil
        } else {
            return currentUser != nil
        }
    }
    
    public func logout(for server: FederationServer) {
        self.auths[server.host] = nil
        self.servers[server.host]?.removeAuth()
        if server.host == currentServer?.host {
            currentServer?.removeAuth()
        }
        
        if server.host == currentUser?.host {
            self.currentUser = nil
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
