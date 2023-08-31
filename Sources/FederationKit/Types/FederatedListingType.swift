//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
public enum FederatedListingType: String, Codable, CustomStringConvertible, CaseIterable {
    case all = "All"
    case local = "Local"
    case subscribed = "Subscribed"

    public var description: String {
        return rawValue
    }
}
