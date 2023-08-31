//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public enum FederatedSearchType: String, Codable, CustomStringConvertible, CaseIterable {
    case all = "All"
    case comments = "Comments"
    case posts = "Posts"
    case communities = "Communities"
    case users = "Users"
    case url = "Url"

    public var description: String {
        return rawValue
    }
}
