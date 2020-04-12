//
//  CategoriesDataManager.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol CategoriesDataManager {
    func fetchAllCategories(completion: @escaping (Result<CategoryListResponse?, Error>) -> ())
}
