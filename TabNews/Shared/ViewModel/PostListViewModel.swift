//
//  PostListViewModel.swift
//  TabNews
//
//  Created by Horacio Mota on 21/11/23.
//

import Foundation
import SwiftSoup

class PostListViewModel: ObservableObject {

    // Listar todos os posts na pagina inicial
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

    // Listar todo o conteudo especifico do post
    func loadPostContent(user: String, slug: String) async throws -> PostContent {
        let urlString = "https://www.tabnews.com.br/api/v1/contents/\(user)/\(slug)"
        guard let url = URL(string: urlString) else {
            print("Ops...Check your URL, something went wrong")
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        print("Wait, fetching post data... [1/2]")
        let postContent = try JSONDecoder().decode(PostContent.self, from: data)
        print("Content fetch... [2/2]")
        return postContent
    }

    // Fazer chamada da thumbnail do post
    func loadPostThumbnail(user: String, slug: String) async throws -> Data {
        let urlString = "https://www.tabnews.com.br/api/v1/contents/\(user)/\(slug)/thumbnail"
        guard let url = URL(string: urlString) else {
            print("Ops...Check your URL, something went wrong")
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        print("Wait, fetching post thumbnail...[1/2]")

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Thumbnail fetch... [2/2]")
            throw URLError(.badServerResponse)
        }

        return data
    }

}


