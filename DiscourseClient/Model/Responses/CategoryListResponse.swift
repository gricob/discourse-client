//
//  CategoryListResponse.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct CategoryListResponse: Codable {
    var categories: [Category]
    
    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let categoryList = try values.decode(CategoryList.self, forKey: .categoryList)
        categories = categoryList.categories
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(categories, forKey: .categoryList)
    }
}

struct CategoryList: Codable {
    var categories: [Category]
}

struct Category: Codable {
    var name: String
}
