//
//  UserResource.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public struct UserResource: Codable, Hashable {
    public let user: UserInfo
    public let follows: [CommunityRelationshipModel]
    public let moderates: [CommunityRelationshipModel]
    public let community_blocks: [CommunityRelationshipModel]
    public let person_blocks: [PersonRelationshipModel]
    public let discussion_languages: [Int]
    public let instanceType: FederatedInstanceType
    
    public var host: String {
        user.person.actor_id.host
    }

    public init(
        user: UserInfo,
        follows: [CommunityRelationshipModel],
        moderates: [CommunityRelationshipModel],
        community_blocks: [CommunityRelationshipModel],
        person_blocks: [PersonRelationshipModel],
        discussion_languages: [Int],
        instanceType: FederatedInstanceType
    ) {
        self.user = user
        self.follows = follows
        self.moderates = moderates
        self.community_blocks = community_blocks
        self.person_blocks = person_blocks
        self.discussion_languages = discussion_languages
        self.instanceType = instanceType
    }
}

public struct CommunityRelationshipModel: Codable, Hashable {
    public let person: FederatedPerson
    public let community: FederatedCommunity

    public init(
        person: FederatedPerson,
        community: FederatedCommunity
    ) {
        self.person = person
        self.community = community
    }
}

public struct PersonRelationshipModel: Codable, Hashable {
    public let person: FederatedPerson
    public let target: FederatedPerson

    public init(
        person: FederatedPerson,
        target: FederatedPerson
    ) {
        self.person = person
        self.target = target
    }
}

public struct UserInfo: Codable, Hashable {
    public let metadata: UserMetadata
    public let person: FederatedPerson
    public let counts: FederatedPersonAggregates

    public init(
        metadata: UserMetadata,
        person: FederatedPerson,
        counts: FederatedPersonAggregates
    ) {
        self.metadata = metadata
        self.person = person
        self.counts = counts
    }
}

public struct UserMetadata: Codable, Identifiable, Hashable {
    public let id: Int
    public let person_id: Int
    public let email: String?
    public let show_nsfw: Bool
    public let theme: String
    public let default_sort_type: FederatedSortType
    public let default_listing_type: FederatedListingType
    public let interface_language: String
    public let show_avatars: Bool
    public let send_notifications_to_email: Bool
    public let validator_time: String
    public let show_scores: Bool
    public let show_bot_accounts: Bool
    public let show_read_posts: Bool
    public let show_new_post_notifs: Bool
    public let email_verified: Bool
    public let accepted_application: Bool
    public let totp_2fa_url: String?
    public let open_links_in_new_tab: Bool

    public init(
        id: Int,
        person_id: Int,
        email: String? = nil,
        show_nsfw: Bool,
        theme: String,
        default_sort_type: FederatedSortType,
        default_listing_type: FederatedListingType,
        interface_language: String,
        show_avatars: Bool,
        send_notifications_to_email: Bool,
        validator_time: String,
        show_scores: Bool,
        show_bot_accounts: Bool,
        show_read_posts: Bool,
        show_new_post_notifs: Bool,
        email_verified: Bool,
        accepted_application: Bool,
        totp_2fa_url: String? = nil,
        open_links_in_new_tab: Bool
    ) {
        self.id = id
        self.person_id = person_id
        self.email = email
        self.show_nsfw = show_nsfw
        self.theme = theme
        self.default_sort_type = default_sort_type
        self.default_listing_type = default_listing_type
        self.interface_language = interface_language
        self.show_avatars = show_avatars
        self.send_notifications_to_email = send_notifications_to_email
        self.validator_time = validator_time
        self.show_scores = show_scores
        self.show_bot_accounts = show_bot_accounts
        self.show_read_posts = show_read_posts
        self.show_new_post_notifs = show_new_post_notifs
        self.email_verified = email_verified
        self.accepted_application = accepted_application
        self.totp_2fa_url = totp_2fa_url
        self.open_links_in_new_tab = open_links_in_new_tab
    }
}
