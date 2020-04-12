import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Codable {
    var topics: [Topic]
    
    enum CodingKeys: String, CodingKey {
        case topicList = "topic_list"
    }
    
    enum TopicListKeys: String, CodingKey {
        case topics
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}
