//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

extension URL {
    var hostString: String? {
        let host: String?
        
        /*if #available(macOS 13.0, iOS 16.0, *),
           let sanitized = self.host(percentEncoded: false) {
            host = sanitized
        } else */if let sanitized = self.host {
            host = sanitized
        } else {
            host = nil
        }
        
        return host
    }
}
