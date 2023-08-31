//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public enum FederatedRegistrationType: String, Codable, CustomStringConvertible, CaseIterable {
    case closed = "Closed"
    case requireApplication = "RequireApplication"
    case open = "Open"

    public var description: String {
        return rawValue
    }
}
