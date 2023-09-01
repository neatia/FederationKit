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
    
    var asInt: Int {
        Int(self) ?? self.hashValue
    }
    
    var plainText: String {
        let htmlStringData = self.data(using: String.Encoding.utf8)!
        
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try! NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        
        return attributedString.string
    }
}

extension Int {
    var asString: String {
        "\(self)"
    }
}
