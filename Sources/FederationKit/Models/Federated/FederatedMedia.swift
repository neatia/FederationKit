//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public struct FederatedMediaPayload: Equatable, Codable {
    public let data: Data?
    public let path: String
    public var metadata: [FederatedMediaMetadata]
}

public enum FederatedMedia: Equatable, Codable {
    /// JPEG (Joint Photographic Experts Group) image
    case jpeg(FederatedMediaPayload)
    /// GIF (Graphics Interchange Format) image
    case gif(FederatedMediaPayload)
    /// PNG (Portable Network Graphics) image
    case png(FederatedMediaPayload)
    /// Other media file
    case other(FederatedMediaPayload, fileExtension: String, mimeType: String)
}

public extension FederatedMedia {
    var data: Data? {
        switch self {
        case .jpeg(let payload): return payload.data
        case .gif(let payload): return payload.data
        case .png(let payload): return payload.data
        case .other(let payload, _, _): return payload.data
        }
    }

    var fileName: String {
        switch self {
        case .jpeg: return "file.jpg"
        case .gif: return "file.gif"
        case .png: return "file.png"
        case .other(_, let fileExtension, _): return "file.\(fileExtension)"
        }
    }

    var mimeType: String {
        switch self {
        case .jpeg: return "image/jpg"
        case .gif: return "image/gif"
        case .png: return "image/png"
        case .other(_, _, let mimeType): return mimeType
        }
    }
    
    var filePath: String? {
        switch self {
        //TODO: why first? or why an array at all, a check for all should return an array
        case .jpeg(let payload): return payload.metadata.first?.file
        case .gif(let payload): return payload.metadata.first?.file
        case .png(let payload): return payload.metadata.first?.file
        case .other(let payload, _, _): return payload.metadata.first?.file
        }
    }
    
    var deleteToken: String? {
        switch self {
        //TODO: why first? or why an array at all, a check for all should return an array
        case .jpeg(let payload): return payload.metadata.first?.delete_token
        case .gif(let payload): return payload.metadata.first?.delete_token
        case .png(let payload): return payload.metadata.first?.delete_token
        case .other(let payload, _, _): return payload.metadata.first?.delete_token
        }
    }

    var base64EncondedString: String? {
        return data.map { "data:" + mimeType + ";base64," + $0.base64EncodedString() }
    }
}

public struct FederatedMediaMetadata: Equatable, Codable, Hashable {
    public let file: String
    public let delete_token: String
    public let url: String?
    public let delete_url: String?
    
    public init(file: String, delete_token: String) {
        self.file = file
        self.delete_token = delete_token
        self.url = nil
        self.delete_url = nil
    }
}
