//
//  DetailView.swift
//  GitHubSearchApp
//
//  Created by David on 25/4/23.
//

import SwiftUI

struct DetailView: View {
    let repository: any GitHubRepositoryRepresentable

    var body: some View {
        VStack {
            Text(repository.name)
                .font(.largeTitle)
                .bold()
                .padding()

            Text(repository.description ?? "")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()

            Text("\(repository.stars) stars")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()

            Button("Open in Browser") {
                if let url = URL(string: "https://github.com/\(repository.name)") {
                    UIApplication.shared.open(url)
                }
            }
            .padding()
        }
    }
}
