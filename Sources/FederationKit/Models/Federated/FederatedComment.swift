//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit

/*
 Lemmy - Comment
 Mastodon - Reply
 */

public struct FederatedCommentResource: Codable, Hashable {
    public var comment: FederatedComment
    public var creator: FederatedPerson
    public var post: FederatedPost
    public var community: FederatedCommunity
    public let counts: FederatedCommentAggregates
    public let creator_banned_from_community: Bool
    public let subscribed: FederatedSubscribedType
    public let saved: Bool
    public let creator_blocked: Bool
    public let my_vote: Int?

    public init(
        comment: FederatedComment,
        creator: FederatedPerson,
        post: FederatedPost,
        community: FederatedCommunity,
        counts: FederatedCommentAggregates,
        creator_banned_from_community: Bool,
        subscribed: FederatedSubscribedType,
        saved: Bool,
        creator_blocked: Bool,
        my_vote: Int? = nil
    ) {
        self.comment = comment
        self.creator = creator
        self.post = post
        self.community = community
        self.counts = counts
        self.creator_banned_from_community = creator_banned_from_community
        self.subscribed = subscribed
        self.saved = saved
        self.creator_blocked = creator_blocked
        self.my_vote = my_vote
    }
}

extension FederatedCommentResource: Identifiable {
    public var id: String {
        "\(creator.actor_id)\(creator.name)\(comment.updated ?? "")\(comment.ap_id)"
    }
    
    public var avatarURL: URL? {
        creator.avatarURL
    }
    
    public var replyCount: Int {
        counts.child_count
    }
    
    public var upvoteCount: Int {
        counts.upvotes
    }
    
    public var downvoteCount: Int {
        counts.downvotes
    }
}

public struct FederatedComment: Codable, Identifiable, Hashable {
    public let id: String
    public let creator_id: String
    public let post_id: String
    public let content: String
    public let removed: Bool
    public let published: String
    public let updated: String?
    public let deleted: Bool
    public let ap_id: String
    public var local: Bool
    public let path: String
    public let distinguished: Bool
    public let language_id: Int
    public let instanceType: FederatedInstanceType
    
    public init(
        id: String,
        creator_id: String,
        post_id: String,
        content: String,
        removed: Bool,
        published: String,
        updated: String? = nil,
        deleted: Bool,
        ap_id: String,
        local: Bool,
        path: String,
        distinguished: Bool,
        language_id: Int,
        instanceType: FederatedInstanceType
    ) {
        self.id = id
        self.creator_id = creator_id
        self.post_id = post_id
        self.content = content
        self.removed = removed
        self.published = published
        self.updated = updated
        self.deleted = deleted
        self.ap_id = ap_id
        self.local = local
        self.path = path
        self.distinguished = distinguished
        self.language_id = language_id
        self.instanceType = instanceType
    }
}

public struct FederatedCommentAggregates: Codable, Identifiable, Hashable {
    public let id: String
    public let comment_id: String
    public let score: Int
    public let upvotes: Int
    public let downvotes: Int
    public let published: String
    public let child_count: Int
    public let hot_rank: Int

    public init(
        id: String,
        comment_id: String,
        score: Int,
        upvotes: Int,
        downvotes: Int,
        published: String,
        child_count: Int,
        hot_rank: Int
    ) {
        self.id = id
        self.comment_id = comment_id
        self.score = score
        self.upvotes = upvotes
        self.downvotes = downvotes
        self.published = published
        self.child_count = child_count
        self.hot_rank = hot_rank
    }
}

public struct FederatedCommentReplyResource: Codable, Hashable {
    public let comment_reply: FederatedCommentReply
    public let comment: FederatedComment
    public let creator: FederatedPerson
    public let post: FederatedPost
    public let community: FederatedCommunity
    public let recipient: FederatedPerson
    public let counts: FederatedCommentAggregates
    public let creator_banned_from_community: Bool
    public let subscribed: FederatedSubscribedType
    public let saved: Bool
    public let creator_blocked: Bool
    public let my_vote: Int?

    public init(
        comment_reply: FederatedCommentReply,
        comment: FederatedComment,
        creator: FederatedPerson,
        post: FederatedPost,
        community: FederatedCommunity,
        recipient: FederatedPerson,
        counts: FederatedCommentAggregates,
        creator_banned_from_community: Bool,
        subscribed: FederatedSubscribedType,
        saved: Bool,
        creator_blocked: Bool,
        my_vote: Int? = nil
    ) {
        self.comment_reply = comment_reply
        self.comment = comment
        self.creator = creator
        self.post = post
        self.community = community
        self.recipient = recipient
        self.counts = counts
        self.creator_banned_from_community = creator_banned_from_community
        self.subscribed = subscribed
        self.saved = saved
        self.creator_blocked = creator_blocked
        self.my_vote = my_vote
    }
}

public struct FederatedCommentReply: Codable, Identifiable, Hashable {
    public let id: String
    public let recipient_id: String
    public let comment_id: String
    public let read: Bool
    public let published: String

    public init(
        id: String,
        recipient_id: String,
        comment_id: String,
        read: Bool,
        published: String
    ) {
        self.id = id
        self.recipient_id = recipient_id
        self.comment_id = comment_id
        self.read = read
        self.published = published
    }
}


public extension FederatedCommentReplyResource {
    var asCommentResource: FederatedCommentResource {
        .init(comment: comment,
              creator: creator,
              post: post,
              community: community,
              counts: counts,
              creator_banned_from_community: creator_banned_from_community,
              subscribed: subscribed,
              saved: saved,
              creator_blocked: creator_blocked)
    }
}
