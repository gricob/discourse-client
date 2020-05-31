//
//  WelcomeCell.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 30/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class PinnedTopicCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .textStyle4
        return label
    }()
    
    lazy var excerptLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .textStyle8
        return label
    }()
    
    lazy var textStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
        titleLabel,
        excerptLabel
       ])
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 6
        stack.alignment = .leading
        stack.axis = .vertical
        
        return stack
    }()
    
    lazy var pinIconView: UIImageView = {
        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = UIImage(named: "PinIcon")
        return iconView
    }()
    
    var viewModel: PinnedTopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.titleText
            excerptLabel.text = viewModel.excerptText
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(cgColor: CGColor(srgbRed: 12/255, green: 12/255, blue: 12/255, alpha: 1))
        
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 8
        cardView.backgroundColor = .tangerine
        
        cardView.addSubview(textStack)
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 9),
            textStack.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 18),
            textStack.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -73)
        ])
        
        cardView.addSubview(pinIconView)
        NSLayoutConstraint.activate([
            pinIconView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 11),
            pinIconView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -15),
            pinIconView.heightAnchor.constraint(equalToConstant: 35),
            pinIconView.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        contentView.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            cardView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            cardView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
