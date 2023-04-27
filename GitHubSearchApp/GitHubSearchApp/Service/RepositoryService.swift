//
//  RepositoryService.swift
//  GitHubSearchApp
//
//  Created by David on 27/4/23.
//

import Foundation
import Combine

protocol RepositoryService {
    func searchRepositories(query: String) -> AnyPublisher<[GitHubRepository], RepositoryError>
}

class GitHubRepositoryService: RepositoryService {
    
    func searchRepositories(query: String) -> AnyPublisher<[GitHubRepository], RepositoryError> {
        return GitHubAPI.searchRepositories(query: query)
    }
}
