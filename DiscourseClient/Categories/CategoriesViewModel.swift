//
//  CategoriesViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol CategoriesViewDelegate {
    func categoriesFetched()
    func errorFetchingCategories()
}

class CategoriesViewModel {
    let dataManager: CategoriesDataManager
    
    var viewDelegate: CategoriesViewDelegate?
    var categoryViewModels: [CategoryCellViewModel] = []
    
    init(dataManager: CategoriesDataManager) {
        self.dataManager = dataManager
    }
    
    func viewDidLoad() {
        self.dataManager.fetchAllCategories { [weak self] (result) in
            switch (result) {
            case .success(let categoryList):
                guard let categoryList = categoryList else { break }
                
                self?.categoryViewModels = categoryList.categories.map { CategoryCellViewModel(category: $0) }
                
                self?.viewDelegate?.categoriesFetched()
                break
            case .failure(let error):
                print(error)
                self?.viewDelegate?.errorFetchingCategories()
                break
            }
        }
    }
    
    func viewModel(at indexPath: IndexPath) -> CategoryCellViewModel? {
        guard indexPath.row < categoryViewModels.count else { return nil }
        return categoryViewModels[indexPath.row]
    }
}
