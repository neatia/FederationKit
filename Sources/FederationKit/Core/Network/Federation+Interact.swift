//
//  Federation+Interact.swift
//
//
//  Created by PEXAVC on 8/23/23.
//

import Foundation
import LemmyKit
//MARK: -- Interact

public extension Federation {
    func upvotePost(_ post: FederatedPost,
                    score: Int,
                    auth: String? = nil) async -> FederatedPostResource? {
        
        return await lemmy?.upvotePost(post.lemmy,
                                       score: score,
                                       auth: auth)?.federated
    }
    static func upvotePost(_ post: FederatedPost,
                           score: Int,
                           auth: String? = nil) async -> FederatedPostResource? {
        return await shared.upvotePost(post,
                                       score: score,
                                       auth: auth)
    }
    
    func removePost(post_id: Int,
                    removed: Bool,
                    reason: String? = nil,
                    auth: String? = nil) async -> FederatedPostResource? {
        
        return await lemmy?.removePost(post_id: post_id,
                                       removed: removed,
                                       reason: reason,
                                       auth: auth)?.post_view.federated
    }
    static func removePost(_ post: FederatedPost,
                           removed: Bool,
                           reason: String? = nil,
                           auth: String? = nil) async -> FederatedPostResource? {
        return await shared.removePost(post_id: post.id.asInt,
                                       removed: removed,
                                       reason: reason,
                                       auth: auth)
    }
    
    func savePost(_ post: FederatedPost,
                  save: Bool,
                  auth: String? = nil) async -> FederatedPostResource? {
        
        return await lemmy?.savePost(post.lemmy,
                                     save: save,
                                     auth: auth)?.post_view.federated
    }
    static func savePost(_ post: FederatedPost,
                         save: Bool,
                         auth: String? = nil) async -> FederatedPostResource? {
        
        return await shared.savePost(post,
                                     save: save,
                                     auth: auth)
    }
    
    func upvoteComment(_ comment: FederatedComment,
                       score: Int,
                       auth: String? = nil) async -> FederatedCommentResource? {
        return await lemmy?.upvoteComment(comment.lemmy,
                                          score: score,
                                          auth: auth)?.federated
    }
    static func upvoteComment(_ comment: FederatedComment,
                              score: Int,
                              auth: String? = nil) async -> FederatedCommentResource? {
        return await shared.upvoteComment(comment,
                                          score: score,
                                          auth: auth)
    }
    
    func removeComment(comment_id: CommentId,
                       removed: Bool,
                       reason: String? = nil,
                       auth: String? = nil) async -> FederatedCommentResource? {
        return await lemmy?.removeComment(comment_id: comment_id,
                                          removed: removed,
                                          reason: reason,
                                          auth: auth)?.comment_view.federated
    }
    static func removeComment(_ comment: FederatedComment,
                              removed: Bool,
                              reason: String? = nil,
                              auth: String? = nil) async -> FederatedCommentResource? {
        return await shared.removeComment(comment_id: comment.id.asInt,
                                          removed: removed,
                                          reason: reason,
                                          auth: auth)
    }
    
    func saveComment(_ comment: FederatedComment,
                     save: Bool,
                     auth: String? = nil) async -> FederatedCommentResource? {
        return await lemmy?.saveComment(comment.lemmy,
                                        save: save,
                                        auth: auth)?.comment_view.federated
    }
    static func saveComment(_ comment: FederatedComment,
                            save: Bool,
                            auth: String? = nil) async -> FederatedCommentResource? {
        return await shared.saveComment(comment,
                                        save: save,
                                        auth: auth)
    }
}

//MARK: remove/block posts/communities/person

public extension Federation {
    //TODO: return the entire `PostReportView` and convert o `FederatedPostReportView`
    func report(post: FederatedPost,
                reason: String,
                auth: String? = nil
    ) async -> FederatedPost? {
        return await lemmy?.report(post: post.lemmy,
                                   reason: reason,
                                   auth: auth)?.post.federated
    }
    static func report(post: FederatedPost,
                       reason: String,
                       auth: String? = nil) async -> FederatedPost? {
        return await shared.report(post: post,
                                   reason: reason,
                                   auth: auth)
    }
    
    //TODO: return the entire `CommentReportView` and convert o `FederatedCommentReportView`
    func report(comment: FederatedComment,
                reason: String,
                auth: String? = nil
    ) async -> FederatedComment? {
        
        return await lemmy?.report(comment: comment.lemmy,
                                   reason: reason,
                                   auth: auth)?.comment_report_view.comment.federated
    }
    static func report(comment: FederatedComment,
                       reason: String,
                       auth: String? = nil) async -> FederatedComment? {
        
        return await shared.report(comment: comment,
                                   reason: reason,
                                   auth: auth)
    }
    
    func block(person: FederatedPerson,
               block: Bool,
               auth: String? = nil
    ) async -> FederatedPersonResource? {
        
        return await lemmy?.block(person: person.lemmy,
                                  block: block,
                                  auth: auth)?.person_view.federated
    }
    static func block(person: FederatedPerson,
                      block: Bool,
                      auth: String? = nil) async -> FederatedPersonResource? {
        return await shared.block(person: person,
                                  block: block,
                                  auth: auth)
    }
    
    func block(community: FederatedCommunity,
               block: Bool,
               auth: String? = nil
    ) async -> FederatedCommunityResource? {
        return await lemmy?.block(community: community.lemmy,
                                  block: block,
                                  auth: auth)?.community_view.federated
    }
    static func block(community: FederatedCommunity,
                      block: Bool,
                      auth: String? = nil) async -> FederatedCommunityResource? {
        return await shared.block(community: community,
                                  block: block,
                                  auth: auth)
    }
}

//MARK: Subscribe/Unsubscribe

public extension Federation {
    func follow(community: FederatedCommunity,
                follow: Bool,
                auth: String? = nil) async -> FederatedCommunityResource? {
        
        return await lemmy?.follow(community: community.lemmy,
                                   follow: follow,
                                   auth: auth)?.community_view.federated
    }
    static func follow(community: FederatedCommunity,
                       follow: Bool,
                       auth: String? = nil) async -> FederatedCommunityResource? {
        return await shared.follow(community: community,
                                   follow: follow,
                                   auth: auth)
    }
}
