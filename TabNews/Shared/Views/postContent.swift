//
//  ContentView.swift
//  TabNews
//
//  Created by Horacio Mota on 21/11/23.
//

import SwiftUI
import Foundation
import MarkdownUI

struct postContent: View {
    var user: String
    var slug: String
    @State private var thumbnailData: Data?
    @State private var postContent: PostContent?
    @StateObject var viewModel = PostListViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let thumbnailData = thumbnailData, let uiImage = UIImage(data: thumbnailData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        ProgressView()
                    }

                    if let content = postContent, !content.body.isEmpty {
                        Markdown(content.body)
                    } else {
                        ProgressView()
                    }
                    Spacer()
                }
                .onAppear {
                    loadPostContent()
                    loadPostThumbnail()
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
        }
    }
    // Task para carregar o conteudo escrito
    func loadPostContent() {
        Task {
            do {
                postContent = try await viewModel.loadPostContent(user: user, slug: slug)
            } catch {
                print("Erro ao carregar o conteúdo: \(error)")
            }
        }
    }

    // Task para carregar thumbnail
    func loadPostThumbnail() {
        Task {
            do {
                thumbnailData = try await viewModel.loadPostThumbnail(user: user, slug: slug)
            } catch {
                print("Erro ao carregar a thumbnail: \(error)")
            }
        }
    }
}

// Para fins de visualização
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        postContent(user: "maxsonalmeida", slug: "o-dev-junior-nao-pode-subestimar-o-poder-do-linkedin")
    }
}
