//
//  FederationServer.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit
import MastodonKit

//Clients
public protocol AnyFederatedServer {
    var lemmy: Lemmy? { get set }
    var isOnline: Bool { get }
    mutating func connect()
    func updateAuth(token: String)
    func removeAuth()
}

public struct FederationServer: Equatable, Codable, Identifiable, Hashable, AnyFederatedServer {
    public static func == (lhs: FederationServer, rhs: FederationServer) -> Bool {
        lhs.id == rhs.id
    }
    
    public var type: FederatedInstanceType
    public var baseUrl: String
    public var host: String
    
    public init(_ type: FederatedInstanceType, host: String) {
        self.type = type
        let sanitized = FederationKit.sanitize(host)
        let serverBaseUrl = sanitized.baseUrl ?? host
        self.baseUrl = serverBaseUrl
        self.host = sanitized.host ?? host
        
        self.connect()
    }
    
    //Automatic instancetype detection
    public init(host: String) {
        self.type = .automatic
        let sanitized = FederationKit.sanitize(host)
        let serverBaseUrl = sanitized.baseUrl ?? host
        self.baseUrl = serverBaseUrl
        self.host = sanitized.host ?? host
    }
    
    //auth can change (jwt token usually)
    public var id: String {
        baseUrl + "\(type)"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: CodingKey {
        case type, baseUrl, host
    }
    
    public var isOnline: Bool {
        switch type {
        case .lemmy:
            return lemmy != nil
        case .mastodon:
            return mastodon != nil
        case .automatic:
            return lemmy != nil || mastodon != nil
        default:
            return false
        }
    }
    
    mutating public func connect() {
        switch type {
        case .lemmy:
            lemmy = .init(apiUrl: baseUrl, base: false)
        case .mastodon:
            mastodon = .init(baseURL: baseUrl)
        case .automatic:
            lemmy = .init(apiUrl: baseUrl, base: false)
            mastodon = .init(baseURL: baseUrl)
        default:
            break
        }
    }
    
    mutating public func setInstanceType(_ type: FederatedInstanceType) {
        self.type = type
    }
    
    public func updateAuth(token: String) {
        switch type {
        case .lemmy:
            lemmy?.auth = token
        default:
            break
        }
    }
    
    public func removeAuth() {
        switch type {
        case .lemmy:
            lemmy?.auth = nil
        default:
            break
        }
    }
    
    //Protocol values
    public var lemmy: Lemmy? = nil
    public var mastodon: MastodonKit.Client? = nil
}


