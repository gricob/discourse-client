//
//  TopicInfoStackView.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 31/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class TopicInfoStackView: UIStackView {
    lazy var postCount: IconLabelView = {
        let iconLabel = IconLabelView(icon: UIImage(named: "AnswersIcon"))
        iconLabel.textLabel.font = .textStyle7
        return iconLabel
    }()
    
    lazy var postersCount: IconLabelView = {
        let iconLabel = IconLabelView(icon: UIImage(named: "ViewsIcon"))
        iconLabel.textLabel.font = .textStyle7
        return iconLabel
    }()
    
    lazy var lastPostedAt: IconLabelView = {
        let iconLabel = IconLabelView(icon: UIImage(named: "CalendarIcon"))
        iconLabel.textLabel.font = .textStyle2
        return iconLabel
    }()
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    init() {
        super.init(frame: .zero)
        
        dateFormatter.locale = Locale(identifier: "es")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "MMM d"
        
        self.addArrangedSubview(postCount)
        self.addArrangedSubview(postersCount)
        self.addArrangedSubview(lastPostedAt)
        
        translatesAutoresizingMaskIntoConstraints = false
        spacing = 6
        axis = .horizontal
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPostCount(text: String?) {
        postCount.textLabel.text = text
    }
    
    func setPostersCount(text: String?) {
        postersCount.textLabel.text = text
    }
    
    func setLastPostedAt(date: Date?) {
        lastPostedAt.textLabel.text = (date != nil) ? dateFormatter.string(from: date!).capitalized : nil
    }
}
