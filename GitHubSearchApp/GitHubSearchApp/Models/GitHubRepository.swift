//
//  GitHubRepository.swift
//  GitHubSearchApp
//
//  Created by David on 25/4/23.
//

import Foundation

struct GitHubRepository: GitHubRepositoryRepresentable {
    var name: String
    var description: String?
    var stars: Int

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case stars = "stargazers_count"
    }
    
    var id: String {
        return name
    }
}

protocol GitHubRepositoryRepresentable: Codable, Hashable, Identifiable {
    var name: String { get }
    var description: String? { get }
    var stars: Int { get }
    
    var anyHashableID: AnyHashable { get }
}

extension GitHubRepositoryRepresentable {
    var anyHashableID: AnyHashable { AnyHashable(id) }
}
