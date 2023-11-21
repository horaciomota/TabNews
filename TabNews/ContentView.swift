//
//  ContentView.swift
//  TabNews
//
//  Created by Horacio Mota on 21/11/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var ListofNews: [newsDataModel] = []
    @StateObject var viewModel = PostListViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Titulo da postagem")


        }
        .padding()
    }
}

#Preview {
    ContentView()
}
