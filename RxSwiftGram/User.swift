import Foundation
import Moya_ObjectMapper
import ObjectMapper

struct User {
    var id: String?
    var username: String?
    var fullName: String?
    var profilePicture: String?
}

extension User: Equatable {}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id &&
            lhs.username == rhs.username &&
            lhs.fullName == rhs.fullName &&
            lhs.profilePicture == rhs.profilePicture 
}

extension User: Mappable {
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        fullName <- map["full_name"]
        profilePicture <- map["profile_picture"]
    }
}