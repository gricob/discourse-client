//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 29/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = 40
    }

    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            userLabel.text = viewModel.textLabelText
            
            self.userImage.image = viewModel.image
        }
    }
}
