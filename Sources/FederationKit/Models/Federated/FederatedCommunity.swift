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
        community: FederatedCommunity? = nil,
        subscribed: FederatedSubscribedType? = nil,
        blocked: Bool? = nil,
        counts: FederatedCommunityAggregates? = nil
    ) {
        self.community = community ?? .mock
        self.subscribed = subscribed ?? .notSubscribed
        self.blocked = blocked ?? false
        self.counts = counts ?? .mock
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
        id: String? = nil,
        name: String? = nil,
        title: String? = nil,
        description: String? = nil,
        removed: Bool? = nil,
        published: String? = nil,
        updated: String? = nil,
        deleted: Bool? = nil,
        nsfw: Bool? = nil,
        actor_id: String? = nil,
        local: Bool? = nil,
        icon: String? = nil,
        banner: String? = nil,
        followers_url: String? = nil,
        inbox_url: String? = nil,
        hidden: Bool? = nil,
        posting_restricted_to_mods: Bool? = nil,
        instance_id: String? = nil,
        instanceType: FederatedInstanceType? = nil
    ) {
        self.id = id ?? "-1"
        self.name = name ?? "mock name"
        self.title = title ?? "mock title"
        self.description = description ?? "mock description"
        self.removed = removed ?? false
        self.published = published ?? "-1"
        self.updated = updated ?? "-1"
        self.deleted = deleted ?? false
        self.nsfw = nsfw ?? false
        self.actor_id = actor_id ?? "-1"
        self.local = local ?? false
        self.icon = icon
        self.banner = banner
        self.followers_url = followers_url
        self.inbox_url = inbox_url
        self.hidden = hidden ?? false
        self.posting_restricted_to_mods = posting_restricted_to_mods ?? false
        self.instance_id = instance_id ?? "-1"
        self.instanceType = instanceType ?? .unknown
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
        id: String? = nil,
        community_id: CommunityId? = nil,
        subscribers: Int? = nil,
        posts: Int? = nil,
        comments: Int? = nil,
        published: String? = nil,
        users_active_day: Int? = nil,
        users_active_week: Int? = nil,
        users_active_month: Int? = nil,
        users_active_half_year: Int? = nil,
        hot_rank: Int? = nil
    ) {
        self.id = id ?? "-1"
        self.community_id = community_id ?? -1
        self.subscribers = subscribers ?? 0
        self.posts = posts ?? 0
        self.comments = comments ?? 0
        self.published = published ?? "-1"
        self.users_active_day = users_active_day ?? 0
        self.users_active_week = users_active_week ?? 0
        self.users_active_month = users_active_month ?? 0
        self.users_active_half_year = users_active_half_year ?? 0
        self.hot_rank = hot_rank ?? 0
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
