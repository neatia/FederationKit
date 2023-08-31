//
//  File.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

public enum FederatedSortType: String, Codable, CustomStringConvertible, CaseIterable {
    case active = "Active"
    case hot = "Hot"
    case new = "New"
    case old = "Old"
    case topDay = "TopDay"
    case topWeek = "TopWeek"
    case topMonth = "TopMonth"
    case topYear = "TopYear"
    case topAll = "TopAll"
    case mostComments = "MostComments"
    case newComments = "NewComments"
    case topHour = "TopHour"
    case topSixHour = "TopSixHour"
    case topTwelveHour = "TopTwelveHour"
    case topThreeMonths = "TopThreeMonths"
    case topSixMonths = "TopSixMonths"
    case topNineMonths = "TopNineMonths"

    public var description: String {
        return rawValue
    }
}

public enum FederatedCommentSortType: String, Codable, CustomStringConvertible, CaseIterable {
    case hot = "Hot"
    case top = "Top"
    case new = "New"
    case old = "Old"

    public var description: String {
        return rawValue
    }
}
