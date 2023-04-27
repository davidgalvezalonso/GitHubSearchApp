//
//  ContentView.swift
//  GitHubSearchApp
//
//  Created by David on 25/4/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = SearchViewModel(service: GitHubRepositoryService())

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $viewModel.query, onSearchButtonClicked: viewModel.searchRepositories)
                    .padding(.top)
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                        .foregroundColor(.red)
                } else if !viewModel.repositories.isEmpty {
                    let repositories: [GitHubRepository] = viewModel.repositories.compactMap { $0 as? GitHubRepository }
                    List(repositories, id: \.anyHashableID) { repository in
                        NavigationLink(destination: DetailView(repository: repository)) {
                            VStack(alignment: .leading) {
                                Text(repository.name)
                                    .font(.headline)
                                Text(repository.description ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("\(repository.stars) stars")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                } else {
                    Text("No results found")
                        .foregroundColor(.gray)
                        .padding()
                }

                Spacer()
            }
            .navigationTitle("GitHub Search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
