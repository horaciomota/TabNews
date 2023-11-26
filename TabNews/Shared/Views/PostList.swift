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
            // Logo
            HStack {
                Spacer()
                Image("TabNewsLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                Text("TabNews")
                    .font(.system(size: 22, weight: .bold))
                Spacer()

            }
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(ListofNews, id: \.id) { new in
                        NavigationLink(destination: postContent(user: new.owner_username, slug: new.slug)) {
                            HStack (alignment: .center) {
                                // Numero de comentarios
                                VStack () {
                                    Rectangle()
                                        .frame(width: 1)
                                        .foregroundColor(.secondary)

                                    Image(systemName: "chevron.up")
                                        .padding(.vertical, 2)
                                        .foregroundColor(.secondary)

                                    Text("\(new.children_deep_count)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)

                                    Image(systemName: "chevron.down")
                                        .padding(.vertical, 2)
                                        .foregroundStyle(Color.secondary)

                                    Rectangle()
                                        .frame(width: 1)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.trailing)


                                // Titulo do post
                                VStack (alignment: .leading) {
                                    Spacer()
                                    Text(new.title)
                                        .multilineTextAlignment(.leading)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .padding(.top, 16)


                                    // Algumas estatisticas do post
                                    HStack {
                                        Text("\(new.owner_username)")
                                            .foregroundColor(.secondary)
                                            .font(.footnote)

                                        HStack {
                                            Circle()
                                                .foregroundStyle(Color.black)
                                                .frame(width: 5, height: 5)


                                            Text("\(new.tabcoins) tabcoins")
                                                .foregroundColor(.secondary)
                                                .font(.footnote)
                                        }

                                        Spacer()

                                        Text(viewModel.formatISODate(new.created_at))
                                            .foregroundColor(.secondary)
                                            .font(.footnote)

                                    }
                                    .padding(.bottom, 16)

                                }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
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
