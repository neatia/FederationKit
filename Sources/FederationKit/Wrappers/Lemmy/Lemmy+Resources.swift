//
//  Lemmy+Resources.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit

//MARK: Comments

extension CommentView {
    public var federated: FederatedCommentResource {
        .init(comment: self.comment.federated,
              creator: self.creator.federated,
              post: self.post.federated,
              community: self.community.federated,
              counts: self.counts.federated,
              creator_banned_from_community: self.creator_banned_from_community,
              subscribed: self.subscribed.federated,
              saved: self.saved,
              creator_blocked: self.creator_blocked,
              my_vote: self.my_vote)
    }
}

extension Comment {
    public var federated: FederatedComment {
        .init(id: self.id.asString,
              creator_id: self.creator_id.asString,
              post_id: self.post_id.asString,
              content: self.content,
              removed: self.removed,
              published: self.published,
              updated: self.updated,
              deleted: self.deleted,
              ap_id: self.ap_id,
              local: self.local,
              path: self.path,
              distinguished: self.distinguished,
              language_id: self.language_id,
              instanceType: .lemmy)
    }
}

extension CommentAggregates {
    public var federated: FederatedCommentAggregates {
        .init(id: self.id.asString,
              comment_id: self.comment_id.asString,
              score: self.score,
              upvotes: self.upvotes,
              downvotes: self.downvotes,
              published: self.published,
              child_count: self.child_count,
              hot_rank: self.hot_rank)
    }
}

//MARK: Person

extension PersonView {
    public var federated: FederatedPersonResource {
        .init(person: self.person.federated,
              counts: self.counts.federated)
    }
}

extension Person {
    public var federated: FederatedPerson {
        .init(id: self.id.asString,
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
              inbox_url: self.inbox_url,
              matrix_user_id: self.matrix_user_id,
              admin: self.admin,
              bot_account: self.bot_account,
              ban_expires: self.ban_expires,
              instance_id: self.instance_id.asString,
              instanceType: .lemmy)
    }
}

extension PersonAggregates {
    public var federated: FederatedPersonAggregates {
        .init(id: self.id.asString,
              person_id: self.person_id.asString,
              post_count: self.post_count,
              post_score: self.post_score,
              comment_count: self.comment_count,
              comment_score: self.comment_score)
    }
}

//MARK: Post
extension PostView {
    public var federated: FederatedPostResource {
        .init(post: self.post.federated,
              creator: self.creator.federated,
              community: self.community.federated,
              creator_banned_from_community: self.creator_banned_from_community,
              counts: self.counts.federated,
              subscribed: self.subscribed.federated,
              saved: self.saved,
              read: self.read,
              creator_blocked: self.creator_blocked,
              my_vote: self.my_vote,
              unread_comments: self.unread_comments)
    }
}

extension Post {
    public var federated: FederatedPost {
        .init(id: self.id.asString,
              name: self.name,
              url: self.url,
              body: self.body,
              creator_id: self.creator_id.asString,
              community_id: self.community_id.asString,
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
              featured_local: self.featured_local,
              instanceType: .lemmy)
    }
}

extension PostAggregates {
    public var federated: FederatedPostAggregates {
        .init(id: self.id.asString,
              post_id: self.post_id.asString,
              comments: self.comments,
              score: self.score,
              upvotes: self.upvotes,
              downvotes: self.downvotes,
              published: self.published,
              newest_comment_time_necro: self.newest_comment_time,
              newest_comment_time: self.newest_comment_time,
              featured_community: self.featured_community,
              featured_local: self.featured_local,
              hot_rank: self.hot_rank,
              hot_rank_active: self.hot_rank_active)
    }
}


//MARK: Community
extension CommunityView {
    public var federated: FederatedCommunityResource {
        .init(community: self.community.federated,
              subscribed: self.subscribed.federated,
              blocked: self.blocked,
              counts: self.counts.federated)
    }
}

extension Community {
    public var federated: FederatedCommunity {
        .init(id: self.id.asString,
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
              followers_url: self.followers_url,
              inbox_url: self.inbox_url,
              hidden: self.hidden,
              posting_restricted_to_mods: self.posting_restricted_to_mods,
              instance_id: self.instance_id.asString)
    }
}

extension CommunityAggregates {
    public var federated: FederatedCommunityAggregates {
        .init(id: self.id.asString,
              community_id: self.community_id,
              subscribers: self.subscribers,
              posts: self.posts,
              comments: self.comments,
              published: self.published,
              users_active_day: self.users_active_day,
              users_active_week: self.users_active_week,
              users_active_month: self.users_active_month,
              users_active_half_year: self.users_active_half_year,
              hot_rank: self.hot_rank)
    }
}
