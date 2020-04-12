//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailDataManager {
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ())
    
    func updateUser(username: String, name: String?, completion: @escaping (Result<UpdateUserResponse?, Error>) -> ())
}
