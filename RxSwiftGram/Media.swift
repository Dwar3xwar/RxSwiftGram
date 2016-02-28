import Foundation
import Moya_ObjectMapper
import ObjectMapper

enum MediaType: String {
    case Image = "image"
    case Video = "video"
}


struct Media {
    
    var id: String?
    var caption: String?
    var type: MediaType?
    var user: User?
    
    var standardResolutionURL: NSURL?
    var thumbnailURL: NSURL?
    var lowResolutionURL: NSURL?
    
    lazy var viewModel: MediaViewModel = {
        return MediaViewModel(media: self)
    }()
}

extension Media: Equatable {}

func ==(lhs: Media, rhs: Media) -> Bool {
    return lhs.id == rhs.id 
}

extension Media: Mappable {
    init?(_ map: Map) {

    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        type <- (map["type"], setMediaType)
        caption <- map["caption.text"]
        
        standardResolutionURL <- (map["images.standard_resolution.url"], transformURLString)
        thumbnailURL <- (map["images.thumbnail.url"], transformURLString)
        lowResolutionURL <- (map["images.low_resolution.url"], transformURLString)
        
        // Custom Mapping To User Model
        user = User(map.vanillaUserDictionary())
        user?.mapping(map.vanillaUserDictionary())
    }
}

/// Get NSURL from Images String
let transformURLString = TransformOf<NSURL, String>(fromJSON: { string in
    guard let urlString = string else { return nil }
    return NSURL(string:urlString)
})
    { url in
    return url?.absoluteString
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





