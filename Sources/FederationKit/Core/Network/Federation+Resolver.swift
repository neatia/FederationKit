//
//  FetchResolver.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

struct FetchResolver {
    var useBase: Bool
    var actor: String?
    var id: Int?
    var sourceId: Int?
    //communityName
    var name: String?
    
    var auth: String?
    
    var useCommunity: Bool = false
    
    var domain: String? {
        guard let actor else { return nil }
        return FederationKit.sanitize(actor).host
    }
    
    static func fromPerson(_ person: FederatedPerson?,
                           auth: String? = nil,
                           location: FederatedLocationType? = nil,
                           from context: String = "") async -> FetchResolver {
        let resolver: FetchResolver
        
        resolver = .init(useBase: true,
                         actor: person?.actor_id,
                         id: person?.id.asInt)
        
        //print(resolver.description(context, from: "person", location: location ?? .base))
        return resolver
    }
    
    //fetching posts will not use id, relying on properly set community names for federated (peers) and base
    static func fromCommunity(_ community: FederatedCommunity? = nil,
                              id: Int? = nil,
                              name: String? = nil,
                              auth: String? = nil,
                              location: FederatedLocationType? = nil,
                              from context: String = "") async -> FetchResolver {
        let resolver: FetchResolver
        switch location {
        case .source:
            let isBase: Bool = FederationKit.host == community?.actor_id.host
            resolver = .init(useBase: isBase,
                      actor: community?.actor_id,
                      id: nil,
                      name: community?.name)
        case .peer(let host):
            let isBase: Bool = FederationKit.host == host
            let peerName: String? = (community?.name ?? "")+"@"+(community?.actor_id.host ?? "")
            
            resolver = .init(useBase: isBase,
                             actor: host,
                             id: community?.id.asInt,
                             name: isBase ? community?.name : peerName)
        default:
            var community: FederatedCommunity? = community
            var name: String? = community?.name
            var id: Int? = community?.id.asInt
            if let actor_id = community?.actor_id,
               actor_id.host != FederationKit.host {
//                let response = await Lemmy.resolveURL(actor_id)
//                if let resolvedCommunity = response?.community?.community {
//                    FederationLog("resolving \(resolvedCommunity.id)", level: .debug)
//                    community = resolvedCommunity
//                    id = resolvedCommunity.id
//                    name = (resolvedCommunity.name)+"@"+(actor_id.host ?? "")
//                } else {
                    name = (community?.name ?? "")+"@"+(actor_id.host ?? "")
//                }
            } else {
                id = nil
            }
            resolver = .init(useBase: true,
                             id: id,
                             name: name)
        }
        
        //print(resolver.description(context, from: "community", location: location ?? .base))
        return resolver
    }
    static func fromPost(_ post: FederatedPost?,
                         community: FederatedCommunity? = nil,
                         auth: String? = nil,
                         location: FederatedLocationType? = nil,
                         from context: String = "") async -> FetchResolver {
        
        let resolver: FetchResolver
        
        switch location {
        case .source:
            resolver = .init(useBase: false,
                             actor: community?.actor_id,
                             id: post?.id.asInt)
        case .peer(let host):
            let sourceId: Int?
            let host = host.host ?? host
            if host == post?.ap_id.host {
                sourceId = Int(post?.ap_id.components(separatedBy: "/").last ?? "")
            } else {
                sourceId = nil
            }
            
            resolver = .init(useBase: false,
                             actor: host,
                             id: post?.id.asInt,
                             sourceId: sourceId)
        default:
            var id: Int? = post?.id.asInt
//            if post?.location != .base,
//               let ap_id = post?.ap_id {
//
//                let response = await Lemmy.resolveURL(ap_id)
//                if let resolvedPost = response?.post?.post {
//                    LemmyLog("resolving \(resolvedPost.id)", logLevel: .debug)
//                    id = resolvedPost.id
//                }
//            }
            
            resolver = .init(useBase: true,
                             actor: post?.ap_id,
                             id: id)
        }
        
        //print(resolver.description(context, from: "post", location: location ?? .base))
        return resolver
    }
    
    static var empty: FetchResolver {
        .init(useBase: false, name: "")
    }
    
    static func base(withName name: String? = nil) -> FetchResolver {
        .init(useBase: false, name: name)
    }
    
    func description(_ context: String, from target: String, location: FederatedLocationType) -> String {
        """
        [FetchResolver \(location.description)] \(context) from: \(target) -----
        useBase: \(useBase)
        actor: \(actor)
        name: \(name)
        id: \(id)
        sourceId: \(sourceId)
        domain: \(domain)
        ------------------------------------------------
        """
    }
}
