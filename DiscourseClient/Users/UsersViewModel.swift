//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UsersCoordinatorDelegate: class {
    func didSelect(user: UserListItem)
}

protocol UsersViewDelegate: class {
    func usersFetched()
    func errorFetchingUsers()
}

class UsersViewModel {

    weak var coordinatorDelegate: UsersCoordinatorDelegate?
    weak var viewDelegate: UsersViewDelegate?
    weak var cellViewDelegate: UserCellViewDelegate?
    let usersDataManager: UsersDataManager
    var userViewModels: [UserCellViewModel] = []
    
    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }
    
    func viewWasLoaded() {
        /** TODO:
         Recuperar el listado de usuarios del dataManager
         Asignar el resultado a la lista de viewModels (que representan celdas de la interfaz
         Avisar a la vista de que ya tenemos topics listos para pintar
         */
        usersDataManager.fetchAllUsers { [weak self] (result) in
            switch result {
            case .success(let usersList):
                    self?.userViewModels.removeAll()
                    
                    guard let usersList = usersList else { return }
                    
                    for (index, user) in usersList.users.enumerated() {
                        let cellViewModel = UserCellViewModel(user: user, path: IndexPath(row: index, section: 0))
                        cellViewModel.viewDelegate = self?.cellViewDelegate
                        self?.userViewModels.append(cellViewModel)
                    }
                    
                    self?.viewDelegate?.usersFetched()
                    break
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.errorFetchingUsers()
                    break
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return userViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userViewModels.count else { return nil }
        
        return userViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < userViewModels.count else { return }
        
        coordinatorDelegate?.didSelect(user: userViewModels[indexPath.row].user)
    }
}
