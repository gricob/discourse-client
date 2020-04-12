import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    var id: Int
    var title: String
    var postsCount: Int
    var canDelete: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
        case details
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        postsCount = try values.decode(Int.self, forKey: .postsCount)
        
        if let details = try? values.decode(TopicDetails.self, forKey: .details) {
            canDelete = details.canDelete
        } else {
            canDelete = false
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let details = TopicDetails(canDelete: canDelete)
        try container.encode(details, forKey: .details)
    }
}

struct TopicDetails: Codable {
    var canDelete: Bool
    
    init(canDelete: Bool) {
        self.canDelete = canDelete
    }
    
    enum CodingKeys: String, CodingKey {
        case canDelete = "can_delete"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        canDelete = try values.decode(Bool.self, forKey: .canDelete)
    }
}
