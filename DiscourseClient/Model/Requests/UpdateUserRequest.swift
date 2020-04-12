//
//  UpdateUserRequest.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class UpdateUserRequest: APIRequest {
    typealias Response = UpdateUserResponse
    
    let username: String
    let name: String?
    
    init(username: String, name: String?) {
        self.username = username
        self.name = name
    }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "/users/\(username).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return ["name": name]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
