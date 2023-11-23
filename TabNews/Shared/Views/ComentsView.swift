//
//  ComentsView.swift
//  TabNews
//
//  Created by Horacio Mota on 23/11/23.
//

import SwiftUI

struct ComentsView: View {
    var user: String
    var slug: String
    @State private var comentsModel: ComentsModel?
    @StateObject var viewModel = ComentsViewModel()
    @StateObject var vm = PostListViewModel() // Estou bustandio o date formatter


    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.coments) { coment in
                    HStack {
                        Text(vm.formatISODate(coment.created_at))
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                            .padding()

                        Spacer()

                        Text(coment.owner_username)
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                            .padding(.horizontal)
                            .background(.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    }
                    Text(coment.body)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.fetchComents(user: user, slug: slug)
        }
    }
}

#Preview {
    ComentsView(user: "maxsonalmeida", slug: "o-dev-junior-nao-pode-subestimar-o-poder-do-linkedin")
}
