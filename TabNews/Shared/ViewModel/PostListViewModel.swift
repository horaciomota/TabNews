//
//  PostListViewModel.swift
//  TabNews
//
//  Created by Horacio Mota on 21/11/23.
//

import Foundation

class PostListViewModel: ObservableObject {

    func fetchNewPosts() async throws -> [newsDataModel] {

        let baseURL = "https://www.tabnews.com.br/api/v1/contents?page=1&per_page=30"

        guard let url = URL(string: baseURL) else {
            print("Ops...Check your URL, something went wrong")
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        print("Wait: Fetching data...")
        let urlDataResponse = try JSONDecoder().decode([newsDataModel].self, from: data)
        print("All done: You got: \(urlDataResponse.count) bytes of data from api")
        return urlDataResponse.self

    }

}
