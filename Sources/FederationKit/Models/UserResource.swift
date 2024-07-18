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
        user: UserInfo? = nil,
        follows: [CommunityRelationshipModel]? = nil,
        moderates: [CommunityRelationshipModel]? = nil,
        community_blocks: [CommunityRelationshipModel]? = nil,
        person_blocks: [PersonRelationshipModel]? = nil,
        discussion_languages: [Int]? = nil,
        instanceType: FederatedInstanceType? = nil
    ) {
        self.user = user ?? .mock
        self.follows = follows ?? []
        self.moderates = moderates ?? []
        self.community_blocks = community_blocks ?? []
        self.person_blocks = person_blocks ?? []
        self.discussion_languages = discussion_languages ?? []
        self.instanceType = instanceType ?? .unknown
    }
}

public struct CommunityRelationshipModel: Codable, Hashable {
    public let person: FederatedPerson
    public let community: FederatedCommunity

    public init(
        person: FederatedPerson? = nil,
        community: FederatedCommunity? = nil
    ) {
        self.person = person ?? .mock
        self.community = community ?? .mock
    }
}

public struct PersonRelationshipModel: Codable, Hashable {
    public let person: FederatedPerson
    public let target: FederatedPerson

    public init(
        person: FederatedPerson? = nil,
        target: FederatedPerson? = nil
    ) {
        self.person = person ?? .mock
        self.target = target ?? .mock
    }
}

public struct UserInfo: Codable, Hashable {
    public let metadata: UserMetadata
    public let person: FederatedPerson
    public let counts: FederatedPersonAggregates

    public init(
        metadata: UserMetadata? = nil,
        person: FederatedPerson? = nil,
        counts: FederatedPersonAggregates? = nil
    ) {
        self.metadata = metadata ?? .mock
        self.person = person ?? .mock
        self.counts = counts ?? .mock
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
        id: Int? = nil,
        person_id: Int? = nil,
        email: String? = nil,
        show_nsfw: Bool? = nil,
        theme: String? = nil,
        default_sort_type: FederatedSortType? = nil,
        default_listing_type: FederatedListingType? = nil,
        interface_language: String? = nil,
        show_avatars: Bool? = nil,
        send_notifications_to_email: Bool? = nil,
        validator_time: String? = nil,
        show_scores: Bool? = nil,
        show_bot_accounts: Bool? = nil,
        show_read_posts: Bool? = nil,
        show_new_post_notifs: Bool? = nil,
        email_verified: Bool? = nil,
        accepted_application: Bool? = nil,
        totp_2fa_url: String? = nil,
        open_links_in_new_tab: Bool? = nil
    ) {
        self.id = id ?? -1
        self.person_id = person_id ?? -1
        self.email = email
        self.show_nsfw = show_nsfw ?? false
        self.theme = theme ?? ""
        self.default_sort_type = default_sort_type ?? .old
        self.default_listing_type = default_listing_type ?? .all
        self.interface_language = interface_language ?? ""
        self.show_avatars = show_avatars ?? false
        self.send_notifications_to_email = send_notifications_to_email ?? false
        self.validator_time = validator_time ?? ""
        self.show_scores = show_scores ?? false
        self.show_bot_accounts = show_bot_accounts ?? false
        self.show_read_posts = show_read_posts ?? false
        self.show_new_post_notifs = show_new_post_notifs ?? false
        self.email_verified = email_verified ?? false
        self.accepted_application = accepted_application ?? false
        self.totp_2fa_url = totp_2fa_url
        self.open_links_in_new_tab = open_links_in_new_tab ?? false
    }
}
