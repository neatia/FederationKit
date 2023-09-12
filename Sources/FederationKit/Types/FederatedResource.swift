//
//  FederatedResource.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public protocol FederatedResource {
    var viewableHosts: [String] { get }
    var isBaseResource: Bool { get }
    var isPeerResource: Bool { get }
    func host(for location: FederatedLocationType) -> String
    func location(for host: String) -> FederatedLocationType
}


extension FederatedCommentResource: FederatedResource {
    public var viewableHosts: [String] {
        var hosts: [String] = [FederationKit.host]
        
//        if let baseHost = community.actor_id.host,
//           baseHost != hosts.last {
//            hosts += [baseHost]
//        }
        
//        if let peerHost = creator.actor_id.host,
//           peerHost != hosts.last,
//           peerHost != FederationKit.host {
//            hosts += [peerHost]
//        }
        let peerHost = post.ap_id.host
        if peerHost != hosts.last,
           peerHost != FederationKit.host {
            hosts += [peerHost]
        }
        
        return hosts
    }
    
    public var isBaseResource: Bool {
        FederationKit.host == community.actor_id.host
    }
    
    public var isPeerResource: Bool {
        community.actor_id.host != creator.actor_id.host
    }
    
    public func host(for location: FederatedLocationType) -> String {
        switch location {
        case .base:
            return FederationKit.host
        case .source:
            return community.actor_id.host
        case .peer(let host):
            return host
        }
    }
    
    public func location(for host: String) -> FederatedLocationType {
        if FederationKit.host == host {
            return .base
        } else if community.actor_id.host == host {
            return .source
        } else {
            return .peer(host)
        }
    }
}

extension FederatedPostResource: FederatedResource {
    public var viewableHosts: [String] {
        var hosts: [String] = [FederationKit.host]
        
        //we would need auth to resolve the post to the source community's location
//        if let baseHost = community.actor_id.host,
//           baseHost != hosts.last {
//            hosts += [baseHost]
//        }
        let peerHost = creator.actor_id.host
        if peerHost != hosts.last,
           peerHost != FederationKit.host {
            hosts += [peerHost]
        }
        
        return hosts
    }
    
    public var isBaseResource: Bool {
        FederationKit.host == community.actor_id.host
    }
    
    public var isPeerResource: Bool {
        community.actor_id.host != creator.actor_id.host
    }
    
    public func host(for location: FederatedLocationType) -> String {
        switch location {
        case .base:
            return FederationKit.host
        case .source:
            return community.actor_id.host
        case .peer(let host):
            return host
        }
    }
    
    public func location(for host: String) -> FederatedLocationType {
        if FederationKit.host == host {
            return .base
        } else if community.actor_id.host == host {
            return .source
        } else {
            return .peer(host)
        }
    }
}

extension FederatedCommunityResource: FederatedResource {
    public var viewableHosts: [String] {
        var hosts: [String] = [FederationKit.host]
        
        let baseHost = community.actor_id.host
        if baseHost != hosts.last {
            hosts += [baseHost]
        }
        
        return hosts
    }
    
    public var isBaseResource: Bool {
        FederationKit.host == community.actor_id.host
    }
    
    public var isPeerResource: Bool {
        false
    }
    
    public func host(for location: FederatedLocationType) -> String {
        switch location {
        case .base:
            return FederationKit.host
        case .source:
            return community.actor_id.host
        case .peer(let host):
            return host
        }
    }
    
    public func location(for host: String) -> FederatedLocationType {
        if FederationKit.host == host {
            return .base
        } else if community.actor_id.host == host {
            return .source
        } else {
            return .peer(host)
        }
    }
}

//extension Community {
//    var location: FederatedLocationType {
//        if actor_id.host != FederationKit.host,
//           let peerHost = actor_id.host {
//            if peerHost == community?.ap_id?.host {
//                return .source
//            } else {
//                return .peer(peerHost)
//            }
//        } else {
//            return .base
//        }
//    }
//}

extension FederatedPersonResource: FederatedResource {
    public var viewableHosts: [String] {
        var hosts: [String] = [FederationKit.host]
        
        let baseHost = self.person.actor_id.host
        
        if baseHost != hosts.last {
            hosts += [baseHost]
        }
        
        return hosts
    }
    
    public var isBaseResource: Bool {
        FederationKit.host == person.actor_id.host
    }
    
    public var isPeerResource: Bool {
        false
    }
    
    public func host(for location: FederatedLocationType) -> String {
        switch location {
        case .base:
            return FederationKit.host
        case .source:
            return person.actor_id.host
        case .peer(let host):
            return host
        }
    }
    
    public func location(for host: String) -> FederatedLocationType {
        if FederationKit.host == host {
            return .base
        } else if person.actor_id.host == host {
            return .source
        } else {
            return .peer(host)
        }
    }
}
