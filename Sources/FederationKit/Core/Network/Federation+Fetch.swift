//
//  Federation+Fetch.swift
//
//
//  Created by PEXAVC on 8/23/23.
//

import Foundation
import Combine

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
                   location: FederatedLocationType? = nil) async -> FederatedCommunityResource? {
        
        return await lemmy?.community(id,
                                      name: name,
                                      auth: auth,
                                      location: location?.lemmy)?.federated
    }
    
    static func community(_ id: Int? = nil,
                          community: FederatedCommunity? = nil,
                          name: String? = nil,
                          auth: String? = nil,
                          location: FederatedLocationType? = nil) async -> FederatedCommunityResource? {
        return await shared.community(id ?? community?.id,
                                      name: name ?? community?.name,
                                      auth: auth,
                                      location: location)
    }
    
    func post(_ postId: Int? = nil,
              comment: FederatedComment? = nil,
              auth: String? = nil) async -> FederatedPostResource? {
        return await lemmy?.post(postId,
                                 comment: comment?.lemmy,
                                 auth: auth)?.federated
    }
    static func post(_ postId: Int? = nil,
                     comment: FederatedComment? = nil,
                     auth: String? = nil) async -> FederatedPostResource? {
        return await shared.post(postId, comment: comment, auth: auth)
    }
    
    func posts(_ community: FederatedCommunity? = nil,
               id: Int? = nil,
               name: String? = nil,
               type: FederatedListingType = .local,
               page: Int? = nil,
               limit: Int? = nil,
               sort: FederatedSortType? = nil,
               auth: String? = nil,
               saved_only: Bool? = nil,
               location: FederatedLocationType? = nil) async -> [FederatedPostResource] {
        
        return await lemmy?.posts(community?.lemmy,
                                  id: id,
                                  name: name,
                                  type: type.lemmy,
                                  page: page,
                                  limit: limit,
                                  sort: sort?.lemmy,
                                  auth: auth,
                                  saved_only: saved_only,
                                  location: location?.lemmy).compactMap { $0.federated } ?? []
    }
    static func posts(_ community: FederatedCommunity? = nil,
                      type: FederatedListingType = .local,
                      page: Int? = nil,
                      limit: Int? = nil,
                      sort: FederatedSortType? = nil,
                      auth: String? = nil,
                      saved_only: Bool? = nil,
                      location: FederatedLocationType? = nil) async -> [FederatedPostResource] {
        return await shared.posts(community,
                                  id: community?.id,
                                  name: community?.name,
                                  type: type,
                                  page: page,
                                  limit: limit,
                                  sort: sort,
                                  auth: auth,
                                  saved_only: saved_only,
                                  location: location)
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
                                     auth: auth,
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
        return await shared.comments(post,
                                     postId: post?.id,
                                     comment: comment,
                                     community: community,
                                     depth: depth,
                                     page: page,
                                     limit: limit,
                                     type: type,
                                     sort: sort,
                                     auth: auth,
                                     saved_only: saved_only,
                                     location: location)
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
        return await shared.person(person?.id,
                                    sort: sort,
                                    page: page,
                                    limit: limit,
                                    community_id: community?.id,
                                    saved_only: saved_only,
                                    auth: auth,
                                    location: location)
    }
}
