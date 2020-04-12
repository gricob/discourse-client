//
//  UsersDataManager.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UsersDataManager {
    func fetchUsers(completion: @escaping (Result<UsersResponse, Error>) -> ())
}
