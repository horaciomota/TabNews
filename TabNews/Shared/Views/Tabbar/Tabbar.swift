//
//  Tabviews.swift
//  TabNews
//
//  Created by Horacio Mota on 25/11/23.
//

import SwiftUI
import TabBarModule


struct Tabbar: View {
    var user: String
    var slug: String
    @State private var item: Int = 0

    var body: some View {
        TabBar(selection: $item) {
            PostList()
                .tabItem(0) {
                    Image(systemName: item == 0 ? "house.fill" : "house")
                        .font(.title3)
                        .foregroundStyle(.white)
                    Text("Home")
                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
                        .foregroundStyle(.white)
                }
            CreateAPostView()
                .tabItem(1) {
                    Image(systemName: item == 0 ? "square.and.pencil" : "square.and.pencil")
                        .font(.title3)
                        .foregroundStyle(.white)
                    Text("Post")
                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
                        .foregroundStyle(.white)
                }
            LoginView()
                .tabItem(2) {
                    Image(systemName: item == 0 ? "person" : "person.fill")
                        .font(.title3)
                        .foregroundStyle(.white)
                    Text("Profile")
                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
                        .foregroundStyle(.white)
                }
        }
        .tabBarPadding(.vertical, 8)
           .tabBarPadding(.horizontal, 16)
           .tabBarShape(Capsule(style: .continuous))
           .tabBarFill(.black)
    }
}

#Preview {
    Tabbar(user: "maxsonalmeida", slug: "o-dev-junior-nao-pode-subestimar-o-poder-do-linkedin")
}
