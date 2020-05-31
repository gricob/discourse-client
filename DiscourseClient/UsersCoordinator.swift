//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersCoordinator: Coordinator {
    
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    let userDetailDataManager: UserDetailDataManager
    
    init(presenter: UINavigationController, usersDataManager: UsersDataManager, userDetailDataManager: UserDetailDataManager) {
        self.presenter = presenter
        self.usersDataManager = usersDataManager
        self.userDetailDataManager = userDetailDataManager
    }
    
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        usersViewController.tabBarItem = UITabBarItem(
            title: "Usuarios",
            image: UIImage(named: "UsersUnselectedIcon")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "UsersSelectedIcon")?.withRenderingMode(.alwaysOriginal)
        )
        
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.cellViewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(usersViewController, animated: false)
    }
}

extension UsersCoordinator: UsersCoordinatorDelegate {
    func didSelect(user: UserListItem) {
        let userDetailViewModel = UserDetailViewModel(username: user.username, dataManager: userDetailDataManager)
        let userDetailViewController = UserDetailViewController(viewModel: userDetailViewModel)
        
        userDetailViewModel.viewDelegate = userDetailViewController
        
        presenter.pushViewController(userDetailViewController, animated: true)
    }
}
