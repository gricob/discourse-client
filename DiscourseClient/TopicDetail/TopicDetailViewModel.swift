//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
    func topicDeleted()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func errorDeletingTopic()
}

class TopicDetailViewModel {
    var labelTopicIDText: String?
    var labelTopicNameText: String?
    var labelTopicPostsCountText: String?
    var showDeleteButton: Bool?
    var lastPostedAt: Date?

    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }

    func viewDidLoad() {
        self.topicDetailDataManager.fetchTopic(id: topicID) { [weak self] (result) in
            switch (result) {
                case .success(let topic):
                    
                    guard let topic = topic else { return }
                    
                    self?.labelTopicIDText = "\(topic.id)"
                    self?.labelTopicNameText = "\(topic.title)"
                    self?.labelTopicPostsCountText = "\(topic.postsCount)"
                    self?.showDeleteButton = topic.canDelete
                    self?.lastPostedAt = topic.lastPostedAt
                    
                    self?.viewDelegate?.topicDetailFetched()
                    break
                case .failure:
                    self?.viewDelegate?.errorFetchingTopicDetail()
                    break
            }
        }
        
    }

    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }
    
    func deleteButtonTapped() {
        self.topicDetailDataManager.deleteTopic(id: topicID) { [weak self] (result) in
            switch (result) {
                case .success:
                    self?.coordinatorDelegate?.topicDeleted()
                    break
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.errorDeletingTopic()
                    break
            }
        }
    }
}
