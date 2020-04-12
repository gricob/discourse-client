//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol UserCellViewDelegate: class {
    func imageLoaded(path: IndexPath)
}

class UserCellViewModel {
    
    let baseURL: String = "https://mdiscourse.keepcoding.io"
    
    let user: User
    let path: IndexPath
    var viewDelegate: UserCellViewDelegate?
    var textLabelText: String?
    var image: UIImage?
    var onImageLoaded: (() -> Void)?
    
    init(user: User, path: IndexPath) {
        self.user = user
        self.path = path
        self.textLabelText = user.username
    
        let imageURLPath = (baseURL + user.avatarTemplate).replacingOccurrences(of: "{size}", with: "120")
        
        guard let imageURL = URL(string: imageURLPath) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            self?.image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self?.onImageLoaded?()
                self?.viewDelegate?.imageLoaded(path: self!.path)
            }
        }
    }
}
