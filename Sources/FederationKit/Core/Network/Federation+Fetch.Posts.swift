//
//  Federation+Fetch.Posts.swift
//  
//  Moved, since the feed logic may become the most dense
//  when handling multiple aggregated sourced
//
//  When it comes to fetching "Looms" it might be best
//  to create a seperate function all together to manage the
//  looping/queue of post retrievals?
//
//  Created by PEXAVC on 9/3/23.
//

import Foundation
import Combine
import LemmyKit
import MastodonKit

public extension Federation {
    func posts(_ community: FederatedCommunity? = nil,
               id: Int? = nil,
               name: String? = nil,
               type: FederatedListingType = .local,
               page: Int? = nil,
               limit: Int? = nil,
               sort: FederatedSortType? = nil,
               auth: String? = nil,
               saved_only: Bool? = nil,
               location: FederatedLocationType? = nil,
               instanceType: FederatedInstanceType? = nil,
               serverHost: String? = nil) async -> [FederatedPostResource] {
        
        switch (instanceType ?? currentServer?.type) {
        case .lemmy:
            if let serverHost,
               let server = servers[serverHost] {
                
                return await server.lemmy?.posts(community?.lemmy,
                                          id: id,
                                          name: name,
                                          type: type.lemmy,
                                          page: page,
                                          limit: limit,
                                          sort: sort?.lemmy,
                                          auth: auth ?? lemmy?.auth,
                                          saved_only: saved_only,
                                          location: location?.lemmy).compactMap { $0.federated } ?? []
                
                
            } else {
                
                return await lemmy?.posts(community?.lemmy,
                                          id: id,
                                          name: name,
                                          type: type.lemmy,
                                          page: page,
                                          limit: limit,
                                          sort: sort?.lemmy,
                                          auth: auth ?? lemmy?.auth,
                                          saved_only: saved_only,
                                          location: location?.lemmy).compactMap { $0.federated } ?? []
            }
            
        /*
         Revise this logic, it's being built to support manifestst
         */
        case .rss:
            switch location {
            case .base:
                
                //TODO: pagination
                return (await rss?.parseAsyncAwait())?.rssFeed?.items?.map { $0.asResource } ?? []
                
            default:
                if let actor = community?.actor_id {
                    var server: FederationServer = .init(instanceType ?? .automatic, host: actor)
                    
                    server.connect()
                    return (await server.rss?.parseAsyncAwait())?.rssFeed?.items?.map { $0.asResource } ?? []
                } else {
                    return []
                }
            }
        case .mastodon:
            //TODO: pagination
            switch location {
            case .base:
                //TODO: pagination
                return (try? await mastodon?.run(Timelines.public()).value.map { $0.asResource }) ?? []
                
            default:
                if let actor = community?.actor_id {
                    var server: FederationServer = .init(instanceType ?? .automatic, host: actor)
                    
                    server.connect()
                    
                    return (try? await server.mastodon?.run(Timelines.public()).value.map { $0.asResource }) ?? []
                } else {
                    return []
                }
            }
        default:
            return []
        }
    }
    static func posts(_ community: FederatedCommunity? = nil,
                      type: FederatedListingType = .local,
                      page: Int? = nil,
                      limit: Int? = nil,
                      sort: FederatedSortType? = nil,
                      auth: String? = nil,
                      saved_only: Bool? = nil,
                      location: FederatedLocationType? = nil,
                      instanceType: FederatedInstanceType? = nil) async -> [FederatedPostResource] {
        
        //The serverHost: String logic seems to be the whole strategy
        //around resolvement, over what is currently used below `FetchResolver`
        //Which may have been an over engineere'd step. Need to revise the pros/cons
        //of both.
        //
        //The reason why the serverHost strategy was discovered now was the use of the
        //serverMap : [String: FederationServer] which was not there in the statically
        //composed LemmyKit in the earlier iteration of the app
        let resolver: FetchResolver = await .fromCommunity(community,
                                                           auth: auth,
                                                           location: location,
                                                           from: "static posts(:_)")
        
        let instanceType: FederatedInstanceType = instanceType ?? shared.currentInstanceType
        
        FederationLog("instanceType: \(instanceType.rawValue) | useBase: \(resolver.useBase)",
                      level: .debug)
        if instanceType == .automatic {
            var instancesToTry: [FederatedInstanceType] = FederatedInstanceType.validInstances
            var posts: [FederatedPostResource] = []
            while instancesToTry.isEmpty == false {
                let instanceType = instancesToTry.removeFirst()
                FederationLog("Fetching posts using | auto | attempting: \(instanceType.rawValue)")
                posts = await shared.posts(community,
                                           id: resolver.id,
                                           name: resolver.name,
                                           type: type,
                                           page: page,
                                           limit: limit,
                                           sort: sort,
                                           auth: resolver.auth,
                                           saved_only: saved_only,
                                           location: location,
                                           instanceType: instanceType,
                                           serverHost: community?.actor_id.host)
                
                if posts.isEmpty == false {
                    //TODO: update map as well
                    shared.currentServer?.setInstanceType(instanceType)
                    break
                }
            }
            return posts
        } else if instanceType == .lemmy,
                  resolver.useBase == false,
                  let domain = resolver.domain {
            
            let instancedLemmy: Lemmy = shared.server(for: domain.host)?.lemmy ?? .init(apiUrl: domain)
            
            return await instancedLemmy.posts(community?.lemmy,
                                              id: resolver.id,
                                              name: resolver.name,
                                              type: type.lemmy,
                                              page: page,
                                              limit: limit,
                                              sort: sort?.lemmy,
                                              auth: nil,
                                              location: location?.lemmy).compactMap { $0.federated }
            
        } else {
            return await shared.posts(community,
                                      id: resolver.id,
                                      name: resolver.name,
                                      type: type,
                                      page: page,
                                      limit: limit,
                                      sort: sort,
                                      auth: resolver.auth,
                                      saved_only: saved_only,
                                      location: location,
                                      instanceType: instanceType,
                                      serverHost: community?.actor_id.host)
        }
    }
}
