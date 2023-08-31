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
    
    public init(person: FederatedPerson, counts: FederatedPersonAggregates) {
        self.person = person
        self.counts = counts
    }
}

public struct FederatedPerson: Codable, Identifiable, Hashable {
    public let id: Int
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
    public let instance_id: Int
    
    public init(
        id: Int,
        name: String,
        display_name: String? = nil,
        avatar: String? = nil,
        banned: Bool,
        published: String,
        updated: String? = nil,
        actor_id: String,
        bio: String? = nil,
        local: Bool,
        banner: String? = nil,
        deleted: Bool,
        inbox_url: String?,
        matrix_user_id: String? = nil,
        admin: Bool,
        bot_account: Bool,
        ban_expires: String? = nil,
        instance_id: Int
    ) {
        self.id = id
        self.name = name
        self.display_name = display_name
        self.avatar = avatar
        self.banned = banned
        self.published = published
        self.updated = updated
        self.actor_id = actor_id
        self.bio = bio
        self.local = local
        self.banner = banner
        self.deleted = deleted
        self.inbox_url = inbox_url
        self.matrix_user_id = matrix_user_id
        self.admin = admin
        self.bot_account = bot_account
        self.ban_expires = ban_expires
        self.instance_id = instance_id
    }
}

public extension FederatedPerson {
    static var mock: FederatedPerson {
        .init(
            id: 0,
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
            instance_id: 0
        )
    }
}

extension FederatedPerson {
    public var domain: String? {
        URL(string: actor_id)?.hostString
    }
    
    public var isMe: Bool {
        FederationKit.isMe(self)
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
    public let id: Int
    public let person_id: PersonId
    public let post_count: Int
    public let post_score: Int
    public let comment_count: Int
    public let comment_score: Int

    public init(
        id: Int,
        person_id: PersonId,
        post_count: Int,
        post_score: Int,
        comment_count: Int,
        comment_score: Int
    ) {
        self.id = id
        self.person_id = person_id
        self.post_count = post_count
        self.post_score = post_score
        self.comment_count = comment_count
        self.comment_score = comment_score
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
        .init(id: 0, person_id: 0, post_count: 0, post_score: 0, comment_count: 0, comment_score: 0)
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
        person_mention: FederatedPersonMention,
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
        self.person_mention = person_mention
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

public struct FederatedPersonMention: Codable, Identifiable, Hashable {
    public let id: Int
    public let recipient_id: Int
    public let comment_id: Int
    public let read: Bool
    public let published: String

    public init(
        id: Int,
        recipient_id: Int,
        comment_id: Int,
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
