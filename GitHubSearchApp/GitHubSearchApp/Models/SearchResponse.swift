//
//  SearchResponse.swift
//  GitHubSearchApp
//
//  Created by David on 25/4/23.
//

import Foundation

struct SearchResponse: Codable {
    var items: [GitHubRepository]
}
