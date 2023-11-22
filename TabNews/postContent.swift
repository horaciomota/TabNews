//
//  ContentView.swift
//  TabNews
//
//  Created by Horacio Mota on 21/11/23.
//

import SwiftUI
import Foundation

struct postContent: View {
    var user: String
    var slug: String
    @State private var postContent: PostContent?
    @StateObject var viewModel = PostListViewModel()

    var body: some View {
        NavigationStack {
                    VStack {
                        if let content = postContent {
                            Text(content.title) // Exibindo o título
                                .font(.headline)
                            Text(content.body) // Exibindo o corpo do post
                                .font(.body)
                        }
                    }
                    .onAppear {
                        loadPostContent()
                    }
                }
            }

            func loadPostContent() {
                Task {
                    do {
                        postContent = try await viewModel.loadPostContent(user: user, slug: slug)
                    } catch {
                        print("Erro ao carregar o conteúdo: \(error)")
                    }
                }
            }
        }

// Para fins de visualização
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        postContent(user: "userTeste", slug: "slugTeste")
    }
}
