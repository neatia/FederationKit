//
//  Lemmy.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit

extension FederatedInstances {
    var federated: FederatedInstanceList {
        .init(linked: self.linked?.map {
            $0.federated
        } ?? [],
              allowed: self.allowed?.map {
            $0.federated
        } ?? [],
              blocked: self.blocked?.map {
            $0.federated
        } ?? [])
    }
}

extension Instance {
    var federated: FederatedInstance {
        .init(.lemmy,
              id: self.id?.asString,
              domain: self.domain,
              published: self.published,
              updated: self.updated,
              software: self.software,
              version: self.version)
    }
}

extension SiteMetadata {
    var federated: FederatedSiteMetadata {
        .init(title: self.title,
              description: self.description,
              image: self.image,
              embed_video_url: self.embed_video_url)
    }
}

extension GetSiteResponse {
    var federated: FederatedSiteResult {
        .init(site_view: self.site_view.federated,
              admins: self.admins.map { $0.federated },
              version: self.version,
              my_user: self.my_user?.federated)
    }
}

extension MyUserInfo {
    var federated: UserResource {
        .init(user: self.local_user_view?.federated,
              follows: self.follows?.compactMap {
            .init(
                person: $0.follower?.federated,
                community: $0.community?.federated
            )
        },
              moderates: self.moderates?.compactMap {
            .init(
                person: $0.moderator?.federated,
                community: $0.community?.federated
            )
        },
              community_blocks: self.community_blocks?.compactMap {
            .init(
                person: $0.person?.federated,
                community: $0.community?.federated
            )
        },
              person_blocks: self.person_blocks?.compactMap {
            .init(
                person: $0.person?.federated,
                target: $0.target?.federated
            )
        },
              discussion_languages: self.discussion_languages,
              instanceType: .lemmy)
    }
}

extension LocalUserView {
    var federated: UserInfo {
        .init(metadata: self.local_user?.federated,
              person: self.person?.federated,
              counts: self.counts?.federated)
    }
}

extension LocalUser {
    var federated: UserMetadata {
        .init(id: self.id,
              person_id: self.person_id,
              show_nsfw: self.show_nsfw,
              theme: self.theme,
              default_sort_type: self.default_sort_type?.federated,
              default_listing_type: self.default_listing_type?.federated,
              interface_language: self.interface_language,
              show_avatars: self.show_avatars,
              send_notifications_to_email: self.send_notifications_to_email,
              show_scores: self.show_scores,
              show_bot_accounts: self.show_bot_accounts,
              show_read_posts: self.show_read_posts,
              email_verified: self.email_verified,
              accepted_application: self.accepted_application,
              open_links_in_new_tab: self.open_links_in_new_tab)
    }
}

extension SiteView {
    var federated: FederatedSiteResource {
        .init(site: self.site?.federated,
              local_site: self.local_site?.federated,
              local_site_rate_limit: self.local_site_rate_limit?.federated,
              counts: self.counts?.federated)
    }
}

extension Site {
    var federated: FederatedSite {
        .init(id: self.id,
              name: self.name,
              sidebar: self.sidebar,
              published: self.published,
              updated: self.updated,
              icon: self.icon,
              banner: self.banner,
              description: self.description,
              actor_id: self.actor_id,
              last_refreshed_at: self.last_refreshed_at,
              inbox_url: self.inbox_url,
              private_key: self.private_key,
              public_key: self.public_key,
              instance_id: self.instance_id)
    }
}

extension LocalSite {
    var federated: FederatedSiteDetails {
        .init(id: self.id,
              site_id: self.site_id,
              site_setup: self.site_setup,
              enable_downvotes: self.enable_downvotes,
              enable_nsfw: self.enable_nsfw,
              community_creation_admin_only: self.community_creation_admin_only,
              require_email_verification: self.require_email_verification,
              application_question: self.application_question,
              private_instance: self.private_instance,
              default_theme: self.default_theme,
              default_post_listing_type: self.default_post_listing_type?.federated,
              hide_modlog_mod_names: self.hide_modlog_mod_names,
              application_email_admins: self.application_email_admins,
              slur_filter_regex: self.slur_filter_regex,
              actor_name_max_length: self.actor_name_max_length,
              federation_enabled: self.federation_enabled,
              captcha_enabled: self.captcha_enabled,
              captcha_difficulty: self.captcha_difficulty,
              published: self.published,
              updated: self.updated,
              registration_mode: self.registration_mode?.federated,
              reports_email_admins: self.reports_email_admins)
    }
}

extension LocalSiteRateLimit {
    var federated: FederatedSiteRateLimit {
        .init(local_site_id: self.local_site_id,
              message: self.message,
              message_per_second: self.message_per_second,
              post: self.post,
              post_per_second: self.post_per_second,
              register: self.register,
              register_per_second: self.register_per_second,
              image: self.image,
              image_per_second: self.image_per_second,
              comment: self.comment,
              comment_per_second: self.comment_per_second,
              search: self.search,
              search_per_second: self.search_per_second,
              published: self.published)
    }
}

extension SiteAggregates {
    var federated: FederatedSiteAggregates {
        .init(site_id: self.site_id,
              users: self.users,
              posts: self.posts,
              comments: self.comments,
              communities: self.communities,
              users_active_day: self.users_active_day,
              users_active_week: self.users_active_week,
              users_active_month: self.users_active_month,
              users_active_half_year: self.users_active_half_year)
    }
}

extension RegistrationMode {
    var federated: FederatedRegistrationType {
        .init(rawValue: self.rawValue) ?? .closed
    }
}

extension ImageFile {
    var federated: FederatedMediaMetadata {
        .init(file: self.file, delete_token: self.delete_token)
    }
}

extension Search.Response {
    var federated: FederatedSearchResult {
        .init(type_: self.type_.federated,
              comments: self.comments.map { $0.federated },
              posts: self.posts.map { $0.federated },
              communities: self.communities.map { $0.federated },
              users: self.users.map { $0.federated })
    }
}

extension SearchType {
    var federated: FederatedSearchType {
        .init(rawValue: self.rawValue) ?? .all
    }
}

extension GetPersonMentionsResponse {
    var federated: FederatedPersonMentionList {
        .init(mentions: self.mentions.map { $0.federated })
    }
}

extension GetRepliesResponse {
    var federated: FederatedPersonRepliesList {
        .init(replies: self.replies.map { $0.federated })
    }
}

extension CommentReply {
    var federated: FederatedCommentReply {
        .init(id: self.id?.asString,
              recipient_id: self.recipient_id?.asString,
              comment_id: self.comment_id?.asString,
              read: self.read,
              published: self.published)
    }
}
extension CommentReplyView {
    var federated: FederatedCommentReplyResource {
        .init(comment_reply: self.comment_reply?.federated,
              comment: self.comment?.federated,
              creator: self.creator?.federated,
              post: self.post?.federated,
              community: self.community?.federated,
              recipient: self.recipient?.federated,
              counts: self.counts?.federated,
              creator_banned_from_community: self.creator_banned_from_community,
              subscribed: self.subscribed?.federated,
              saved: self.saved,
              creator_blocked: self.creator_blocked)
    }
}

extension PersonMentionView {
    var federated: FederatedPersonMentionResource {
        .init(person_mention: self.person_mention?.federated,
              comment: self.comment?.federated,
              creator: self.creator?.federated,
              post: self.post?.federated,
              community: self.community?.federated,
              recipient: self.recipient?.federated,
              counts: self.counts?.federated,
              creator_banned_from_community: self.creator_banned_from_community,
              subscribed: self.subscribed?.federated,
              saved: self.saved,
              creator_blocked: self.creator_blocked)
    }
}

extension PersonMention {
    var federated: FederatedPersonMention {
        .init(id: self.id?.asString,
              recipient_id: self.recipient_id?.asString,
              comment_id: self.comment_id?.asString,
              read: self.read,
              published: self.published)
    }
}
extension GetPersonDetailsResponse {
    public var federated: FederatedPersonDetails {
        .init(person_view: self.person_view.federated,
              comments: self.comments.map { $0.federated },
              posts: self.posts.map { $0.federated })
    }
}

extension SubscribedType {
    var federated: FederatedSubscribedType {
        .init(rawValue: self.rawValue) ?? .notSubscribed
    }
}

extension ListingType {
    public var federated: FederatedListingType {
        return .init(rawValue: self.rawValue) ?? .local
    }
}

extension SortType {
    public var federated: FederatedSortType {
        return .init(rawValue: self.rawValue) ?? .hot
    }
}

//MARK: To Lemmy

extension FederatedCommunity {
    public var lemmy: Community {
        .init(id: self.id.asInt,
              name: self.name,
              title: self.title,
              description: self.description,
              removed: self.removed,
              published: self.published,
              updated: self.updated,
              deleted: self.deleted,
              nsfw: self.nsfw,
              actor_id: self.actor_id,
              local: self.local,
              icon: self.icon,
              banner: self.banner,
//              followers_url: self.followers_url,
//              inbox_url: self.inbox_url,
              hidden: self.hidden,
              posting_restricted_to_mods: self.posting_restricted_to_mods,
              instance_id: self.instance_id.asInt)
    }
}

extension FederatedComment {
    public var lemmy: Comment {
        .init(id: self.id.asInt,
              creator_id: self.creator_id.asInt,
              post_id: self.post_id.asInt,
              content: self.content,
              removed: self.removed,
              published: self.published,
              updated: self.updated,
              deleted: self.deleted,
              ap_id: self.ap_id,
              local: self.local,
              path: self.path,
              distinguished: self.distinguished,
              language_id: self.language_id)
    }
}

extension FederatedPost {
    public var lemmy: Post {
        .init(id: self.id.asInt,
              name: self.name,
              url: self.url,
              body: self.body,
              creator_id: self.creator_id.asInt,
              community_id: self.community_id.asInt,
              removed: self.removed,
              locked: self.locked,
              published: self.published,
              updated: self.updated,
              deleted: self.deleted,
              nsfw: self.nsfw,
              embed_title: self.embed_title,
              embed_description: self.embed_description,
              thumbnail_url: self.thumbnail_url,
              ap_id: self.ap_id,
              local: self.local,
              embed_video_url: self.embed_video_url,
              language_id: self.language_id,
              featured_community: self.featured_community,
              featured_local: self.featured_local)
    }
}

extension FederatedPerson {
    public var lemmy: Person {
        .init(id: self.id.asInt,
              name: self.name,
              display_name: self.display_name,
              avatar: self.avatar,
              banned: self.banned,
              published: self.published,
              updated: self.updated,
              actor_id: self.actor_id,
              bio: self.bio,
              local: self.local,
              banner: self.banner,
              deleted: self.deleted,
//              inbox_url: self.inbox_url,
              matrix_user_id: self.matrix_user_id,
//              admin: self.admin,
              bot_account: self.bot_account,
              ban_expires: self.ban_expires,
              instance_id: self.instance_id.asInt)
    }
}

extension FederatedSearchType {
    var lemmy: SearchType {
        .init(rawValue: self.rawValue) ?? .all
    }
}

extension FederatedListingType {
    public var lemmy: ListingType {
        return .init(rawValue: self.rawValue) ?? .local
    }
}

extension FederatedSortType {
    public var lemmy: SortType {
        return .init(rawValue: self.rawValue) ?? .hot
    }
}

extension FederatedCommentSortType {
    public var lemmy: CommentSortType {
        return .init(rawValue: self.rawValue) ?? .hot
    }
}

extension FederatedLocationType {
    public var lemmy: FetchType {
        switch self {
        case .base:
            return .base
        case .source:
            return .source
        case .peer(let host):
            return .peer(host)
        }
    }
}
