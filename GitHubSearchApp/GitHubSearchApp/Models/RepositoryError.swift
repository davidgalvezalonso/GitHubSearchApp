//
//  RepositoryError.swift
//  GitHubSearchApp
//
//  Created by David on 27/4/23.
//

import Foundation

enum RepositoryError: Error {
    case networkError(Error)
    case decodingError(Error)
    case apiError(String)
    case unknown
}
