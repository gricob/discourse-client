//
//  WelcomeCellViewModel.swift
//  DiscourseClient
//
//  Created by Gerardo Rico Botella on 30/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class PinnedTopicCellViewModel: TopicCellViewModel {
    let topic: Topic
    let titleText: String
    let excerptText: String?
    
    init(topic: Topic) {
        self.topic = topic
        self.titleText = topic.title
        self.excerptText = topic.excerpt
    }
}
