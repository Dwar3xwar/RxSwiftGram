import Foundation
import Moya_ObjectMapper
import ObjectMapper

struct Comment {
    
    var id: String?
    var text: String?
    var createdTime: String?
    var from: User?
    
}

extension Comment: Mappable {
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        text <- map["text"]
        createdTime <- map["created_time"]
        
        from = User(map.vanillaUserDictionary())
        from?.mapping(map.vanillaUserDictionary())
    }
}

private extension Map {
    /// Raw User Dictionary From Instagram API for Comment 
    func vanillaUserDictionary() -> Map {
        
        guard let unwrappedUserDictionary = self.JSONDictionary["from"] as? [String: String] else {
            return self
        }
        
        return Map(mappingType: .FromJSON, JSONDictionary: unwrappedUserDictionary)
    }
}
