//
//  FederatedSite.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public struct FederatedSiteResource: Codable, Hashable {
    public let site: FederatedSite
    public let local_site: FederatedSiteDetails
    public let local_site_rate_limit: FederatedSiteRateLimit
    public let counts: FederatedSiteAggregates

    public init(
        site: FederatedSite? = nil,
        local_site: FederatedSiteDetails? = nil,
        local_site_rate_limit: FederatedSiteRateLimit? = nil,
        counts: FederatedSiteAggregates? = nil
    ) {
        self.site = site ?? .mock
        self.local_site = local_site ?? .mock
        self.local_site_rate_limit = local_site_rate_limit ?? .mock
        self.counts = counts ?? .mock
    }
}

public struct FederatedSite: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let sidebar: String?
    public let published: String
    public let updated: String?
    public let icon: String?
    public let banner: String?
    public let description: String?
    public let actor_id: String
    public let last_refreshed_at: String
    public let inbox_url: String?
    public let private_key: String?
    public let public_key: String
    public let instance_id: Int

    public init(
        id: Int? = nil,
        name: String? = nil,
        sidebar: String? = nil,
        published: String? = nil,
        updated: String? = nil,
        icon: String? = nil,
        banner: String? = nil,
        description: String? = nil,
        actor_id: String? = nil,
        last_refreshed_at: String? = nil,
        inbox_url: String? = nil,
        private_key: String? = nil,
        public_key: String? = nil,
        instance_id: Int? = nil
    ) {
        self.id = id ?? -1
        self.name = name ?? ""
        self.sidebar = sidebar
        self.published = published ?? "-1"
        self.updated = updated ?? "-1"
        self.icon = icon ?? ""
        self.banner = banner ?? "-1"
        self.description = description ?? ""
        self.actor_id = actor_id ?? "-1"
        self.last_refreshed_at = last_refreshed_at ?? "-1"
        self.inbox_url = inbox_url ?? ""
        self.private_key = private_key ?? ""
        self.public_key = public_key ?? "-1"
        self.instance_id = instance_id ?? -1
    }
}

public struct FederatedSiteAggregates: Codable, Identifiable, Hashable {
    public let id: Int
    public let site_id: Int
    public let users: Int
    public let posts: Int
    public let comments: Int
    public let communities: Int
    public let users_active_day: Int
    public let users_active_week: Int
    public let users_active_month: Int
    public let users_active_half_year: Int

    public init(
        id: Int? = nil,
        site_id: Int? = nil,
        users: Int? = nil,
        posts: Int? = nil,
        comments: Int? = nil,
        communities: Int? = nil,
        users_active_day: Int? = nil,
        users_active_week: Int? = nil,
        users_active_month: Int? = nil,
        users_active_half_year: Int? = nil
    ) {
        self.id = id ?? -1
        self.site_id = site_id ?? -1
        self.users = users ?? -1
        self.posts = posts ?? -1
        self.comments = comments ?? -1
        self.communities = communities ?? -1
        self.users_active_day = users_active_day ?? -1
        self.users_active_week = users_active_week ?? -1
        self.users_active_month = users_active_month ?? -1
        self.users_active_half_year = users_active_half_year ?? -1
    }
}

public struct FederatedSiteRateLimit: Codable, Identifiable, Hashable {
    public let id: Int
    public let local_site_id: Int
    public let message: Int
    public let message_per_second: Int
    public let post: Int
    public let post_per_second: Int
    public let register: Int
    public let register_per_second: Int
    public let image: Int
    public let image_per_second: Int
    public let comment: Int
    public let comment_per_second: Int
    public let search: Int
    public let search_per_second: Int
    public let published: String
    public let updated: String?

    public init(
        id: Int? = nil,
        local_site_id: Int? = nil,
        message: Int? = nil,
        message_per_second: Int? = nil,
        post: Int? = nil,
        post_per_second: Int? = nil,
        register: Int? = nil,
        register_per_second: Int? = nil,
        image: Int? = nil,
        image_per_second: Int? = nil,
        comment: Int? = nil,
        comment_per_second: Int? = nil,
        search: Int? = nil,
        search_per_second: Int? = nil,
        published: String? = nil,
        updated: String? = nil
    ) {
        self.id = id ?? -1
        self.local_site_id = local_site_id ?? -1
        self.message = message ?? -1
        self.message_per_second = message_per_second ?? -1
        self.post = post ?? -1
        self.post_per_second = post_per_second ?? -1
        self.register = register ?? -1
        self.register_per_second = register_per_second ?? -1
        self.image = image ?? -1
        self.image_per_second = image_per_second ?? -1
        self.comment = comment ?? -1
        self.comment_per_second = comment_per_second ?? -1
        self.search = search ?? -1
        self.search_per_second = search_per_second ?? -1
        self.published = published ?? "-1"
        self.updated = updated ?? "-1"
    }
}

public struct FederatedSiteDetails: Codable, Identifiable, Hashable {
    public let id: Int
    public let site_id: Int
    public let site_setup: Bool
    public let enable_downvotes: Bool
    public let enable_nsfw: Bool
    public let community_creation_admin_only: Bool
    public let require_email_verification: Bool
    public let application_question: String?
    public let private_instance: Bool
    public let default_theme: String
    public let default_post_listing_type: FederatedListingType
    public let legal_information: String?
    public let hide_modlog_mod_names: Bool
    public let application_email_admins: Bool
    public let slur_filter_regex: String?
    public let actor_name_max_length: Int
    public let federation_enabled: Bool
    public let captcha_enabled: Bool
    public let captcha_difficulty: String
    public let published: String
    public let updated: String?
    public let registration_mode: FederatedRegistrationType
    public let reports_email_admins: Bool

    public init(
        id: Int? = nil,
        site_id: Int? = nil,
        site_setup: Bool? = nil,
        enable_downvotes: Bool? = nil,
        enable_nsfw: Bool? = nil,
        community_creation_admin_only: Bool? = nil,
        require_email_verification: Bool? = nil,
        application_question: String? = nil,
        private_instance: Bool? = nil,
        default_theme: String? = nil,
        default_post_listing_type: FederatedListingType? = nil,
        legal_information: String? = nil,
        hide_modlog_mod_names: Bool? = nil,
        application_email_admins: Bool? = nil,
        slur_filter_regex: String? = nil,
        actor_name_max_length: Int? = nil,
        federation_enabled: Bool? = nil,
        captcha_enabled: Bool? = nil,
        captcha_difficulty: String? = nil,
        published: String? = nil,
        updated: String? = nil,
        registration_mode: FederatedRegistrationType? = nil,
        reports_email_admins: Bool? = nil
    ) {
        self.id = id ?? -1
        self.site_id = site_id ?? -1
        self.site_setup = site_setup ?? false
        self.enable_downvotes = enable_downvotes ?? false
        self.enable_nsfw = enable_nsfw ?? false
        self.community_creation_admin_only = community_creation_admin_only ?? false
        self.require_email_verification = require_email_verification ?? false
        self.application_question = application_question
        self.private_instance = private_instance ?? false
        self.default_theme = default_theme ?? ""
        self.default_post_listing_type = default_post_listing_type ?? .local
        self.legal_information = legal_information
        self.hide_modlog_mod_names = hide_modlog_mod_names ?? false
        self.application_email_admins = application_email_admins ?? false
        self.slur_filter_regex = slur_filter_regex
        self.actor_name_max_length = actor_name_max_length ?? 0
        self.federation_enabled = federation_enabled ?? false
        self.captcha_enabled = captcha_enabled ?? true
        self.captcha_difficulty = captcha_difficulty ?? "nani"
        self.published = published ?? "-1"
        self.updated = updated
        self.registration_mode = registration_mode ?? .closed
        self.reports_email_admins = reports_email_admins ?? false
    }
}

public struct FederatedSiteResult: Codable, Hashable {
    public let site_view: FederatedSiteResource
    public let admins: [FederatedPersonResource]
    public let version: String?
    public let my_user: UserResource?
//    public let all_languages: [LanguageId]
//    public let discussion_languages: [LanguageId]
//    public let taglines: [Tagline]
//    public let custom_emojis: [CustomEmojiView]

    public init(
        site_view: FederatedSiteResource,
        admins: [FederatedPersonResource],
        version: String? = nil,
        my_user: UserResource? = nil
//        all_languages: [Language],
//        discussion_languages: [LanguageId],
//        taglines: [Tagline],
//        custom_emojis: [CustomEmojiView]
    ) {
        self.site_view = site_view
        self.admins = admins
        self.version = version
        self.my_user = my_user
//        self.all_languages = all_languages
//        self.discussion_languages = discussion_languages
//        self.taglines = taglines
//        self.custom_emojis = custom_emojis
    }
}

public struct FederatedSiteMetadata: Codable, Hashable {
    public let title: String?
    public let description: String?
    public let image: String?
    public let embed_video_url: String?

    public init(
        title: String? = nil,
        description: String? = nil,
        image: String? = nil,
        embed_video_url: String? = nil
    ) {
        self.title = title
        self.description = description
        self.image = image
        self.embed_video_url = embed_video_url
    }
}
