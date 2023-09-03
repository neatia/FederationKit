//
//  Federation+Create.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

//MARK: -- Create

public extension Federation {
    @discardableResult
    func createCommunity(_ title: String, auth: String? = nil) async -> FederatedCommunity? {
        return await lemmy?.createCommunity(title, auth: auth)?.federated
    }
    @discardableResult
    static func createCommunity(_ title: String, auth: String? = nil) async -> FederatedCommunity? {
        return await shared.createCommunity(title, auth: auth)
    }
    
    @discardableResult
    func createPost(_ title: String,
                    url: String? = nil,
                    body: String? = nil,
                    community: FederatedCommunity,
                    auth: String? = nil) async -> FederatedPostResource? {
        return await lemmy?.createPost(title,
                                       url: url,
                                       body: body,
                                       community: community.lemmy,
                                       auth: auth ?? lemmy?.auth)?.federated
    }
    @discardableResult
    static func createPost(_ title: String,
                           url: String? = nil,
                           body: String? = nil,
                           community: FederatedCommunity,
                           auth: String? = nil) async -> FederatedPostResource? {
        return await shared.createPost(title,
                                       url: url,
                                       body: body,
                                       community: community,
                                       auth: auth)
    }
    
    
    
    @discardableResult
    func createComment(_ content: String,
                       post: FederatedPost,
                       parent: FederatedComment? = nil,
                       auth: String? = nil) async -> FederatedComment? {
        return await tryUsersLemmy(post.ap_id)?.createComment(content,
                                          post: post.lemmy,
                                          parent: parent?.lemmy,
                                          auth: auth ?? lemmy?.auth)?.federated
    }
    @discardableResult
    static func createComment(_ content: String,
                              post: FederatedPost,
                              parent: FederatedComment? = nil,
                              auth: String? = nil) async -> FederatedComment? {
        return await shared.createComment(content,
                                          post: post,
                                          parent: parent,
                                          auth: auth)
    }
    
    
}
