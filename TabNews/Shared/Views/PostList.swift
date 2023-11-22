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
                LazyVStack(alignment: .leading, spacing: 32) {
                    ForEach(ListofNews, id: \.id) { new in
                        NavigationLink(destination: postContent(user: new.owner_username, slug: new.slug)) {
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

                                        HStack {
                                            Circle()
                                                .foregroundStyle(Color.yellow)
                                                .frame(width: 5, height: 5)


                                            Text("\(new.tabcoins) tabcoins")
                                                .foregroundColor(.secondary)
                                                .font(.footnote)
                                        }


                                        Spacer()

                                        Text(formatISODate(new.created_at))
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
