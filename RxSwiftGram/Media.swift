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
        id <- map["data.id"]
        type <- (map["data.type"], setMediaType)
        
        let userMapper = Mapper<User>()
        let userMap: User! = userMapper.map(map.JSONDictionary as [String: AnyObject])
        
        print(userMap)
        
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







