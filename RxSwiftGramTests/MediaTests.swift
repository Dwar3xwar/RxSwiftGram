import Foundation
import XCTest
import ObjectMapper

@testable import RxSwiftGram

class MediaTest: XCTestCase {
    
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
                "id": "3",
                "type": "image"
            ]
        ]
        
        let mapper = Mapper<Media>()
        let media: Media! = mapper.map(JSON)
        
        print(media)
        XCTAssertEqual(media.id, "3")
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
        let media = mediaMapper.map(JSON)

        XCTAssertEqual(media?.user?.username, "KevinS")
        XCTAssertEqual(media?.user?.fullName, "Kevin")
        XCTAssertEqual(media?.user?.id, "2")
        XCTAssertEqual(media?.user?.profilePicture, "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg")
        
    }
    
    func testMediaTypeIsImage(){
        let imageJSON: [String: AnyObject] = [
            "data" : [
                "type": "image"
            ]
        ]
        
        let mediaMapper = Mapper<Media>()
        let imageMedia = mediaMapper.map(imageJSON)
        
        XCTAssertEqual(imageMedia?.type, .Image)
    }
    
    func testMediaTypeIsVideo(){
        let videoJSON: [String: AnyObject] = [
            "data" : [
                "type": "video"
            ]
        ]
        
        let mediaMapper = Mapper<Media>()
        let videoMedia = mediaMapper.map(videoJSON)
        
        XCTAssertEqual(videoMedia?.type, .Video)
    }
}
