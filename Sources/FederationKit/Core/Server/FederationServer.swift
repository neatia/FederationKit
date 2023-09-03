//
//  FederationServer.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit
import MastodonKit
import FeedKit

//Clients
public protocol AnyFederatedServer {
    var lemmy: Lemmy? { get set }
    var isOnline: Bool { get }
    mutating func connect()
    mutating func updateAuth(auth token: String, user resource: UserResource)
    mutating func removeAuth()
}

public struct FederationServer: Equatable, Codable, Identifiable, Hashable, AnyFederatedServer {
    public static func == (lhs: FederationServer, rhs: FederationServer) -> Bool {
        lhs.id == rhs.id
    }
    
    public var type: FederatedInstanceType
    public var baseUrl: String
    public var host: String
    public var currentUser: UserResource? = nil
    public init(_ type: FederatedInstanceType, host baseUrl: String) {
        self.type = type
        
        let sanitized = FederationKit.sanitize(baseUrl)
        
        /*
         We do not want to set the baseUrl from the
         sanitized result yet, since RSS feeds can
         have path components
         */
        self.baseUrl = baseUrl
        
        self.host = sanitized.host ?? baseUrl
        
        self.connect()
    }
    
    //Automatic instancetype detection
    public init(host baseUrl: String) {
        self.type = .automatic
        let sanitized = FederationKit.sanitize(baseUrl)
        
        self.baseUrl = baseUrl
        
        self.host = sanitized.host ?? baseUrl
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
        case .rss:
            return rss != nil
        case .lemmy:
            return lemmy != nil
        case .mastodon:
            return mastodon != nil
        case .automatic:
            return lemmy != nil || mastodon != nil || rss != nil
        default:
            return false
        }
    }
    
    mutating public func connect() {
        let sanitized = FederationKit.sanitize(host)
        let sanitizedBaseUrl = sanitized.baseUrl ?? baseUrl
        switch type {
        case .lemmy:
            lemmy = .init(apiUrl: sanitizedBaseUrl, base: false)
        case .mastodon:
            mastodon = .init(baseURL: sanitizedBaseUrl)
        case .rss:
            guard let url = URL(string: baseUrl) else { return }
            rss = .init(URL: url)
        case .automatic:
            lemmy = .init(apiUrl: sanitizedBaseUrl, base: false)
            mastodon = .init(baseURL: sanitizedBaseUrl)
            guard let url = URL(string: baseUrl) else { return }
            rss = .init(URL: url)
        default:
            break
        }
    }
    
    mutating public func setInstanceType(_ type: FederatedInstanceType) {
        self.type = type
    }
    
    mutating public func updateAuth(auth token: String, user resource: UserResource) {
        switch type {
        case .lemmy:
            lemmy?.auth = token
            currentUser = resource
        case .automatic:
            lemmy?.auth = token
            currentUser = resource
        default:
            break
        }
    }
    
    mutating public func removeAuth() {
        switch type {
        case .lemmy:
            lemmy?.auth = nil
            currentUser = nil
        default:
            break
        }
    }
    
    //Protocol values
    public var rss: FeedParser? = nil
    public var lemmy: Lemmy? = nil
    public var mastodon: MastodonKit.Client? = nil
}


