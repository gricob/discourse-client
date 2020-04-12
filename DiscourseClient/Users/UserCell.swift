//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelText
            
            if let image = viewModel.image {
                self.imageView?.image = image
            } else {
                viewModel.onImageLoaded = { [weak self] in
                    self?.imageView?.image = viewModel.image
                }
            }
        }
    }
    
}
