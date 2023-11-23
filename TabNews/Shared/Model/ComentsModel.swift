//
//  ComentsModel.swift
//  TabNews
//
//  Created by Horacio Mota on 23/11/23.
//

import Foundation

struct ComentsModel: Codable {
    let id: String
    let body: String
    let published_at: String
    let owner_username: String
}
