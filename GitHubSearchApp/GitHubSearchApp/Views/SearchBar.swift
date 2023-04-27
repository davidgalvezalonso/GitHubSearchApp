//
//  SearchBar.swift
//  GitHubSearchApp
//
//  Created by David on 25/4/23.
//

import SwiftUI
import Combine

struct SearchBar: View {
    @Binding var searchText: String
    var onSearchButtonClicked: (String) -> Void

    var body: some View {
        HStack {
            TextField("Search", text: $searchText, onCommit: {
                onSearchButtonClicked(searchText)
            })
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0))
                .background(Color(.systemGray6))
                .cornerRadius(10)

            Button(action: {
                onSearchButtonClicked(searchText)
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.headline)
            }
            .padding(.trailing, 16)
        }
        .padding(.horizontal, 16)
    }
}
