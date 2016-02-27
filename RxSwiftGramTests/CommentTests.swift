import Foundation
import XCTest
import ObjectMapper

@testable import RxSwiftGram

class CommentTests: XCTestCase {
    
    func testBasicMappingFromJSON(){
        let JSON: [String: AnyObject] = [
            "id": "3",
            "text": "BURN ALL THE BOOKS",
            "created_time" : "2312534",
        ]
        
        let mapper = Mapper<Comment>()
        let comment: Comment! = mapper.map(JSON)
        
        XCTAssertEqual(comment.id, "3")
        XCTAssertEqual(comment.text, "BURN ALL THE BOOKS")
        XCTAssertEqual(comment.createdTime, "2312534")
    }
    
    func testCommentMapsUserJSON(){
        let JSON: [String: AnyObject] = [
            "from" : [
                "username" : "KevinS",
                "full_name" : "Kevin",
                "id" : "2",
                "profile_picture" : "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg"
            ]
        ]
        
        
        let mapper = Mapper<Comment>()
        let comment: Comment! = mapper.map(JSON)
        
        XCTAssertEqual(comment.from?.username, "KevinS")
        XCTAssertEqual(comment.from?.fullName, "Kevin")
        XCTAssertEqual(comment.from?.id, "2")
        XCTAssertEqual(comment.from?.profilePicture, "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg")
        
        
        
    }
    
}