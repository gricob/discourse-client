//
//  IconLabelView.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 29/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class IconLabelView: UIView {
    lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.alpha = 0.5
        return label
    }()
    
    init(icon: UIImage?) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        iconView.image = icon
        
        addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.leftAnchor.constraint(equalTo: leftAnchor),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 14),
        ])
        
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 4),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
    func setText(_ text: String?) {
        textLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
