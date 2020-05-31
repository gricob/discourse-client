//
//  TopicStat.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 29/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class TopicStatView: UIView {
    
    var imageView: UIImageView = UIImageView()
    
    var textLabel: UILabel = UILabel()

    init(frame: CGRect, image: UIImage, text: String) {
        super.init(frame: frame)
        
        self.imageView.image = image
        self.textLabel.text = text
        
        addSubview(imageView)
        addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupXib()
    }
    
    func setupXib() {
        view = loadN
    }
}
