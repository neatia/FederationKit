//
//  FederationUser.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public struct FederationUser: Codable {
    public var resource: UserResource
    public var host: String
    
    public var id: String {
        resource.user.person.actor_id
    }
    
    public var name: String {
        resource.user.person.name
    }
    
    public var username: String {
        resource.user.person.username
    }
}
