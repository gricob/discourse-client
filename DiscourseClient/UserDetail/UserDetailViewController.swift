//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    lazy var labelUserID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelUserName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textFieldUserName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var labelUserUsername: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonUpdateUser: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
       
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
       
        return button
    }()
    
    lazy var userIDStackView: UIStackView = {
        let labelUserIDTitle = UILabel()
        labelUserIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserIDTitle.text = NSLocalizedString("ID: ", comment: "")
        labelUserIDTitle.textColor = .black

        let userIDStackView = UIStackView(arrangedSubviews: [labelUserIDTitle, labelUserID])
        userIDStackView.translatesAutoresizingMaskIntoConstraints = false
        userIDStackView.axis = .horizontal

        return userIDStackView
    }()
    
    lazy var userNameStackView: UIStackView = {
        let labelUserNameTitle = UILabel()
        labelUserNameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserNameTitle.text = NSLocalizedString("Name: ", comment: "")
        labelUserNameTitle.textColor = .black

        let userNameStackView = UIStackView(arrangedSubviews: [labelUserNameTitle, labelUserName])
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.axis = .horizontal

        return userNameStackView
    }()
    
    lazy var userUsernameStackView: UIStackView = {
        let labelUserUsernameTitle = UILabel()
        labelUserUsernameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserUsernameTitle.text = NSLocalizedString("Username: ", comment: "")
        labelUserUsernameTitle.textColor = .black

        let userUsernameStackView = UIStackView(arrangedSubviews: [labelUserUsernameTitle, labelUserUsername])
        userUsernameStackView.translatesAutoresizingMaskIntoConstraints = false
        userUsernameStackView.axis = .horizontal

        return userUsernameStackView
    }()
    
    lazy var userNameTextFieldStackView: UIStackView = {
        let labelUserNameTitle = UILabel()
        labelUserNameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserNameTitle.text = NSLocalizedString("Name: ", comment: "")
        labelUserNameTitle.textColor = .black

        let userNameTextFieldStackView = UIStackView(arrangedSubviews: [labelUserNameTitle, textFieldUserName])
        userNameTextFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameTextFieldStackView.axis = .horizontal
        userNameTextFieldStackView.isHidden = true

        return userNameTextFieldStackView
    }()
    
    lazy var updateUserButtonStackView: UIStackView = {
        let updateUserButtonStackView = UIStackView(arrangedSubviews: [buttonUpdateUser])
        updateUserButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        updateUserButtonStackView.axis = .horizontal
        updateUserButtonStackView.isHidden = true
        
        return updateUserButtonStackView
    }()
    
    let viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(userIDStackView)
        NSLayoutConstraint.activate([
            userIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        view.addSubview(userUsernameStackView)
        NSLayoutConstraint.activate([
            userUsernameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userUsernameStackView.topAnchor.constraint(equalTo: userIDStackView.bottomAnchor, constant: 16)
        ])
        
        view.addSubview(userNameStackView)
        NSLayoutConstraint.activate([
            userNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameStackView.topAnchor.constraint(equalTo: userUsernameStackView.bottomAnchor, constant: 16)
        ])
        
        view.addSubview(userNameTextFieldStackView)
        NSLayoutConstraint.activate([
            userNameTextFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameTextFieldStackView.topAnchor.constraint(equalTo: userUsernameStackView.bottomAnchor, constant: 16)
        ])
        
        view.addSubview(updateUserButtonStackView)
        NSLayoutConstraint.activate([
            updateUserButtonStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            updateUserButtonStackView.topAnchor.constraint(equalTo: userNameTextFieldStackView.bottomAnchor, constant: 16)
        ])
    }
    
    @objc func updateButtonTapped() {
        let name = textFieldUserName.text
        
        viewModel.updateButtonTapped(name: name)
    }
    
    fileprivate func updateUI() {
        labelUserID.text = viewModel.labelUserIDText
        labelUserUsername.text = viewModel.labelUserUsernameText
        labelUserName.text = viewModel.labelUserNameText
        textFieldUserName.text = viewModel.labelUserNameText
        
        let canEdit = viewModel.canEditName ?? false
    
        userNameTextFieldStackView.isHidden = !canEdit
        updateUserButtonStackView.isHidden = !canEdit
        userNameStackView.isHidden = canEdit
        
    }
    
    fileprivate func showUserUpdatedAlert() {
        let alertMessage: String = NSLocalizedString("User updated successfuly", comment: "")
        let alertTitle: String = NSLocalizedString("Success", comment: "")
        showAlert(alertMessage, alertTitle)
    }
    
    fileprivate func showErrorUpdatingUserAlert() {
        let alertMessage: String = NSLocalizedString("Error updating user\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showErrorFetchingUserAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching user\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension UserDetailViewController: UserDetailViewDelegate {
    func userDetailFetched() {
        updateUI()
    }
    
    func errorFetchingUserDetail() {
        showErrorFetchingUserAlert()
    }
    
    func userDetailUpdated() {
        showUserUpdatedAlert()
    }
    
    func errorUpdatingUserDetail() {
        showErrorUpdatingUserAlert()
    }
}
