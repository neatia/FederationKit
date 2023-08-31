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
                    content: String,
                    url: String? = nil,
                    body: String? = nil,
                    community: FederatedCommunity,
                    auth: String? = nil) async -> FederatedPostResource? {
        return await lemmy?.createPost(title,
                                       content: content,
                                       url: url,
                                       body: body,
                                       community: community.lemmy,
                                       auth: auth)?.federated
    }
    @discardableResult
    static func createPost(_ title: String,
                           content: String,
                           url: String? = nil,
                           body: String? = nil,
                           community: FederatedCommunity,
                           auth: String? = nil) async -> FederatedPostResource? {
        return await shared.createPost(title,
                                       content: content,
                                       url: url,
                                       body: body,
                                       community: community,
                                       auth: auth)
    }
    
    @discardableResult
    func editPost(_ postId: Int,
                    title: String,
                    url: String? = nil,
                    body: String? = nil,
                    nsfw: Bool = false,
                    language_id: Int? = nil,
                    auth: String? = nil) async -> FederatedPostResource? {
        return await lemmy?.editPost(postId,
                                     title: title,
                                     url: url,
                                     body: body,
                                     nsfw: nsfw,
                                     language_id: language_id,
                                     auth: auth)?.federated
    }
    @discardableResult
    static func editPost(_ postId: Int,
                         title: String,
                         url: String? = nil,
                         body: String? = nil,
                         nsfw: Bool = false,
                         language_id: Int? = nil,
                         auth: String? = nil) async -> FederatedPostResource? {
        return await shared.editPost(postId,
                                     title: title,
                                     url: url,
                                     body: body,
                                     nsfw: nsfw,
                                     language_id: language_id,
                                     auth: auth)
    }
    
    @discardableResult
    func createComment(_ content: String,
                       post: FederatedPost,
                       parent: FederatedComment? = nil,
                       auth: String? = nil) async -> FederatedComment? {
        return await lemmy?.createComment(content,
                                          post: post.lemmy,
                                          parent: parent?.lemmy,
                                          auth: auth)?.federated
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
    
    @discardableResult
    func editComment(_ comment_id: Int,
                     content: String? = nil,
                     language_id: Int? = nil,
                     form_id: String? = nil,
                     auth: String? = nil) async -> FederatedComment? {
        return await lemmy?.editComment(comment_id,
                                        content: content,
                                        language_id: language_id,
                                        form_id: form_id,
                                        auth: auth)?.federated
    }
    @discardableResult
    static func editComment(_ comment_id: Int,
                            content: String? = nil,
                            language_id: Int? = nil,
                            form_id: String? = nil,
                            auth: String? = nil) async -> FederatedComment? {
        return await shared.editComment(comment_id,
                                        content: content,
                                        language_id: language_id,
                                        form_id: form_id,
                                        auth: auth)
    }
}
