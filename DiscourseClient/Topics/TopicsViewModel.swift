//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

/// ViewModel que representa un listado de topics
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    weak var cellViewDelegate: TopicCellViewDelegate?
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [TopicCellViewModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    func viewWasLoaded() {
        fetchTopics()
    }
    
    func fetchTopics() {
        topicsDataManager.fetchAllTopics { [weak self] (result) in
            switch result {
                case .success(let response):
                    self?.topicViewModels.removeAll()
                    
                    guard let response = response else { break }
                    
                    for (index, topic) in response.topics.enumerated() {
                        if topic.pinned {
                            let cellViewModel = PinnedTopicCellViewModel(topic: topic)
                            self?.topicViewModels.append(cellViewModel)
                        } else {
                            let latestPoster = response.users.first { (user) -> Bool in
                                return user.username == topic.lastPosterUsername
                            }
                            
                            let cellViewModel = DefaultTopicCellViewModel(topic: topic, latestPoster: latestPoster, path: IndexPath(row: index, section: 0))
                            cellViewModel.viewDelegate = self?.cellViewDelegate
                            self?.topicViewModels.append(cellViewModel)
                        }
                    }
                    
                    self?.viewDelegate?.topicsFetched()
                break
                case .failure:
                    self?.viewDelegate?.errorFetchingTopics()
                break
            }
        }
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }
        coordinatorDelegate?.didSelect(topic: topicViewModels[indexPath.row].topic)
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }

    func newTopicWasCreated() {
        fetchTopics()
    }
    
    func topicWasDeleted() {
        fetchTopics()
    }
}
