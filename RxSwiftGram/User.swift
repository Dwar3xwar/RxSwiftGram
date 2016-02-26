import Foundation
import Moya_ObjectMapper
import ObjectMapper

struct User {
    var id: String?
    var username: String?
    var fullName: String?
    var profilePicture: String?
    var bio: String?
    var website: String?
    
}

extension User: Mappable {
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["data.id"]
        username <- map["data.username"]
        fullName <- map["data.full_name"]
        profilePicture <- map["data.profile_picture"]
        bio <- map["data.bio"]
        website <- map["data.website"]
    }
}