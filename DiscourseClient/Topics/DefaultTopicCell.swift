//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class DefaultTopicCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .textStyle5
        
        return label
    }()
    
    lazy var authorImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 32
        image.layer.masksToBounds = true
        image.backgroundColor = .lightGray
        
        return image
    }()
    
    lazy var postCount: IconLabelView = {
        let iconLabel = IconLabelView(icon: UIImage(named: "AnswersIcon"))
        iconLabel.textLabel.font = .textStyle7
        return iconLabel
    }()
    
    lazy var replyCount: IconLabelView = {
        let iconLabel = IconLabelView(icon: UIImage(named: "ViewsIcon"))
        iconLabel.textLabel.font = .textStyle7
        return iconLabel
    }()
    
    lazy var lastPostedAt: IconLabelView = {
        let iconLabel = IconLabelView(icon: UIImage(named: "CalendarIcon"))
        iconLabel.textLabel.font = .textStyle2
        return iconLabel
    }()
    
    lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [postCount, replyCount, lastPostedAt])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 6
        stack.axis = .horizontal
        
        return stack
    }()
    
    var viewModel: DefaultTopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.textLabelText
            postCount.setText(viewModel.postsCountLabelText)
            replyCount.setText(viewModel.replyCountLabelText)
            lastPostedAt.setText(viewModel.lastPostUpdatedAt)
            authorImage.image = viewModel.image
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(authorImage)
        NSLayoutConstraint.activate([
            authorImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            authorImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorImage.widthAnchor.constraint(equalToConstant: 64),
            authorImage.heightAnchor.constraint(equalToConstant: 64),
        ])
        
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: authorImage.rightAnchor, constant: 11),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -59)
        ])
        
        contentView.addSubview(infoStack)
        NSLayoutConstraint.activate([
            infoStack.leftAnchor.constraint(equalTo: authorImage.rightAnchor, constant: 11),
            infoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
