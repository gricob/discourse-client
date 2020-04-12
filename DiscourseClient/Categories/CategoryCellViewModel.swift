//
//  CategoryCellViewModel.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class CategoryCellViewModel {
    let category: Category
    
    var textLabelText: String
    
    init(category: Category) {
        self.category = category
        
        self.textLabelText = category.name
    }
}
