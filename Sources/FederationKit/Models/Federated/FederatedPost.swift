//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public struct FederatedPostResource: Codable, Hashable {
    public var post: FederatedPost
    public var creator: FederatedPerson
    public var community: FederatedCommunity
    public let creator_banned_from_community: Bool
    public let counts: FederatedPostAggregates
    public let subscribed: FederatedSubscribedType
    public let saved: Bool
    public let read: Bool
    public let creator_blocked: Bool
    public let my_vote: Int?
    public let unread_comments: Int
    
    public init(post: FederatedPost? = nil,
                creator: FederatedPerson? = nil,
                community: FederatedCommunity? = nil,
                creator_banned_from_community: Bool? = nil,
                counts: FederatedPostAggregates? = nil,
                subscribed: FederatedSubscribedType? = nil,
                saved: Bool? = nil,
                read: Bool? = nil,
                creator_blocked: Bool? = nil,
                my_vote: Int? = nil,
                unread_comments: Int? = nil) {
        self.post = post ?? .mock
        self.creator = creator ?? .mock
        self.community = community ?? .mock
        self.creator_banned_from_community = creator_banned_from_community ?? false
        self.counts = counts ?? .mock
        self.subscribed = subscribed ?? .notSubscribed
        self.saved = saved ?? false
        self.read = read ?? false
        self.creator_blocked = creator_blocked ?? false
        self.my_vote = my_vote
        self.unread_comments = unread_comments ?? 0
    }
}

public struct FederatedPost: Codable, Identifiable, Hashable {
    public let id: String
    public let name: String
    public let url: String?
    public let body: String?
    public let creator_id: String
    public let community_id: String
    public let removed: Bool
    public let locked: Bool
    public let published: String
    public let updated: String?
    public let deleted: Bool
    public let nsfw: Bool
    public let embed_title: String?
    public let embed_description: String?
    public let thumbnail_url: String?
    public let ap_id: String
    public let local: Bool
    public let embed_video_url: String?
    public let language_id: Int
    public let featured_community: Bool
    public let featured_local: Bool
    public let instanceType: FederatedInstanceType
    
    public init(
        id: String?,
        name: String?,
        url: String? = nil,
        body: String? = nil,
        creator_id: String?,
        community_id: String?,
        removed: Bool?,
        locked: Bool?,
        published: String?,
        updated: String? = nil,
        deleted: Bool?,
        nsfw: Bool?,
        embed_title: String? = nil,
        embed_description: String? = nil,
        thumbnail_url: String? = nil,
        ap_id: String?,
        local: Bool?,
        embed_video_url: String? = nil,
        language_id: Int?,
        featured_community: Bool?,
        featured_local: Bool?,
        instanceType: FederatedInstanceType
    ) {
        self.id = id ?? "-1"
        self.name = name ?? "unknown"
        self.url = url
        self.body = body
        self.creator_id = creator_id ?? "-1"
        self.community_id = community_id ?? "-1"
        self.removed = removed ?? false
        self.locked = locked ?? false
        self.published = published ?? "-1"
        self.updated = updated
        self.deleted = deleted ?? false
        self.nsfw = nsfw ?? false
        self.embed_title = embed_title
        self.embed_description = embed_description
        self.thumbnail_url = thumbnail_url
        self.ap_id = ap_id ?? "-1"
        self.local = local ?? false
        self.embed_video_url = embed_video_url
        self.language_id = language_id ?? -1
        self.featured_community = featured_community ?? false
        self.featured_local = featured_local ?? false
        self.instanceType = instanceType
    }
}

public struct FederatedPostAggregates: Codable, Identifiable, Hashable {
    public let id: String
    public let post_id: String
    public let comments: Int
    public let score: Int
    public let upvotes: Int
    public let downvotes: Int
    public let published: String
    public let newest_comment_time_necro: String
    public let newest_comment_time: String
    public let featured_community: Bool
    public let featured_local: Bool
    public let hot_rank: Int
    public let hot_rank_active: Int
    public let reblog_count: Int

    public init(
        id: String? = nil,
        post_id: String? = nil,
        comments: Int? = nil,
        score: Int? = nil,
        upvotes: Int? = nil,
        downvotes: Int? = nil,
        published: String? = nil,
        newest_comment_time_necro: String? = nil,
        newest_comment_time: String? = nil,
        featured_community: Bool? = nil,
        featured_local: Bool? = nil,
        hot_rank: Int? = nil,
        hot_rank_active: Int? = nil,
        reblog_count: Int = 0
    ) {
        self.id = id ?? "-1"
        self.post_id = post_id ?? "-1"
        self.comments = comments ?? 0
        self.score = score ?? 0
        self.upvotes = upvotes ?? 0
        self.downvotes = downvotes ?? 0
        self.published = published ?? "-1"
        self.newest_comment_time_necro = newest_comment_time_necro ?? ""
        self.newest_comment_time = newest_comment_time ?? "-1"
        self.featured_community = featured_community ?? false
        self.featured_local = featured_local ?? false
        self.hot_rank = hot_rank ?? -1
        self.hot_rank_active = hot_rank_active ?? -1
        self.reblog_count = reblog_count
    }
}
