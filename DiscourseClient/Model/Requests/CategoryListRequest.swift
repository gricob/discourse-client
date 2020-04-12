//
//  CategoryListRequest.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class CategoryListRequest: APIRequest {
    
    typealias Response = CategoryListResponse
    
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/categories.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
       return [:]
    }
    
    var headers: [String : String] {
           return [:]
    }
}
