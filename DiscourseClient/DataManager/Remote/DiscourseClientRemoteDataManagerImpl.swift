//
//  DiscourseClientRemoteDataManagerImpl.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación por defecto del protocolo remoto, en este caso usando SessionAPI
class DiscourseClientRemoteDataManagerImpl: DiscourseClientRemoteDataManager {
    
    let session: SessionAPI

    init(session: SessionAPI) {
        self.session = session
    }

    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        let request = LatestTopicsRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func addTopic(title: String, raw: String, createdAt: Date, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        let request = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        let request = DeleteTopicRequest(id: id)
        
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
    func fetchAllUsers(completion: @escaping (Result<UsersListResponse?, Error>) -> ()) {
        let request = UserListRequest()
        
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ()) {
        let request = SingleUserRequest(username: username)
        
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
    func updateUser(username: String, name: String?, completion: @escaping (Result<UpdateUserResponse?, Error>) -> ()) {
        let request = UpdateUserRequest(username: username, name: name)
        
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
    func fetchAllCategories(completion: @escaping (Result<CategoryListResponse?, Error>) -> ()) {
        let request = CategoryListRequest()
        
        session.send(request: request) { (result) in
            completion(result)
        }
    }
}
