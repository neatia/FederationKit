//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public enum FederatedSubscribedType: String, Codable, CustomStringConvertible, CaseIterable {
    case subscribed = "Subscribed"
    case notSubscribed = "NotSubscribed"
    case pending = "Pending"

    public var description: String {
        return rawValue
    }
}
