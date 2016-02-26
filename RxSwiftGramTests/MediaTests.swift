import Foundation
import XCTest
import ObjectMapper

@testable import RxSwiftGram

class MediaTest: XCTestCase {
    
    override func setUp() {

    }
    
    func testMediaIsNotNil(){
        let JSON: [String: AnyObject] = [
            "data" : [
                "id": "3"
            ]
        ]
        
        let mapper = Mapper<Media>()
        let media: Media! = mapper.map(JSON)
        
        XCTAssertNotNil(media)
        
        let JSONFromMedia = mapper.toJSON(media)
        let mediaFromJSON: Media! = mapper.map(JSONFromMedia)

        XCTAssertNotNil(mediaFromJSON)
    }
    
    func testBasicMappingFromJSON(){
        let JSON: [String: AnyObject] = [
            "data" : [
                "id": "3"
            ]
        ]
        
        let mapper = Mapper<Media>()
        let media: Media! = mapper.map(JSON)
        
        let JSONFromMedia = mapper.toJSON(media)
        let mediaFromJSON: Media! = mapper.map(JSONFromMedia)
        
        XCTAssertEqual(media.id, mediaFromJSON.id)
    }
    
    func testMediaMapsUserJSON(){
        let JSON: [String: AnyObject] = [
            "data" : [
                "user" : [
                    "username" : "KevinS",
                    "full_name" : "Kevin",
                    "id" : "2",
                    "profile_picture" : "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg"
                ]
            ]
        ]
        
        let mediaMapper = Mapper<Media>()
        let media: Media! = mediaMapper.map(JSON)
        let mediaUser: User! = media.user!
        
        let userMapper = Mapper<User>()
        let user: User! = userMapper.map(JSON)

        
        XCTAssertEqual(mediaUser, user)
        
    }
    
    func testMediaGetsCorrectUser(){
        let JSON: [String: AnyObject] = [
            "data" : [
                "users_in_photo" : [
                    "user" : [
                        "username" : "wrongUsername",
                        "full_name" : "wrongFullname",
                        "id" : "wrongId",
                        "profile_picture" : "wrongProfilePicture",
                    ]
                ],
                
                "user" : [
                    "username" : "rightUsername",
                    "full_name" : "rightFullname",
                    "id" : "rightId",
                    "profile_picture" : "rightProfilePicture"
                ]
            ]
        ]
        
        let mapper = Mapper<Media>()
        let media: Media! = mapper.map(JSON)
        
        let JSONFromMedia = mapper.toJSON(media)
        let mediaFromJSON: Media! = mapper.map(JSONFromMedia)
        
    

    }
}
