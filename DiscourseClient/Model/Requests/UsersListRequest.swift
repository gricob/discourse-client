//
//  UsersListRequest.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct ActiveUsersRequest: APIRequest {
    
    typealias Response = UsersListResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/admin/users/list/{flag}.json"
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
