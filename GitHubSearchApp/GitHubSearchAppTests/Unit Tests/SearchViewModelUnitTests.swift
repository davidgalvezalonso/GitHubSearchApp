//
//  SearchViewModelUnitTests.swift
//  GitHubSearchAppTests
//
//  Created by David on 27/4/23.
//

import XCTest
import Combine
@testable import GitHubSearchApp

class SearchViewModelUnitTests: XCTestCase {
    
    var viewModel: SearchViewModel!
    var service: RepositoryServiceMock!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        service = RepositoryServiceMock()
        viewModel = SearchViewModel(service: service)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        service = nil
        super.tearDown()
    }
    
    func testSearchRepositoriesSuccess() {
        // Given
        let repositories = [GitHubRepository(name: "Repo1", stars: 10), GitHubRepository(name: "Repo2", stars: 9)]
        service.repositories = repositories
        
        // When
        viewModel.searchRepositories(for: "swift")
        let expectation = XCTestExpectation(description: "Search repositories")
        viewModel.$repositories
            .dropFirst()
            .sink { repositories in
            // Then
                XCTAssert(repositories.first?.name != repositories.last?.name)
            //XCTAssertEqual(repositories, repositories)
            expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testSearchRepositoriesFailure() {
        // Given
        let error = RepositoryError.unknown
        service.error = error
        // When
        let expectation = XCTestExpectation(description: "Search repositories")
        viewModel.searchRepositories(for: "swift")
        viewModel.$error
            .dropFirst()
            .sink { receivedError in
            // Then
            XCTAssertEqual(receivedError, error)
            expectation.fulfill()
        }.store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
    
    func testEmptyQueryLoading() {
        // Given
        let query = ""
        
        // When
        viewModel.searchRepositories(for: query)
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
    }
}

extension RepositoryError: Equatable {
    public static func == (lhs: GitHubSearchApp.RepositoryError, rhs: GitHubSearchApp.RepositoryError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}

