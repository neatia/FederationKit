//
//  FederationMetadata.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public class FederationMetadata: Equatable {
    public static func == (lhs: FederationMetadata,
                           rhs: FederationMetadata) -> Bool {
        lhs.site.id == rhs.site.id
    }
    
    public var site: FederatedSite
    public init(siteView: FederatedSiteResource) {
        self.site = siteView.site
    }
}
