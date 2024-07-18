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
        comment: FederatedComment?,
        creator: FederatedPerson?,
        post: FederatedPost?,
        community: FederatedCommunity?,
        counts: FederatedCommentAggregates?,
        creator_banned_from_community: Bool?,
        subscribed: FederatedSubscribedType?,
        saved: Bool?,
        creator_blocked: Bool?,
        my_vote: Int? = nil
    ) {
        self.comment = comment ?? .mock
        self.creator = creator ?? .mock
        self.post = post ?? .mock
        self.community = community ?? .mock
        self.counts = counts ?? .mock
        self.creator_banned_from_community = creator_banned_from_community ?? false
        self.subscribed = subscribed ?? .notSubscribed
        self.saved = saved ?? false
        self.creator_blocked = creator_blocked ?? false
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
        id: String? = nil,
        creator_id: String? = nil,
        post_id: String? = nil,
        content: String? = nil,
        removed: Bool? = nil,
        published: String? = nil,
        updated: String? = nil,
        deleted: Bool? = nil,
        ap_id: String? = nil,
        local: Bool? = nil,
        path: String? = nil,
        distinguished: Bool? = nil,
        language_id: Int? = nil,
        instanceType: FederatedInstanceType? = nil
    ) {
        self.id = id ?? "-1"
        self.creator_id = creator_id ?? "-1"
        self.post_id = post_id ?? "-1"
        self.content = content ?? "mock content"
        self.removed = removed ?? false
        self.published = published ?? "-1"
        self.updated = updated ?? "-1"
        self.deleted = deleted ?? false
        self.ap_id = ap_id ?? "-1"
        self.local = local ?? false
        self.path = path ?? ""
        self.distinguished = distinguished ?? false
        self.language_id = language_id ?? -1
        self.instanceType = instanceType ?? .unknown
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
        id: String? = nil,
        comment_id: String? = nil,
        score: Int? = nil,
        upvotes: Int? = nil,
        downvotes: Int? = nil,
        published: String? = nil,
        child_count: Int? = nil,
        hot_rank: Int? = nil
    ) {
        self.id = id ?? "-1"
        self.comment_id = comment_id ?? "-1"
        self.score = score ?? 0
        self.upvotes = upvotes ?? 0
        self.downvotes = downvotes ?? 0
        self.published = published ?? "-1"
        self.child_count = child_count ?? 0
        self.hot_rank = hot_rank ?? 0
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
        comment_reply: FederatedCommentReply? = nil,
        comment: FederatedComment? = nil,
        creator: FederatedPerson? = nil,
        post: FederatedPost? = nil,
        community: FederatedCommunity? = nil,
        recipient: FederatedPerson? = nil,
        counts: FederatedCommentAggregates? = nil,
        creator_banned_from_community: Bool? = nil,
        subscribed: FederatedSubscribedType? = nil,
        saved: Bool? = nil,
        creator_blocked: Bool? = nil,
        my_vote: Int? = nil
    ) {
        self.comment_reply = comment_reply ?? .mock
        self.comment = comment ?? .mock
        self.creator = creator ?? .mock
        self.post = post ?? .mock
        self.community = community ?? .mock
        self.recipient = recipient ?? .mock
        self.counts = counts ?? .mock
        self.creator_banned_from_community = creator_banned_from_community ?? false
        self.subscribed = subscribed ?? .notSubscribed
        self.saved = saved ?? false
        self.creator_blocked = creator_blocked ?? false
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
        id: String? = nil,
        recipient_id: String? = nil,
        comment_id: String? = nil,
        read: Bool? = nil,
        published: String? = nil
    ) {
        self.id = id ?? "-1"
        self.recipient_id = recipient_id ?? "-1"
        self.comment_id = comment_id ?? "-1"
        self.read = read ?? false
        self.published = published ?? "-1"
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
