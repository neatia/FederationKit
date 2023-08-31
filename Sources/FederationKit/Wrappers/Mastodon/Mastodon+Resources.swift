//
//  Lemmy+Resources.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import MastodonKit

extension Status {
    public var federatedPost: FederatedPost {
        .init(id: self.id,
              name: "",
              url: self.thumbnailUrl,
              body: self.content.plainText,
              creator_id: self.account.id,
              community_id: "",
              removed: false,
              locked: false,
              published: self.createdAt.asString,
              updated: nil,
              deleted: false,
              nsfw: self.sensitive == true,
              embed_title: nil,
              embed_description: nil,
              thumbnail_url: self.thumbnailUrl,
              ap_id: self.uri,
              local: false,
              embed_video_url: nil,
              language_id: self.language?.asInt ?? -1,//wont work need to revise
              featured_community: self.pinned == true,
              featured_local: false,
              instanceType: .mastodon)
    }
    
    var federatedCounts: FederatedPostAggregates {
        .init(id: self.id,
              post_id: self.id,
              comments: self.repliesCount,
              score: 0,
              upvotes: self.favouritesCount,
              downvotes: 0,
              published: self.createdAt.asString,
              newest_comment_time_necro: self.createdAt.asString,
              newest_comment_time: self.createdAt.asString,
              featured_community: false,
              featured_local: false,
              hot_rank: 0,
              hot_rank_active: 0,
              reblog_count: self.reblogsCount)
    }
    
    var asResource: FederatedPostResource {
        .init(post: self.federatedPost,
              creator: self.account.federatedPerson,
              community: self.account.federatedCommunity,
              creator_banned_from_community: false,
              counts: self.federatedCounts,
              subscribed: .notSubscribed,
              saved: self.bookmarked == true,
              read: true,
              creator_blocked: false,
              my_vote: self.favourited == true ?  1 : 0,
              unread_comments: 0)
    }
    
    var thumbnailUrl: String? {
        if let mediaAttachment = self.mediaAttachments.first {//should include all
            return mediaAttachment.previewURL
        } else {
            return self.card?.url.absoluteString
        }
    }
}




extension Account {
    var federatedCommunity: FederatedCommunity {
        .init(id: self.id,
              name: self.acct,
              title: self.username,
              description: self.note,
              removed: self.locked,
              published: self.createdAt.asString,
              updated: nil,
              deleted: self.locked,
              nsfw: false,
              actor_id: self.username,
              local: false,
              icon: self.avatar,
              banner: nil,//maybe mastodon instance banner?
              followers_url: self.url,
              inbox_url: self.url,
              hidden: false,
              posting_restricted_to_mods: false,
              instance_id: "-1")
    }
    
    var federatedPerson: FederatedPerson {
        .init(id: self.id,
              name: self.username,
              display_name: self.displayName,
              avatar: self.avatar,//avatarStatic as well
              banned: self.locked,
              published: self.createdAt.asString,
              updated: nil,
              actor_id: self.url,
              bio: self.note,
              local: false,//match actorid to client baseurl
              banner: nil,
              deleted: false,
              inbox_url: nil,
              matrix_user_id: nil,
              admin: false,
              bot_account: false,
              ban_expires: nil,
              instance_id: "-12",
              instanceType: .mastodon)
    }
    
    var federatedCounts: FederatedPersonAggregates {
        .init(id: self.id,
                      person_id: self.id,
                      post_count: self.statusesCount,
                      post_score: 0,
                      comment_count: self.followingCount,
                      comment_score: 0,
                      following_count: self.followingCount,
                      followers_count: self.followersCount)
    }
    
    var asResource: FederatedPersonResource {
        .init(person: self.federatedPerson,
              counts: self.federatedCounts
        )
    }
}
