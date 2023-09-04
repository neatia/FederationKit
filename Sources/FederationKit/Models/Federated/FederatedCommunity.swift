//
//  FederatedCommunity.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit

public struct FederatedCommunityResource: Codable, Hashable {
    public var community: FederatedCommunity
    public let subscribed: FederatedSubscribedType
    public let blocked: Bool
    public let counts: FederatedCommunityAggregates

    public init(
        community: FederatedCommunity,
        subscribed: FederatedSubscribedType,
        blocked: Bool,
        counts: FederatedCommunityAggregates
    ) {
        self.community = community
        self.subscribed = subscribed
        self.blocked = blocked
        self.counts = counts
    }
}


extension FederatedCommunityResource: Identifiable {
    public var id: String {
        self.community.federatedId
    }
    
    public var iconURL: URL? {
        community.iconURL
    }
    
    public var displayName: String {
        self.community.displayName
    }
}

public extension FederatedCommunity {
    var federatedId: String {
        self.actor_id+"\(self.id)"
    }
    
    var iconURL: URL? {
        if let icon {
            return URL(string: icon)
        }
        
        return nil
    }
}

extension FederatedCommunity {
    public var displayName: String {
        switch instanceType {
        case .lemmy:
            return "!"+self.name+"@"+self.actor_id.host
        case .mastodon, .rss:
            return self.name
        default:
            if self.actor_id.host.isEmpty == false {
                return self.name+"@"+self.actor_id.host
            } else {
                return self.name
            }
        }
    }
}

public struct FederatedCommunity: Codable, Identifiable, Hashable {
    public let id: String
    public let name: String
    public let title: String
    public let description: String?
    public let removed: Bool
    public let published: String
    public let updated: String?
    public let deleted: Bool
    public let nsfw: Bool
    public let actor_id: String
    public let local: Bool
    public let icon: String?
    public let banner: String?
    public let followers_url: String?
    public let inbox_url: String?
    public let hidden: Bool
    public let posting_restricted_to_mods: Bool
    public let instance_id: String
    public let instanceType: FederatedInstanceType
    
    //TODO: revisit necessity of this, will have to be removed from LemmyKit as well
    public var ap_id: String? = nil

    public init(
        id: String,
        name: String,
        title: String,
        description: String? = nil,
        removed: Bool,
        published: String,
        updated: String? = nil,
        deleted: Bool,
        nsfw: Bool,
        actor_id: String,
        local: Bool,
        icon: String? = nil,
        banner: String? = nil,
        followers_url: String?,
        inbox_url: String?,
        hidden: Bool,
        posting_restricted_to_mods: Bool,
        instance_id: String,
        instanceType: FederatedInstanceType
    ) {
        self.id = id
        self.name = name
        self.title = title
        self.description = description
        self.removed = removed
        self.published = published
        self.updated = updated
        self.deleted = deleted
        self.nsfw = nsfw
        self.actor_id = actor_id
        self.local = local
        self.icon = icon
        self.banner = banner
        self.followers_url = followers_url
        self.inbox_url = inbox_url
        self.hidden = hidden
        self.posting_restricted_to_mods = posting_restricted_to_mods
        self.instance_id = instance_id
        self.instanceType = instanceType
    }
}

public struct FederatedCommunityAggregates: Codable, Identifiable, Hashable {
    public let id: String
    public let community_id: CommunityId
    public let subscribers: Int
    public let posts: Int
    public let comments: Int
    public let published: String
    public let users_active_day: Int
    public let users_active_week: Int
    public let users_active_month: Int
    public let users_active_half_year: Int
    public let hot_rank: Int

    public init(
        id: String,
        community_id: CommunityId,
        subscribers: Int,
        posts: Int,
        comments: Int,
        published: String,
        users_active_day: Int,
        users_active_week: Int,
        users_active_month: Int,
        users_active_half_year: Int,
        hot_rank: Int
    ) {
        self.id = id
        self.community_id = community_id
        self.subscribers = subscribers
        self.posts = posts
        self.comments = comments
        self.published = published
        self.users_active_day = users_active_day
        self.users_active_week = users_active_week
        self.users_active_month = users_active_month
        self.users_active_half_year = users_active_half_year
        self.hot_rank = hot_rank
    }
}

extension FederatedCommunityAggregates {
    public static var mock: FederatedCommunityAggregates {
        .init(id: "0", community_id: 0, subscribers: 0, posts: 0, comments: 0, published: "\(Date())", users_active_day: 0, users_active_week: 0, users_active_month: 0, users_active_half_year: 0, hot_rank: 0)
    }
}

public extension FederatedCommunity {
    static var mock: FederatedCommunity {
        .init(
            id: "0",
            name: "mockcommunity",
            title: "Mock Community",
            description: "Lorem Ipsum",
            removed: false,
            published: "\(Date())",
            updated: nil,
            deleted: false,
            nsfw: false,
            actor_id: "",
            local: false,
            icon: "https://media.tpt.cloud/nextavenue/uploads/2021/09/bobrossestate-01.jpg",
            banner: nil,
            followers_url: nil,
            inbox_url: nil,
            hidden: false,
            posting_restricted_to_mods: false,
            instance_id: "0",
            instanceType: .lemmy
        )
    }
}
