//
//  RepositoryServiceMock.swift
//  GitHubSearchAppTests
//
//  Created by David on 27/4/23.
//

import Foundation
import Combine
@testable import GitHubSearchApp

class RepositoryServiceMock: RepositoryService {
    var repositories: [GitHubRepository] = []
    var error: RepositoryError?

    func searchRepositories(query: String) -> AnyPublisher<[GitHubRepository], RepositoryError> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just(repositories).setFailureType(to: RepositoryError.self).eraseToAnyPublisher()
    }
}
