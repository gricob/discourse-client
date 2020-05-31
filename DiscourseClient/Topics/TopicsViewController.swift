//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(PinnedTopicCell.self, forCellReuseIdentifier: "PinnedTopicCell")
        table.register(DefaultTopicCell.self, forCellReuseIdentifier: "DefaultTopicCell")
        table.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return table
    }()
    
    lazy var newTopicButton: UIButton = {
        
        let button = UIButton(frame: .zero)
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "NewTopicButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 32
        
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        
        return refreshControl
    }()

    let viewModel: TopicsViewModel
    
    var loadedIndexPaths: [IndexPath] = []

    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(newTopicButton)
        NSLayoutConstraint.activate([
            newTopicButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            newTopicButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            newTopicButton.widthAnchor.constraint(equalToConstant: 64),
            newTopicButton.heightAnchor.constraint(equalToConstant: 64)
        ])

        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))

        let rightBarButtonItem: UIBarButtonItem = searchButton
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        
        tableView.refreshControl = self.refreshControl
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController?.isActive = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        
        viewModel.viewWasLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }
    
    @objc func searchButtonTapped() {
        print("Search action is not implemented")
    }
    
    @objc func refreshControlPulled() {
        viewModel.fetchTopics()
    }

    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = viewModel.viewModel(at: indexPath)
        
        switch cellViewModel {
            case is PinnedTopicCellViewModel:
                return 151
            default:
                return 96
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if loadedIndexPaths.contains(indexPath) {
            return
        }
        
        loadedIndexPaths.append(indexPath)
        
        guard let cell = cell as? DefaultTopicCell else { return }
        
        cell.authorImage.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            cell.authorImage.alpha = 1
        })
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.viewModel(at: indexPath)
        
        if let cellViewModel = cellViewModel as? PinnedTopicCellViewModel {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PinnedTopicCell", for: indexPath) as? PinnedTopicCell {
                cell.viewModel = cellViewModel
                return cell
            }
        } else if let cellViewModel = cellViewModel as? DefaultTopicCellViewModel {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTopicCell", for: indexPath) as? DefaultTopicCell {
                cell.viewModel = cellViewModel
                return cell
            }
        }

        fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension TopicsViewController: TopicsViewDelegate {
    func topicsFetched() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
    }
}

extension TopicsViewController: TopicCellViewDelegate {
    func imageLoaded(path: IndexPath) {
        if view.window == nil { return }
        
        guard let visibleIndexPaths = tableView.indexPathsForVisibleRows else { return }
        
        if visibleIndexPaths.contains(path) {
            tableView.reloadRows(at: [path], with: .none)
        }
    }
}

extension TopicsViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Time to search!")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search!")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
