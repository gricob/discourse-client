//
//  UsersListResponse.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UsersListResponse: Codable {
    var users: [User] = []
    
    enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let directoryItems = try values.decode([DirectoryItem].self, forKey: .directoryItems)
        
        for directoryItem in directoryItems {
            if !users.contains(directoryItem.user) {
                users.append(directoryItem.user)
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let directoryItems = users.map { DirectoryItem(user: $0) }
        try container.encode(directoryItems, forKey: .directoryItems)
    }
}

struct DirectoryItem: Codable {
    var user: User
    
    init(user: User) {
        self.user = user
    }
}

struct User: Codable, Equatable {
    var id: Int
    var username: String
    var name: String?
    var avatarTemplate: String
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case avatarTemplate = "avatar_template"
        case title
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        username = try values.decode(String.self, forKey: .username)
        name = try values.decode(String?.self, forKey: .name)
        avatarTemplate = try values.decode(String.self, forKey: .avatarTemplate)
        title = try values.decode(String?.self, forKey: .title)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

