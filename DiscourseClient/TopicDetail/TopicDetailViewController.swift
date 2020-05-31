//
//  TopicDetailViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un Topic
class TopicDetailViewController: UIViewController {

    lazy var topicTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .bold)
        return label
    }()
    
    lazy var topicInfoStack: TopicInfoStackView = {
        return TopicInfoStackView()
    }()
    
    lazy var topicBodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    let viewModel: TopicDetailViewModel

    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height), animated: false)
        scrollView.isDirectionalLockEnabled = true
        scrollView.alwaysBounceVertical = true
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        contentView.addSubview(topicTitleLabel)
        NSLayoutConstraint.activate([
            topicTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            topicTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            topicTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
        ])
        
        contentView.addSubview(topicInfoStack)
        NSLayoutConstraint.activate([
            topicInfoStack.topAnchor.constraint(equalTo: topicTitleLabel.bottomAnchor, constant: 16),
            topicInfoStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
        ])

        contentView.addSubview(topicBodyLabel)
        NSLayoutConstraint.activate([
            topicBodyLabel.topAnchor.constraint(equalTo: topicInfoStack.bottomAnchor, constant: 11),
            topicBodyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            topicBodyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        viewModel.viewDidLoad()
    }
    
    @objc func deleteButtonTapped() {
        viewModel.deleteButtonTapped()
    }

    fileprivate func showErrorFetchingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showErrorDeletingTopicAlert() {
        let alertMessage: String = NSLocalizedString("Error deleting topic\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }

    fileprivate func updateUI() {
        topicTitleLabel.text = viewModel.labelTopicNameText
        topicBodyLabel.text = viewModel.labelTopicNameText
        topicInfoStack.setPostCount(text: viewModel.labelTopicPostsCountText)
        topicInfoStack.setLastPostedAt(date: viewModel.lastPostedAt)
    }
}

extension TopicDetailViewController: TopicDetailViewDelegate {
    func topicDetailFetched() {
        updateUI()
    }

    func errorFetchingTopicDetail() {
        showErrorFetchingTopicDetailAlert()
    }
    
    func errorDeletingTopic() {
        showErrorDeletingTopicAlert()
    }
}
