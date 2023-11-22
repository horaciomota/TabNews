//
//  PostContentModel.swift
//  TabNews
//
//  Created by Horacio Mota on 22/11/23.
//

import Foundation

// Model para dar fetch em todo o conteudo interno do post apos acessado
struct PostContent: Codable {
    var id: String
    var ownerId: String
    var parentId: String?
    var slug: String
    var title: String
    var body: String
    var status: String
    var sourceUrl: String?
    var createdAt: String
    var updatedAt: String
    var publishedAt: String
    var deletedAt: String?
    var ownerUsername: String
    var tabcoins: Int
    var childrenDeepCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case parentId = "parent_id"
        case slug
        case title
        case body
        case status
        case sourceUrl = "source_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case deletedAt = "deleted_at"
        case ownerUsername = "owner_username"
        case tabcoins
        case childrenDeepCount = "children_deep_count"
    }
}
