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
        site: FederatedSite,
        local_site: FederatedSiteDetails,
        local_site_rate_limit: FederatedSiteRateLimit,
        counts: FederatedSiteAggregates
    ) {
        self.site = site
        self.local_site = local_site
        self.local_site_rate_limit = local_site_rate_limit
        self.counts = counts
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
        id: Int,
        name: String,
        sidebar: String? = nil,
        published: String,
        updated: String? = nil,
        icon: String? = nil,
        banner: String? = nil,
        description: String? = nil,
        actor_id: String,
        last_refreshed_at: String,
        inbox_url: String?,
        private_key: String? = nil,
        public_key: String,
        instance_id: Int
    ) {
        self.id = id
        self.name = name
        self.sidebar = sidebar
        self.published = published
        self.updated = updated
        self.icon = icon
        self.banner = banner
        self.description = description
        self.actor_id = actor_id
        self.last_refreshed_at = last_refreshed_at
        self.inbox_url = inbox_url
        self.private_key = private_key
        self.public_key = public_key
        self.instance_id = instance_id
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
        id: Int,
        site_id: Int,
        users: Int,
        posts: Int,
        comments: Int,
        communities: Int,
        users_active_day: Int,
        users_active_week: Int,
        users_active_month: Int,
        users_active_half_year: Int
    ) {
        self.id = id
        self.site_id = site_id
        self.users = users
        self.posts = posts
        self.comments = comments
        self.communities = communities
        self.users_active_day = users_active_day
        self.users_active_week = users_active_week
        self.users_active_month = users_active_month
        self.users_active_half_year = users_active_half_year
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
        id: Int,
        local_site_id: Int,
        message: Int,
        message_per_second: Int,
        post: Int,
        post_per_second: Int,
        register: Int,
        register_per_second: Int,
        image: Int,
        image_per_second: Int,
        comment: Int,
        comment_per_second: Int,
        search: Int,
        search_per_second: Int,
        published: String,
        updated: String? = nil
    ) {
        self.id = id
        self.local_site_id = local_site_id
        self.message = message
        self.message_per_second = message_per_second
        self.post = post
        self.post_per_second = post_per_second
        self.register = register
        self.register_per_second = register_per_second
        self.image = image
        self.image_per_second = image_per_second
        self.comment = comment
        self.comment_per_second = comment_per_second
        self.search = search
        self.search_per_second = search_per_second
        self.published = published
        self.updated = updated
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
        id: Int,
        site_id: Int,
        site_setup: Bool,
        enable_downvotes: Bool,
        enable_nsfw: Bool,
        community_creation_admin_only: Bool,
        require_email_verification: Bool,
        application_question: String? = nil,
        private_instance: Bool,
        default_theme: String,
        default_post_listing_type: FederatedListingType,
        legal_information: String? = nil,
        hide_modlog_mod_names: Bool,
        application_email_admins: Bool,
        slur_filter_regex: String? = nil,
        actor_name_max_length: Int,
        federation_enabled: Bool,
        captcha_enabled: Bool,
        captcha_difficulty: String,
        published: String,
        updated: String? = nil,
        registration_mode: FederatedRegistrationType,
        reports_email_admins: Bool
    ) {
        self.id = id
        self.site_id = site_id
        self.site_setup = site_setup
        self.enable_downvotes = enable_downvotes
        self.enable_nsfw = enable_nsfw
        self.community_creation_admin_only = community_creation_admin_only
        self.require_email_verification = require_email_verification
        self.application_question = application_question
        self.private_instance = private_instance
        self.default_theme = default_theme
        self.default_post_listing_type = default_post_listing_type
        self.legal_information = legal_information
        self.hide_modlog_mod_names = hide_modlog_mod_names
        self.application_email_admins = application_email_admins
        self.slur_filter_regex = slur_filter_regex
        self.actor_name_max_length = actor_name_max_length
        self.federation_enabled = federation_enabled
        self.captcha_enabled = captcha_enabled
        self.captcha_difficulty = captcha_difficulty
        self.published = published
        self.updated = updated
        self.registration_mode = registration_mode
        self.reports_email_admins = reports_email_admins
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
