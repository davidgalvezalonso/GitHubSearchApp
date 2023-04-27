//
//  GitHubAPI.swift
//  GitHubSearchApp
//
//  Created by David on 27/4/23.
//

import Foundation
import Combine

enum GitHubAPI {
    static let baseURL = URL(string: "https://api.github.com")!
    
    static func searchRepositories(query: String) -> AnyPublisher<[GitHubRepository], RepositoryError> {
        guard let url = URL(string: "search/repositories", relativeTo: baseURL),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return Fail(error: RepositoryError.unknown).eraseToAnyPublisher()
        }
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "sort", value: "stars")
        ]
        guard let componentsURL = components.url else {
            return Fail(error: RepositoryError.unknown).eraseToAnyPublisher()
        }
        let request = URLRequest(url: componentsURL)
        let session = URLSession.shared
        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .mapError { error in
                return handleError(error)
            }
            .map { $0.items }
            .eraseToAnyPublisher()
    }
    
    static func handleError(_ error: Error) -> RepositoryError {
        switch error {
        case is URLError:
            return RepositoryError.networkError(error)
        case is DecodingError:
            return RepositoryError.decodingError(error)
        default:
            return RepositoryError.apiError("Unknown error occurred.")
        }
    }
}
