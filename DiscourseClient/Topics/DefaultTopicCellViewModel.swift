//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol TopicCellViewDelegate: class {
    func imageLoaded(path: IndexPath)
}

/// ViewModel que representa un topic en la lista
class DefaultTopicCellViewModel: TopicCellViewModel {
    let topic: Topic
    let baseURL: String = "https://mdiscourse.keepcoding.io"
    
    let path: IndexPath
    var viewDelegate: TopicCellViewDelegate?
    var textLabelText: String?
    var postsCountLabelText: String?
    var postersCountLabelText: String?
    var lastPostUpdatedAt: Date?
    var image: UIImage?
    
    init(topic: Topic, latestPoster poster: TopicUser?, path: IndexPath) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "MMM d"
        
        self.topic = topic
        self.path = path
        self.textLabelText  = topic.title
        self.postsCountLabelText = String(topic.posters.count)
        self.postersCountLabelText = String(topic.replyCount)
        self.lastPostUpdatedAt = topic.lastPostedAt
        
        guard let poster = poster else { return }
        
        let imageURLPath = (baseURL + poster.avatarTemplate).replacingOccurrences(of: "{size}", with: "64")
        
        guard let imageURL = URL(string: imageURLPath) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let imageData = try? Data(contentsOf: imageURL, options: [.mappedIfSafe]) else { return }
            
            self?.image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self?.viewDelegate?.imageLoaded(path: self!.path)
            }
        }
    }
}
