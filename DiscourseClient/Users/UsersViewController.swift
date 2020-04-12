//
//  UsersViewController.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    let viewModel: UsersViewModel
    
    init(viewModel : UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        let testLabel = UILabel()
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.text = "Get a list of users"

        view.addSubview(testLabel)
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
