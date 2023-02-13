//
//  WikipediaResult.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/12/23.
//

import Foundation

// This  data is structed according to the Wikipedia API's JSON data format
struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int : Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }

}
