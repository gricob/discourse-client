//
//  SingleUserResponse.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct SingleUserResponse: Codable {
    var user: User
}

struct User: Codable {
    var id: Int
    var name: String?
    var username: String
    var avatarTemplate: String
    var title: String?
    var canEditName: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case avatarTemplate = "avatar_template"
        case title
        case canEditName = "can_edit_name"
    }
}
