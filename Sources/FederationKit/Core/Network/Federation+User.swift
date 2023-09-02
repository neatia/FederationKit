//
//  Federation+User.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit

public extension Federation {
    func getUserData(for resource: UserResource? = nil, auth token: String? = nil) async -> UserResource? {
        guard let user = resource ?? currentUser?.resource else { return nil }
        
        let host = user.host
        FederationLog("Getting user data for host: \(host)", level: .debug)
        let lemmy: Lemmy = .init(apiUrl: host)
        
        let auth: String? = token ?? self.auths[host]
        FederationLog("found auth: \(auth != nil)", level: .debug)
        let result = await lemmy.site(auth: auth)?.federated
        FederationLog("user retrieved: \(result?.my_user != nil)", level: .debug)
        
        return result?.my_user
    }
    static func getUserData(for resource: UserResource? = nil) async -> UserResource? {
        return await shared.getUserData(for: resource)
    }
    
    func mentions(sort: FederatedCommentSortType? = nil,
                  page: Int? = nil,
                  limit: Int? = nil,
                  unreadOnly: Bool? = nil,
                  auth: String? = nil) async -> FederatedPersonMentionList? {
        
        return await lemmy?.mentions(sort: sort?.lemmy,
                                     page: page,
                                     limit: limit,
                                     unreadOnly: unreadOnly,
                                     auth: auth)?.federated
    }
    
    static func mentions(sort: FederatedCommentSortType? = nil,
                         page: Int? = nil,
                         limit: Int? = nil,
                         unreadOnly: Bool? = nil,
                         auth: String? = nil) async -> FederatedPersonMentionList? {
        
        return await shared.mentions(sort: sort,
                                     page: page,
                                     limit: limit,
                                     unreadOnly: unreadOnly,
                                     auth: auth)
    }
    
    func replies(sort: FederatedCommentSortType? = nil,
                 page: Int? = nil,
                 limit: Int? = nil,
                 unreadOnly: Bool? = nil,
                 auth: String? = nil) async -> FederatedPersonRepliesList? {
        return await lemmy?.replies(sort: sort?.lemmy,
                                    page: page,
                                    limit: limit,
                                    unreadOnly: unreadOnly,
                                    auth: auth)?.federated
    }
    static func replies(sort: FederatedCommentSortType? = nil,
                        page: Int? = nil,
                        limit: Int? = nil,
                        unreadOnly: Bool? = nil,
                        auth: String? = nil) async -> FederatedPersonRepliesList? {
        return await shared.replies(sort: sort,
                                    page: page,
                                    limit: limit,
                                    unreadOnly: unreadOnly,
                                    auth: auth)
    }
}

//MARK: user settings

public extension Federation {
    
    func saveUserSettings(show_nsfw: Bool? = nil,
                          show_scores: Bool? = nil,
                          theme: String? = nil,
                          default_sort_type: FederatedSortType? = nil,
                          default_listing_type: FederatedListingType? = nil,
                          interface_language: String? = nil,
                          avatar: String? = nil,
                          banner: String? = nil,
                          display_name: String? = nil,
                          email: String? = nil,
                          bio: String? = nil,
                          matrix_user_id: String? = nil,
                          show_avatars: Bool? = nil,
                          send_notifications_to_email: Bool? = nil,
                          bot_account: Bool? = nil,
                          show_bot_accounts: Bool? = nil,
                          show_read_posts: Bool? = nil,
                          show_new_post_notifs: Bool? = nil,
                          discussion_languages: [Int]? = nil,
                          generate_totp_2fa: Bool? = nil,
                          auth: String? = nil,
                          open_links_in_new_tab: Bool? = nil
    ) async -> String? {
        return await lemmy?.saveUserSettings(show_nsfw: show_nsfw,
                                             show_scores: show_scores,
                                             theme: theme,
                                             default_sort_type: default_sort_type?.lemmy,
                                             default_listing_type: default_listing_type?.lemmy,
                                             interface_language: interface_language, avatar: avatar,
                                             banner: banner,
                                             display_name: display_name,
                                             email: email,
                                             bio: bio,
                                             matrix_user_id: matrix_user_id,
                                             show_avatars: show_avatars,
                                             send_notifications_to_email: send_notifications_to_email,
                                             bot_account: bot_account,
                                             show_bot_accounts: show_bot_accounts,
                                             show_read_posts: show_read_posts,
                                             show_new_post_notifs: show_new_post_notifs,
                                             discussion_languages: discussion_languages,
                                             generate_totp_2fa: generate_totp_2fa,
                                             auth: auth,
                                             open_links_in_new_tab: open_links_in_new_tab)?.jwt
    }
    static func saveUserSettings(show_nsfw: Bool? = nil,
                                 show_scores: Bool? = nil,
                                 theme: String? = nil,
                                 default_sort_type: FederatedSortType? = nil,
                                 default_listing_type: FederatedListingType? = nil,
                                 interface_language: String? = nil,
                                 avatar: String? = nil,
                                 banner: String? = nil,
                                 display_name: String? = nil,
                                 email: String? = nil,
                                 bio: String? = nil,
                                 matrix_user_id: String? = nil,
                                 show_avatars: Bool? = nil,
                                 send_notifications_to_email: Bool? = nil,
                                 bot_account: Bool? = nil,
                                 show_bot_accounts: Bool? = nil,
                                 show_read_posts: Bool? = nil,
                                 show_new_post_notifs: Bool? = nil,
                                 discussion_languages: [Int]? = nil,
                                 generate_totp_2fa: Bool? = nil,
                                 auth: String? = nil,
                                 open_links_in_new_tab: Bool? = nil
    ) async -> String? {
        return await shared.saveUserSettings(show_nsfw: show_nsfw,
                                             show_scores: show_scores,
                                             theme: theme,
                                             default_sort_type: default_sort_type,
                                             default_listing_type: default_listing_type,
                                             interface_language: interface_language,
                                             avatar: avatar,
                                             banner: banner,
                                             display_name: display_name,
                                             email: email,
                                             bio: bio,
                                             matrix_user_id: matrix_user_id,
                                             show_avatars: show_avatars,
                                             send_notifications_to_email: send_notifications_to_email,
                                             bot_account: bot_account,
                                             show_bot_accounts: show_bot_accounts,
                                             show_read_posts: show_read_posts,
                                             show_new_post_notifs: show_new_post_notifs,
                                             discussion_languages: discussion_languages,
                                             generate_totp_2fa: generate_totp_2fa,
                                             auth: auth,
                                             open_links_in_new_tab: open_links_in_new_tab)
    }
}
