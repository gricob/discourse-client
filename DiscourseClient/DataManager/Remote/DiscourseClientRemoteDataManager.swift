//
//  DiscourseClientRemoteDataManager.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Protocolo que contiene todas las llamadas remotas de la app
protocol DiscourseClientRemoteDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ())
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ())
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ())
    func addTopic(title: String, raw: String, createdAt: Date, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ())
    func fetchAllUsers(completion: @escaping (Result<UsersListResponse?, Error>) -> ())
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ())
    func updateUser(username: String, name: String?, completion: @escaping (Result<UpdateUserResponse?, Error>) -> ())
    func fetchAllCategories(completion: @escaping (Result<CategoryListResponse?, Error>) -> ())
}
