//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailViewDelegate {
    func userDetailFetched()
    func userDetailUpdated()
    func errorFetchingUserDetail()
    func errorUpdatingUserDetail()
}

class UserDetailViewModel {
    
    var labelUserIDText: String?
    var labelUserUsernameText: String?
    var labelUserNameText: String?
    var canEditName: Bool?
    
    let username: String
    let dataManager: UserDetailDataManager
    
    var viewDelegate: UserDetailViewDelegate?
    
    init(username: String, dataManager: UserDetailDataManager) {
        self.username = username
        self.dataManager = dataManager
    }
    
    func viewDidLoad() {
        dataManager.fetchUser(username: username) { [weak self] (result) in
            switch (result) {
                case .success(let result):
                    guard let result = result else { break }
                    
                    let user = result.user
                    
                    self?.labelUserIDText = "\(user.id)"
                    self?.labelUserNameText = user.name
                    self?.labelUserUsernameText = user.username
                    self?.canEditName = user.canEditName
                
                    self?.viewDelegate?.userDetailFetched()
                    break
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.errorFetchingUserDetail()
                    break
            }
        }
    }
    
    func updateButtonTapped(name: String?) {
        dataManager.updateUser(username: username, name: name) { [weak self](result) in
            switch (result) {
            case .success:
                self?.viewDelegate?.userDetailUpdated()
                break
            case .failure:
                self?.viewDelegate?.errorUpdatingUserDetail()
                break
            }
        }
    }
}
