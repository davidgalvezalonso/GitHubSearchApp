//
//  RepositoryViewModel.swift
//  GitHubSearchApp
//
//  Created by David on 25/4/23.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    private var disposables = Set<AnyCancellable>()
    private let searchURL = "https://api.github.com/search/repositories"

    @Published var repositories = [any GitHubRepositoryRepresentable]()
    @Published var isLoading = false
    @Published var error: RepositoryError?
    @Published var query: String = ""

    private var service: RepositoryService
    private var cancellables: Set<AnyCancellable> = []

    init(service: RepositoryService) {
        self.service = service
    }
    
    func searchRepositories(for query: String) {
        guard !query.isEmpty else {
            // Handle empty query
            return
        }
        resetSearch()
        searchRepositoriesWithQuery(query)
    }
}

extension SearchViewModel {
    
    func resetSearch() {
        isLoading = true
        error = nil
    }
    
    func searchRepositoriesWithQuery(_ query: String) {
        service.searchRepositories(query: query)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.error = error
                }
            } receiveValue: { repositories in
                self.repositories = repositories
            }
            .store(in: &cancellables)
    }
}
