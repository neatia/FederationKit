//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public enum FederatedLocationType: CustomStringConvertible, Equatable, Codable, Hashable {
    case base
    case source
    case peer(String)
    
   public var isPeer: Bool {
        switch self {
        case .peer:
            return true
        default:
            return false
        }
    }
    
    public var description: String {
        switch self {
        case .base: return "base"
        case .source: return "source"
        case .peer: return "peer"
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .peer(let host):
            hasher.combine(self.description+host)
        default:
            hasher.combine(self.description)
        }
    }
    
    public var host: String? {
        switch self {
        case .peer(let host):
            return host
        case .source:
            return nil
        case .base:
            return FederationKit.host
        }
    }
}
