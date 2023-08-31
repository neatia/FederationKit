//
//  Federation+Site.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public extension Federation {
    func site(auth: String? = nil) async -> FederatedSiteResult? {
        let result = await lemmy?.site(auth: auth)?.federated
        
        if let currentServer {
            update(site: result, for: currentServer)
        }
        
        return result
    }
    static func site(auth: String? = nil) async -> FederatedSiteResult? {
        return await shared.site(auth: auth)
    }
    func metadata(url: String) async -> FederatedSiteMetadata? {
        return await lemmy?.metadata(url: url)?.metadata.federated
    }
    static func metadata(url: String) async -> FederatedSiteMetadata? {
        return await shared.metadata(url: url)
    }
    
    func instances(auth: String? = nil) async -> FederatedInstanceList? {
        return await lemmy?.instances(auth: auth)?.federated
    }
    static func instances(auth: String? = nil) async -> FederatedInstanceList? {
        return await shared.instances(auth: auth)
    }
}
