//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public struct FederatedSearchResult: Codable, Hashable {
    public let type_: FederatedSearchType
    public let comments: [FederatedCommentResource]
    public let posts: [FederatedPostResource]
    public let communities: [FederatedCommunityResource]
    public let users: [FederatedPersonResource]

    public init(
        type_: FederatedSearchType,
        comments: [FederatedCommentResource],
        posts: [FederatedPostResource],
        communities: [FederatedCommunityResource],
        users: [FederatedPersonResource]
    ) {
        self.type_ = type_
        self.comments = comments
        self.posts = posts
        self.communities = communities
        self.users = users
    }
}
