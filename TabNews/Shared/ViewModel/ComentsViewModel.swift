//
//  ComentsViewModel.swift
//  TabNews
//
//  Created by Horacio Mota on 23/11/23.
//

import Foundation

class ComentsViewModel: ObservableObject {
    @Published var coments: [Coment] = []

    // Função para carregar comentários
    func loadComents(user: String, slug: String) async throws -> [Coment] {
        let urlString = "https://www.tabnews.com.br/api/v1/contents/\(user)/\(slug)/children"
        guard let url = URL(string: urlString) else {
            print("Ops...Check your URL, something went wrong")
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        print("Wait, fetching post coments... [1/2]")
        let coments = try JSONDecoder().decode([Coment].self, from: data)
        print("Coments fetch... [2/2]")
        return coments
    }

    // Função para iniciar o carregamento dos comentários
    func fetchComents(user: String, slug: String) {
        Task {
            do {
                let loadedComents = try await loadComents(user: user, slug: slug)
                DispatchQueue.main.async {
                    self.coments = loadedComents
                }
            } catch {
                print("Erro ao carregar comentários: \(error)")
            }
        }
    }
}
