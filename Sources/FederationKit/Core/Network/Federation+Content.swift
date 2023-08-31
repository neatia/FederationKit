//
//  Federation+Content.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public extension Federation {
    func uploadImage(_ imageData: Data,
                     auth: String? = nil) async -> FederatedMedia? {

        let response = await lemmy?.uploadImage(imageData, auth: auth)
        let data: FederatedMedia = .png(.init(data: imageData, path: "", metadata: response?.files.compactMap({ $0.federated }) ?? []))
        
        return data
    }
    
    static func uploadImage(_ imageData: Data, auth: String? = nil) async -> FederatedMedia? {
        return await shared.uploadImage(imageData, auth: auth)
    }
    
    func deleteImage(_ media: FederatedMedia,
                     auth: String? = nil) async -> Bool {
        return await lemmy?.deleteImage(.init(file: media.filePath ?? "",
                                              delete_token: media.deleteToken ?? ""),
                                        auth: auth) != nil
    }
    static func deleteImage(_ media: FederatedMedia,
                            auth: String? = nil) async -> Bool {
        return await shared.deleteImage(media, auth: auth)
    }
}
