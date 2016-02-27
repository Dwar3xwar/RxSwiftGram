import Foundation
import XCTest
import ObjectMapper

@testable import RxSwiftGram

class MediaTest: XCTestCase {
    
    func testMediaIsNotNil(){
        let JSON: [String: AnyObject] = [
            "id": "3",
            "user" : [
                "username" : "KevinS",
                "full_name" : "Kevin",
                "id" : "2",
                "profile_picture" : "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg"
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
            "id": "3",
            "type": "image",
            "user" : [
                "username" : "KevinS",
                "full_name" : "Kevin",
                "id" : "2",
                "profile_picture" : "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg"
            ]
        ]
    
        
        let mapper = Mapper<Media>()
        let media: Media! = mapper.map(JSON)
        
        print(media)
        XCTAssertEqual(media.id, "3")
    }
    
    func testMediaMapsUserJSON(){
        let JSON: [String: AnyObject] = [
            "user" : [
                "username" : "KevinS",
                "full_name" : "Kevin",
                "id" : "2",
                "profile_picture" : "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg"
            ]
        ]

        
        let mediaMapper = Mapper<Media>()
        let media = mediaMapper.map(JSON)

        XCTAssertEqual(media?.user?.username, "KevinS")
        XCTAssertEqual(media?.user?.fullName, "Kevin")
        XCTAssertEqual(media?.user?.id, "2")
        XCTAssertEqual(media?.user?.profilePicture, "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg")
        
    }
    
    func testMediaGetsURLS() {
        let JSON: [String: AnyObject] = [
            "images" : [
                "low_resolution" : [
                    "url" : "http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg",
                    "width" : 306,
                    "height" : 306,
                ],
                "thumbnail" : [
                    "url" : "http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg",
                    "width" : 150,
                    "height" : 150,
                ],
                "standard_resolution" : [
                    "url" : "http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_7.jpg",
                    "width" : 612,
                    "height" : 612,
                ]
            ]
        ]
        
        let mediaMapper = Mapper<Media>()
        let media = mediaMapper.map(JSON)
        
        XCTAssertEqual(media?.thumbnailURL, NSURL(string: "http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_5.jpg"))
        XCTAssertEqual(media?.lowResolutionURL, NSURL(string: "http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_6.jpg"))
        XCTAssertEqual(media?.standardResolutionURL, NSURL(string: "http://distillery.s3.amazonaws.com/media/2010/07/16/4de37e03aa4b4372843a7eb33fa41cad_7.jpg"))
    }
    
    func testMediaTypeIsImage(){
        let imageJSON: [String: AnyObject] = [
                "type": "image"
        ]
        
        let mediaMapper = Mapper<Media>()
        let imageMedia = mediaMapper.map(imageJSON)
        
        XCTAssertEqual(imageMedia?.type, .Image)
    }
    
    func testMediaTypeIsVideo(){
        let videoJSON: [String: AnyObject] = [
                "type": "video"
        ]
        
        let mediaMapper = Mapper<Media>()
        let videoMedia = mediaMapper.map(videoJSON)
        
        XCTAssertEqual(videoMedia?.type, .Video)
    }
}
