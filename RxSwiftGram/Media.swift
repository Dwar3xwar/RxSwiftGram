import Foundation
import Moya_ObjectMapper
import ObjectMapper

enum MediaType: String {
    case Image = "image"
    case Video = "video"
}

struct Media {
    
    var id: String?
    var type: MediaType?
    var user: User?
    
}

extension Media: Mappable {
    init?(_ map: Map) {

    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        type <- (map["type"], setMediaType)
        
        // Custom Mapping To User Model
        user = User(map.vanillaUserDictionary())
        user?.mapping(map.vanillaUserDictionary())
    
        
    }
}

/// Get Media Type from string
let setMediaType = TransformOf<MediaType, String>(fromJSON: { type in
    guard type == MediaType.Image.rawValue else {
        return .Video
    }
    return .Image
})
    { mediaType in
        
    return mediaType!.rawValue
}



private extension Map {
    /// Raw User Dictionary From Instagram API For Media
    func vanillaUserDictionary() -> Map {
        
        guard let unwrappedUserDictionary = self.JSONDictionary["user"] as? [String: String] else {
            return self
        }
        
        return Map(mappingType: .FromJSON, JSONDictionary: unwrappedUserDictionary)
    }
}





