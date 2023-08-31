//
//  Federation+Search.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit

public extension Federation {
    @discardableResult
    func search(_ q: String,
                type_: FederatedSearchType,
                communityId: Int? = nil,
                communityName: String? = nil,
                creatorId: Int? = nil,
                sort: FederatedSortType = .hot,
                listingType: FederatedListingType = .all,
                page: Int?,
                limit: Int?,
                auth: String?) async -> FederatedSearchResult? {
        
        return await lemmy?.search(q,
                                   type_: type_.lemmy,
                                   communityId: communityId,
                                   communityName: communityName,
                                   creatorId: creatorId,
                                   sort: sort.lemmy,
                                   listingType: listingType.lemmy,
                                   page: page,
                                   limit: limit,
                                   auth: auth)?.federated
    }
    
    @discardableResult
    static func search(_ q: String,
                       type_: FederatedSearchType,
                       communityId: Int? = nil,
                       communityName: String? = nil,
                       creatorId: Int? = nil,
                       sort: FederatedSortType = .hot,
                       listingType: FederatedListingType = .all,
                       page: Int?,
                       limit: Int?,
                       auth: String? = nil) async -> FederatedSearchResult? {
        return await shared.search(q,
                                   type_: type_,
                                   communityId: communityId,
                                   communityName: communityName,
                                   creatorId: creatorId,
                                   sort: sort,
                                   listingType: listingType,
                                   page: page,
                                   limit: limit,
                                   auth: auth)
    }
}
