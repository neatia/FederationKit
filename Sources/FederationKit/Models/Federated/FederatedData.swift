//
//  FederatedData.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit

public struct FederatedData: Identifiable, Hashable, Equatable, Codable {
    public static func == (lhs: FederatedData, rhs: FederatedData) -> Bool {
        lhs.id == rhs.id
    }
    
    public var id: UUID = .init()
    public var host: String
    
    public var instance: FederatedInstance?
    public var community: FederatedCommunityResource?
    public var post: FederatedPostResource?
    public var comment: FederatedCommentResource?
    public var person: FederatedPersonResource?
    
    public init(host: String,
         community: FederatedCommunityResource? = nil,
         instance: FederatedInstance? = nil) {
        self.host = host
        self.community = community
        self.instance = instance
    }
    
    
    public var idPlain: String {
        "\(host)\(community?.id ?? "")\(instance?.federatedId ?? "")"
    }
    
    public var displayName: String {
        community?.displayName ?? ""
    }
    
    public static func community(_ fc: FederatedCommunityResource?) -> FederatedData {
        return .init(host: fc?.community.actor_id.host ?? FederationKit.host, community: fc)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
