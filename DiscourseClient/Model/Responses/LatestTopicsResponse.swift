import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Codable {
    var users: [TopicUser]
    var topics: [Topic]
    
    enum CodingKeys: String, CodingKey {
        case users
        case topicList = "topic_list"
    }
    
    enum TopicListKeys: String, CodingKey {
        case topics
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        users = try values.decode([TopicUser].self, forKey: .users)
        let topicList = try values.nestedContainer(keyedBy: TopicListKeys.self, forKey: .topicList)
        topics = try topicList.decode([Topic].self, forKey: .topics)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var topicList = container.nestedContainer(keyedBy: TopicListKeys.self, forKey: .topicList)
        try topicList.encode(topics, forKey: .topics)
    }
}

struct Topic: Codable {
    var id: Int
    var title: String
    var postsCount: Int
    var replyCount: Int
    var lastPosterUsername: String
    var lastPostedAt: Date?
    var excerpt: String?
    var pinned: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case lastPostedAt = "last_posted_at"
        case lastPosterUsername = "last_poster_username"
        case excerpt
        case pinned
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        postsCount = try values.decode(Int.self, forKey: .postsCount)
        replyCount = try values.decode(Int.self, forKey: .replyCount)
        lastPosterUsername = try values.decode(String.self, forKey: .lastPosterUsername)
        excerpt = (try values.decodeIfPresent(String.self, forKey: .excerpt)) ?? nil
        pinned = try values.decode(Bool.self, forKey: .pinned)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        
        let lastPostedAtString = try values.decode(String.self, forKey: .lastPostedAt)
        lastPostedAt = dateFormatter.date(from: lastPostedAtString)

    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct TopicUser: Codable {
    var id: Int
    var username: String
    var avatarTemplate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case avatarTemplate = "avatar_template"
    }
}
