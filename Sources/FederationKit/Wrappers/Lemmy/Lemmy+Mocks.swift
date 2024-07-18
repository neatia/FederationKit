//
//  Lemmy+Mocks.swift
//
//
//  Created by PEXAVC on 7/17/24.
//

import Foundation

extension FederatedComment {
    static var mock: Self {
        .init(
            id: "-1",
            creator_id: "-1",
            post_id: "-1",
            content: "mock content",
            removed: false,
            published: "-1",
            deleted: false,
            ap_id: "",
            local: false,
            path: "",
            distinguished: false,
            language_id: -1,
            instanceType: .unknown
        )
    }
}

extension FederatedPost {
    static var mock: Self {
        .init(
            id: "-1",
            name: "mock name",
            creator_id: "-1",
            community_id: "-1",
            removed: false,
            locked: false,
            published: "-1",
            deleted: false,
            nsfw: false,
            ap_id: "-1",
            local: false,
            language_id: -1,
            featured_community: false,
            featured_local: false,
            instanceType: .unknown
        )
    }
}

extension FederatedCommentAggregates {
    static var mock: Self {
        .init(
            id: "-1",
            comment_id: "-1",
            score: -1,
            upvotes: -1,
            downvotes: -1,
            published: "-1",
            child_count: -1,
            hot_rank: -1
        )
    }
}

extension FederatedPostAggregates {
    static var mock: Self {
        .init()
    }
}

extension FederatedPersonMention {
    static var mock: Self {
        .init()
    }
}

extension FederatedCommentReply {
    static var mock: Self {
        .init(
            id: "-1",
            recipient_id: "-1",
            comment_id: "-1",
            read: false,
            published: "-1"
        )
    }
}

extension FederatedSite {
    static var mock: Self {
        .init(
            id: -1,
            name: "",
            published: "",
            actor_id: "",
            last_refreshed_at: "",
            inbox_url: "",
            public_key: "",
            instance_id: -1
        )
    }
}

extension FederatedSiteDetails {
    static var mock: Self {
        .init()
    }
}

extension FederatedSiteRateLimit {
    static var mock: Self {
        .init()
    }
}

extension FederatedSiteAggregates {
    static var mock: Self {
        .init()
    }
}

extension UserInfo {
    static var mock: Self {
        .init(
            metadata: .init(),
            person: .mock,
            counts: .mock
        )
    }
}

extension UserMetadata {
    static var mock: Self {
        .init()
    }
}
