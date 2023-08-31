//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation


extension FederatedInstance {
    public var federatedId: String { domain }
}

public enum FederatedInstanceType: String, Codable {
    case lemmy
    case mastodon
    case unknown
    case automatic
    
    public static var validInstances: [FederatedInstanceType] {
        [.lemmy, .mastodon]
    }
}

public struct FederatedInstance: Codable, Identifiable, Hashable {
    public var instanceType: FederatedInstanceType
    public let id: String
    public let domain: String
    public let published: String
    public let updated: String?
    public let software: String?
    public let version: String?

    public init(
        _ instanceType: FederatedInstanceType,
        id: String,
        domain: String,
        published: String,
        updated: String? = nil,
        software: String? = nil,
        version: String? = nil
    ) {
        self.instanceType = instanceType
        self.id = id
        self.domain = domain
        self.published = published
        self.updated = updated
        self.software = software
        self.version = version
    }
    
    public static var mock: FederatedInstance {
        .init(.unknown, id: "-1", domain: "https://loom.nyc", published: "\(Date())")
    }
}

public struct FederatedInstanceList: Codable, Hashable {
    public let linked: [FederatedInstance]
    public let allowed: [FederatedInstance]
    public let blocked: [FederatedInstance]

    public init(
        linked: [FederatedInstance],
        allowed: [FederatedInstance],
        blocked: [FederatedInstance]
    ) {
        self.linked = linked
        self.allowed = allowed
        self.blocked = blocked
    }
}
