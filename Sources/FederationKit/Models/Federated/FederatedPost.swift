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
    
    public init(post: FederatedPost,
                creator: FederatedPerson,
                community: FederatedCommunity,
                creator_banned_from_community: Bool,
                counts: FederatedPostAggregates,
                subscribed: FederatedSubscribedType,
                saved: Bool,
                read: Bool,
                creator_blocked: Bool,
                my_vote: Int? = nil,
                unread_comments: Int) {
        self.post = post
        self.creator = creator
        self.community = community
        self.creator_banned_from_community = creator_banned_from_community
        self.counts = counts
        self.subscribed = subscribed
        self.saved = saved
        self.read = read
        self.creator_blocked = creator_blocked
        self.my_vote = my_vote
        self.unread_comments = unread_comments
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
        id: String,
        name: String,
        url: String? = nil,
        body: String? = nil,
        creator_id: String,
        community_id: String,
        removed: Bool,
        locked: Bool,
        published: String,
        updated: String? = nil,
        deleted: Bool,
        nsfw: Bool,
        embed_title: String? = nil,
        embed_description: String? = nil,
        thumbnail_url: String? = nil,
        ap_id: String,
        local: Bool,
        embed_video_url: String? = nil,
        language_id: Int,
        featured_community: Bool,
        featured_local: Bool,
        instanceType: FederatedInstanceType
    ) {
        self.id = id
        self.name = name
        self.url = url
        self.body = body
        self.creator_id = creator_id
        self.community_id = community_id
        self.removed = removed
        self.locked = locked
        self.published = published
        self.updated = updated
        self.deleted = deleted
        self.nsfw = nsfw
        self.embed_title = embed_title
        self.embed_description = embed_description
        self.thumbnail_url = thumbnail_url
        self.ap_id = ap_id
        self.local = local
        self.embed_video_url = embed_video_url
        self.language_id = language_id
        self.featured_community = featured_community
        self.featured_local = featured_local
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
        id: String,
        post_id: String,
        comments: Int,
        score: Int,
        upvotes: Int,
        downvotes: Int,
        published: String,
        newest_comment_time_necro: String,
        newest_comment_time: String,
        featured_community: Bool,
        featured_local: Bool,
        hot_rank: Int,
        hot_rank_active: Int,
        reblog_count: Int = 0
    ) {
        self.id = id
        self.post_id = post_id
        self.comments = comments
        self.score = score
        self.upvotes = upvotes
        self.downvotes = downvotes
        self.published = published
        self.newest_comment_time_necro = newest_comment_time_necro
        self.newest_comment_time = newest_comment_time
        self.featured_community = featured_community
        self.featured_local = featured_local
        self.hot_rank = hot_rank
        self.hot_rank_active = hot_rank_active
        self.reblog_count = reblog_count
    }
}
