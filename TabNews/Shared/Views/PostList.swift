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

    func formatISODate(_ isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = isoFormatter.date(from: isoDate) else {
            return "Data inválida"
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }

    var body: some View {
        NavigationStack {
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

                                    Text("\(new.children_deep_count)")
                                        .foregroundColor(.blue)
                                        .font(.subheadline)

                                    Image(systemName: "chevron.down")
                                        .padding(.vertical, 2)

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
                                            Rectangle()
                                                .foregroundStyle(Color.blue)
                                                .frame(width: 8, height: 8)


                                            Text("\(new.tabcoins) tabcoins")
                                                .foregroundColor(.secondary)
                                                .font(.footnote)
                                        }

                                        Spacer()

                                        Text(formatISODate(new.created_at))
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
            .navigationTitle("TabNews")
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
