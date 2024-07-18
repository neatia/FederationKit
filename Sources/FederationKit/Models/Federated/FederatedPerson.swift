//
//  Resources.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit

public struct FederatedPersonResource: Codable, Hashable {
    public var person: FederatedPerson
    public var counts: FederatedPersonAggregates
    
    public init(person: FederatedPerson? = nil, counts: FederatedPersonAggregates? = nil) {
        self.person = person ?? .mock
        self.counts = counts ?? .mock
    }
}

public struct FederatedPerson: Codable, Identifiable, Hashable {
    public let id: String
    public let name: String
    public let display_name: String?
    public let avatar: String?
    public let banned: Bool
    public let published: String
    public let updated: String?
    public let actor_id: String
    public let bio: String?
    public let local: Bool
    public let banner: String?
    public let deleted: Bool
    public let inbox_url: String?
    public let matrix_user_id: String?
    public let admin: Bool
    public let bot_account: Bool
    public let ban_expires: String?
    public let instance_id: String
    public let instanceType: FederatedInstanceType
    
    public init(
        id: String? = nil,
        name: String? = nil,
        display_name: String? = nil,
        avatar: String? = nil,
        banned: Bool? = nil,
        published: String? = nil,
        updated: String? = nil,
        actor_id: String? = nil,
        bio: String? = nil,
        local: Bool? = nil,
        banner: String? = nil,
        deleted: Bool? = nil,
        inbox_url: String? = nil,
        matrix_user_id: String? = nil,
        admin: Bool? = nil,
        bot_account: Bool? = nil,
        ban_expires: String? = nil,
        instance_id: String? = nil,
        instanceType: FederatedInstanceType? = nil
    ) {
        self.id = id ?? "-1"
        self.name = name ?? "mock name"
        self.display_name = display_name
        self.avatar = avatar
        self.banned = banned ?? false
        self.published = published ?? "-1"
        self.updated = updated
        self.actor_id = actor_id ?? "-1"
        self.bio = bio
        self.local = local ?? false
        self.banner = banner
        self.deleted = deleted ?? false
        self.inbox_url = inbox_url
        self.matrix_user_id = matrix_user_id
        self.admin = admin ?? false
        self.bot_account = bot_account ?? false
        self.ban_expires = ban_expires
        self.instance_id = instance_id ?? "-1"
        self.instanceType = instanceType ?? .unknown
    }
}

public extension FederatedPerson {
    static var mock: FederatedPerson {
        .init(
            id: "0",
            name: "J. Doe",
            display_name: nil,
            avatar: nil,
            banned: false,
            published: "\(Date())",
            updated: nil,
            actor_id: "",
            bio: "This is a bio",
            local: true,
            banner: nil,
            deleted: false,
            inbox_url: nil,
            matrix_user_id: nil,
            admin: false,
            bot_account: false,
            ban_expires: nil,
            instance_id: "0",
            instanceType: .unknown)
    }
}

extension FederatedPerson {
    public var domain: String? {
        URL(string: actor_id)?.hostString
    }
    
    public var isMe: Bool {
        FederationKit.isMe(self)
    }
    
    public var isHome: Bool {
        FederationKit.isHome(self)
    }
    
    public var username: String {
        self.name + "@" + self.actor_id.host
    }
    
    public func equals(_ person: FederatedPerson) -> Bool {
        return domain == person.domain && name == person.name
    }
}

extension FederatedPerson {
    public var avatarURL: URL? {
        if let urlString = avatar {
            return URL(string: urlString)
        }
        return nil
    }
}

public struct FederatedPersonAggregates: Codable, Identifiable, Hashable {
    public let id: String
    public let person_id: String
    public let post_count: Int
    public let post_score: Int
    public let comment_count: Int
    public let comment_score: Int
    public let following_count: Int
    public let followers_count: Int

    public init(
        id: String? = nil,
        person_id: String? = nil,
        post_count: Int? = nil,
        post_score: Int? = nil,
        comment_count: Int? = nil,
        comment_score: Int? = nil,
        following_count: Int = 0,
        followers_count: Int = 0
    ) {
        self.id = id ?? "-1"
        self.person_id = person_id ?? "-1"
        self.post_count = post_count ?? 0
        self.post_score = post_score ?? 0
        self.comment_count = comment_count ?? 0
        self.comment_score = comment_score ?? 0
        self.following_count = following_count
        self.followers_count = followers_count
    }
}

public struct FederatedPersonDetails: Codable, Hashable {
    public let person_view: FederatedPersonResource
    public let comments: [FederatedCommentResource]
    public let posts: [FederatedPostResource]
   // public let moderates: [CommunityModeratorView]

    public init(
        person_view: FederatedPersonResource,
        comments: [FederatedCommentResource],
        posts: [FederatedPostResource]//,
        //moderates: [CommunityModeratorView]
    ) {
        self.person_view = person_view
        self.comments = comments
        self.posts = posts
        //self.moderates = moderates
    }
}

public extension FederatedPersonAggregates {
    static var mock: FederatedPersonAggregates {
        .init(id: "0", person_id: "0", post_count: 0, post_score: 0, comment_count: 0, comment_score: 0)
    }
}

extension FederatedPersonAggregates {
    public var totalScore: Int {
        comment_score + post_score
    }
}

public struct FederatedPersonMentionResource: Codable, Hashable {
    public let person_mention: FederatedPersonMention
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
        person_mention: FederatedPersonMention? = nil,
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
        self.person_mention = person_mention ?? .mock
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
        self.my_vote = my_vote ?? 0
    }
}

public struct FederatedPersonMention: Codable, Identifiable, Hashable {
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

public struct FederatedPersonMentionList: Codable, Hashable {
    public let mentions: [FederatedPersonMentionResource]

    public init(
        mentions: [FederatedPersonMentionResource]
    ) {
        self.mentions = mentions
    }
}

public struct FederatedPersonRepliesList: Codable, Hashable {
    public let replies: [FederatedCommentReplyResource]

    public init(
        replies: [FederatedCommentReplyResource]
    ) {
        self.replies = replies
    }
}


public extension FederatedPersonMentionResource {
    var asCommentResource: FederatedCommentResource {
        .init(comment: comment,
              creator: creator,
              post: post, community: community,
              counts: counts, creator_banned_from_community: creator_banned_from_community,
              subscribed: subscribed,
              saved: saved,
              creator_blocked: creator_blocked)
    }
}
