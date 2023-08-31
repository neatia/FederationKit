//
//  HTML2Markdown.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//  Based on: https://gist.github.com/fxm90/abd949e4258050f2f3cd80118024e5bd

import Foundation
import SwiftUI

enum HTML2Markdown {

    // MARK: - Public methods

    /// Converts the HTML-tags in the given string to their corresponding markdown tags.
    ///
    /// - SeeAlso: See type `HTMLToMarkdownConverter.Tags` for a list of supported HTML-tags.
    static func convert(_ htmlAsString: String) -> String {
        // Convert "basic" HTML-tags that don't use an attribute.
        let markdownAsString = Tags.allCases.reduce(htmlAsString) { result, textFormattingTag in
            result
                .replacingOccurrences(of: textFormattingTag.openingHtmlTag, with: textFormattingTag.markdownTag)
                .replacingOccurrences(of: textFormattingTag.closingHtmlTag, with: textFormattingTag.markdownTag)
        }

        // Hyperlinks use an attribute and therefore need to be handled differently.
        var htmlLinks = convertHtmlLinksToMarkdown(markdownAsString)
        htmlLinks = convertImagesToMarkdown(htmlLinks)
        htmlLinks = convertImagesEarlyCloseToMarkdown(htmlLinks)
        
        return htmlLinks.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // MARK: - Private methods

    /// Converts hyperlinks in HTML-format to their corresponding markdown representations.
    ///
    /// - Note: Currently we only support a basic HTML syntax without any attributed other than `href`.
    ///         E.g. `<a href="URL">TEXT</a>` will be converted to `[TEXT](URL)`
    ///
    /// - Parameter htmlAsString: The string containing hyperlinks in HTML-format.
    ///
    /// - Returns: A string with hyperlinks converted to their corresponding markdown representations.
    private static func convertHtmlLinksToMarkdown(_ htmlAsString: String) -> String {
        htmlAsString.replacingOccurrences(of: "<a href=\"(.+)\">(.+)</a>",
                                          with: "[$2]($1)",
                                          options: .regularExpression,
                                          range: nil)
    }
    
    private static func convertImagesToMarkdown(_ htmlAsString: String) -> String {
        htmlAsString.replacingOccurrences(of: "<img src=\"(.+)\">(.+)</img>",
                                          with: "![$2]($1)",
                                          options: .regularExpression,
                                          range: nil)
    }
    
    private static func convertImagesEarlyCloseToMarkdown(_ htmlAsString: String) -> String {
        htmlAsString.replacingOccurrences(of: "<img src=\"(.+)\"/>",
                                          with: "![image]($1)",
                                          options: .regularExpression,
                                          range: nil)
    }
}

extension HTML2Markdown {

    /// The supported tags inside a string we can format.
    enum Tags: String, CaseIterable {
        case strong
        case em
        case s
        case code
        case p

        // Hyperlinks need to be handled differently, as they not only have simple opening and closing tag, but also use the attribute `href`.
        // See private method `Text.convertHtmlLinksToMarkdown(:)` for further details.
        // case a

        // MARK: - Public properties

        var openingHtmlTag: String {
            "<\(rawValue)>"
        }

        var closingHtmlTag: String {
            "</\(rawValue)>"
        }

        var markdownTag: String {
            switch self {
            case .strong:
                return "**"

            case .em:
                return "*"

            case .s:
                return "~~"

            case .code:
                return "`"
                
            default:
                return ""
            }
        }
    }
}
