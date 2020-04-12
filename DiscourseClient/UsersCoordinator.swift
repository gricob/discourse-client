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
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        let usersViewModel = UsersViewModel()
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        
        presenter.pushViewController(usersViewController, animated: false)
    }
}
