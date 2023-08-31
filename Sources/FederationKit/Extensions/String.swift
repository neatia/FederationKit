//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

extension String {
    var host: String {
        guard let url = URL(string: self) else {
            return self
        }
        
        return url.hostString ?? self
    }
}
