//
//  Federation+Fetch.swift
//
//
//  Created by PEXAVC on 8/23/23.
//

import Foundation
import Combine
import LemmyKit
import MastodonKit

//MARK: -- Fetch

public extension Federation {
    func communities(_ type: FederatedListingType = .local,
                     sort: FederatedSortType? = nil,
                     page: Int? = nil,
                     limit: Int? = nil,
                     auth: String? = nil) async -> [FederatedCommunityResource] {
        
        return await lemmy?.communities(type.lemmy,
                                        sort: sort?.lemmy,
                                        page: page,
                                        limit: limit,
                                        auth: auth).compactMap { $0.federated } ?? []
    }
    
    static func communities(_ type: FederatedListingType = .local,
                            sort: FederatedSortType? = nil,
                            page: Int? = nil,
                            limit: Int? = nil,
                            auth: String? = nil) async -> [FederatedCommunityResource] {
        return await shared.communities(type,
                                        sort: sort,
                                        page: page,
                                        limit: limit,
                                        auth: auth)
    }
    
    func community(_ id: Int? = nil,
                   name: String? = nil,
                   auth: String? = nil,
                   location: FederatedLocationType? = nil,
                   serverHost: String? = nil) async -> FederatedCommunityResource? {
        if let serverHost,
           let server = servers[serverHost] {
            return await server.lemmy?.community(id,
                                          name: name,
                                          auth: auth,
                                          location: location?.lemmy)?.federated
        } else {
            return await lemmy?.community(id,
                                          name: name,
                                          auth: auth,
                                          location: location?.lemmy)?.federated
        }
    }
    
    static func community(_ id: String? = nil,
                          community: FederatedCommunity? = nil,
                          name: String? = nil,
                          auth: String? = nil,
                          location: FederatedLocationType? = nil) async -> FederatedCommunityResource? {
        return await shared.community(id?.asInt ?? community?.id.asInt,
                                      name: name ?? community?.name,
                                      auth: auth,
                                      location: location,
                                      serverHost: community?.actor_id.host)
    }
    
    func post(_ postId: Int? = nil,
              comment: FederatedComment? = nil,
              auth: String? = nil,
              serverHost: String? = nil) async -> FederatedPostResource? {
        
        /*
         So this is a different design pattern
         then the other flows in this kit when deciding
         which server. There should be a level of consistency when
         it is clear. Or a set of best practices. Maybe for one-shots
         like this call, it is good to retrieve with a host key-value
         */
        if let serverHost,
           let server = servers[serverHost] {
            return await server.lemmy?.post(postId,
                                            comment: comment?.lemmy,
                                            auth: auth)?.federated
        } else {
            return await lemmy?.post(postId,
                                     comment: comment?.lemmy,
                                     auth: auth)?.federated
        }
    }
    static func post(_ postId: String? = nil,
                     comment: FederatedComment? = nil,
                     auth: String? = nil) async -> FederatedPostResource? {
        return await shared.post(postId?.asInt,
                                 comment: comment,
                                 auth: auth)
    }
    static func post(_ post: FederatedPost? = nil,
                     comment: FederatedComment? = nil,
                     auth: String? = nil) async -> FederatedPostResource? {
        return await shared.post(post?.id.asInt,
                                 comment: comment,
                                 auth: auth,
                                 serverHost: post?.ap_id.host)
    }
    
    /*
     Comments can be sourced via post, community, or comment. One must be provided.
     */
    func comments(_ post: FederatedPost? = nil,
                  postId: Int? = nil,
                  comment: FederatedComment? = nil,
                  community: FederatedCommunity? = nil,
                  depth: Int = 1,
                  page: Int? = nil,
                  limit: Int? = nil,
                  type: FederatedListingType = .local,
                  sort: FederatedCommentSortType = .hot,
                  auth: String? = nil,
                  saved_only: Bool? = nil,
                  location: FederatedLocationType? = nil) async -> [FederatedCommentResource] {
        guard post != nil || comment != nil || community != nil else {
            FederationLog("Please provide a resource object")
            return []
        }
        
        return await lemmy?.comments(post?.lemmy,
                                     postId: postId,
                                     comment: comment?.lemmy,
                                     community: community?.lemmy,
                                     depth: depth,
                                     page: page,
                                     limit: limit,
                                     type: type.lemmy,
                                     sort: sort.lemmy,
                                     //For posts and comments we need to see if this auth should
                                     //be handled on LemmyKit or here
                                     //Since heach lemmy is instanced in federationkit, we are doing it this way
                                     //when in the LemmyKit only version we were calling these statically
                                     auth: auth ?? lemmy?.auth,
                                     saved_only: saved_only,
                                     location: location?.lemmy).compactMap { $0.federated } ?? []
    }
    static func comments(_ post: FederatedPost? = nil,
                         comment: FederatedComment? = nil,
                         community: FederatedCommunity? = nil,
                         depth: Int = 1,
                         page: Int? = nil,
                         limit: Int? = nil,
                         type: FederatedListingType = .local,
                         sort: FederatedCommentSortType = .hot,
                         auth: String? = nil,
                         saved_only: Bool? = nil,
                         location: FederatedLocationType? = nil) async -> [FederatedCommentResource] {
        
        let resolver: FetchResolver = await .fromPost(post, community: community, auth: auth, location: location, from: "static comments(:_)")
        
        if resolver.useBase == false,
           let domain = resolver.domain {
            let instancedLemmy: Lemmy = shared.server(for: domain.host)?.lemmy ?? .init(apiUrl: domain)
            return await instancedLemmy.comments(post?.lemmy,
                                                 postId: resolver.sourceId,
                                                 comment: comment?.lemmy,
                                                 community: resolver.useCommunity ? community?.lemmy : nil,
                                                 depth: depth,
                                                 page: page,
                                                 limit: limit,
                                                 type: type.lemmy,
                                                 sort: sort.lemmy,
                                                 auth: auth,
                                                 location: location?.lemmy).compactMap { $0.federated }
            
        } else {
            return await shared.comments(post,
                                         postId: resolver.id,
                                         comment: comment,
                                         community: resolver.useCommunity ? community : nil,
                                         depth: depth,
                                         page: page,
                                         limit: limit,
                                         type: type,
                                         sort: sort,
                                         auth: auth,
                                         saved_only: saved_only,
                                         location: location)
        }
    }
    
    func person(_ person_id: Int? = nil,
                 sort: FederatedSortType? = nil,
                 page: Int? = nil,
                 limit: Int? = nil,
                 community_id: Int? = nil,
                 saved_only: Bool? = nil,
                 auth: String? = nil,
                 location: FederatedLocationType = .base) async -> FederatedPersonDetails? {
        return await lemmy?.person(person_id,
                                   sort: sort?.lemmy,
                                   page: page,
                                   limit: limit,
                                   community_id: community_id,
                                   saved_only: saved_only,
                                   auth: auth,
                                   location: location.lemmy)?.federated
    }
    static func person(_ person: FederatedPerson? = nil,
                        sort: FederatedSortType? = nil,
                        page: Int? = nil,
                        limit: Int? = nil,
                        community: FederatedCommunity? = nil,
                        saved_only: Bool? = nil,
                        auth: String? = nil,
                        location: FederatedLocationType = .base) async -> FederatedPersonDetails? {
        
        let resolver: FetchResolver = await .fromPerson(person, auth: auth, location: location, from: "static person(:_)")
        
        if resolver.useBase == false,
           let domain = resolver.domain {
            let instancedLemmy: Lemmy = .init(apiUrl: domain)
            
            return await instancedLemmy.person(resolver.id,
                                               sort: sort?.lemmy,
                                               page: page,
                                               limit: limit,
                                               //?
                                               community_id: community?.id.asInt,
                                               saved_only: saved_only,
                                               auth: auth,
                                               location: location.lemmy)?.federated
        } else {
            return await shared.person(resolver.id,
                                       sort: sort,
                                       page: page,
                                       limit: limit,
                                       community_id: community?.id.asInt,
                                       saved_only: saved_only,
                                       auth: auth,
                                       location: location)
        }
    }
}
