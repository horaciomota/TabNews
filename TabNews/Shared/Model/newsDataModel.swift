//
//  newsDataModel.swift
//  TabNews
//
//  Created by Horacio Mota on 21/11/23.
//

import Foundation

struct newsDataModel: Codable, Identifiable {
    var id: String
    var title: String
    var created_at: String
    var tabcoins: Int
    var owner_username: String
    var slug: String
}

struct postModel: Codable, Identifiable {
    var id: String
    var title: String

}

