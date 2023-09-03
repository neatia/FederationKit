//
//  File.swift
//  
//
//  Created by Ritesh Pakala on 9/3/23.
//

import Foundation
import FeedKit

extension RSSFeedItem {
    var id: String {
        self.link ?? UUID().uuidString
    }
    public var federatedPost: FederatedPost {
        .init(id: self.id,
              name: self.title ?? "",
              url: self.link ?? "",
              body: self.description ?? "",
              creator_id: "",
              community_id: "",
              removed: false,
              locked: false,
              published: self.pubDate?.asServerTimeString ?? "",
              updated: nil,
              deleted: false,
              nsfw: false,
              embed_title: nil,
              embed_description: nil,
              thumbnail_url: nil,
              ap_id: self.link ?? "",
              local: false,
              language_id: 0,
              featured_community: false,
              featured_local: false,
              instanceType: .rss)
    }
    
    var federatedCounts: FederatedPostAggregates {
        .init(id: self.id,
              post_id: self.id,
              comments: 0,
              score: 0,
              upvotes: 0,
              downvotes: 0,
              published: self.pubDate?.asServerTimeString ?? "",
              newest_comment_time_necro: self.pubDate?.asServerTimeString ?? "",
              newest_comment_time: self.pubDate?.asServerTimeString ?? "",
              featured_community: false,
              featured_local: false,
              hot_rank: 0,
              hot_rank_active: 0,
              reblog_count: 0)
    }
    
    var asResource: FederatedPostResource {
        .init(post: self.federatedPost,
              creator: self.source?.federatedPerson ?? .mock,
              community: self.categories?.first?.federatedCommunity ?? .mock,
              creator_banned_from_community: false,
              counts: self.federatedCounts,
              subscribed: .notSubscribed,
              saved: false,
              read: true,
              creator_blocked: false,
              my_vote: 0,
              unread_comments: 0)
    }
}

extension RSSFeedItemSource {
    var id: String {
        self.attributes?.url ?? ""
    }
    
    var federatedPerson: FederatedPerson {
        .init(id: id,
              name: self.value ?? "",
              display_name: nil,
              avatar: nil,//avatarStatic as well
              banned: false,
              published: Date().asServerTimeString,
              updated: nil,
              actor_id: self.attributes?.url ?? "",
              bio: self.value ?? "",
              local: false,//match actorid to client baseurl
              banner: nil,
              deleted: false,
              inbox_url: nil,
              matrix_user_id: nil,
              admin: false,
              bot_account: false,
              ban_expires: nil,
              instance_id: "-12",
              instanceType: .rss)
    }
    
    var federatedCounts: FederatedPersonAggregates {
        .init(id: id,
              person_id: self.id,
              post_count: 0,
              post_score: 0,
              comment_count: 0,
              comment_score: 0,
              following_count: 0,
              followers_count: 0)
    }
    
    var asResource: FederatedPersonResource {
        .init(person: self.federatedPerson,
              counts: self.federatedCounts
        )
    }
}

extension RSSFeedItemCategory {
    var federatedCommunity: FederatedCommunity {
        .init(id: self.value ?? "",
              name: self.value ?? "",
              title: "",
              description: "",
              removed: false,
              published: "",
              updated: nil,
              deleted: false,
              nsfw: false,
              actor_id: self.value ?? "",
              local: false,
              icon: nil,
              banner: nil,//maybe mastodon instance banner?
              followers_url: "",
              inbox_url: "",
              hidden: false,
              posting_restricted_to_mods: false,
              instance_id: "-1",
              instanceType: .rss)
    }
}
