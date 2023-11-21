//
//  PostList.swift
//  TabNews
//
//  Created by Horacio Mota on 21/11/23.
//

import SwiftUI

struct PostList: View {
    @State var ListofNews: [newsDataModel] = []
    @StateObject var viewModel = PostListViewModel()


    var body: some View {
   
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 32) {
                    ForEach(ListofNews, id: \.id) { new in
                        NavigationLink(destination: ContentView()) {
                            HStack (alignment: .center) {
                                Circle()
                                    .foregroundStyle(Color.blue)
                                    .frame(width: 10, height: 10)
                                    .padding(.trailing, 10)

                                // Titulo do post
                                VStack (alignment: .leading) {
                                    Text(new.title)
                                        .multilineTextAlignment(.leading)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    // Algumas estatisticas do post
                                    HStack {
                                        Text("\(new.owner_username)")
                                            .foregroundColor(.secondary)
                                            .font(.footnote)
                                        Text("\(new.tabcoins) tabcoins")
                                            .foregroundColor(.secondary)
                                            .font(.footnote)
                                    }
                                    Divider()
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("News")
            .task {
                do {
                    ListofNews = try await viewModel.fetchNewPosts()
                } catch {
                    print("Something went wrong: \(error)")
                }
            }
        }

    }
}

#Preview {
    PostList()
}
