import Foundation
import XCTest
import ObjectMapper

@testable import RxSwiftGram

class CommentTest: XCTest {
    func testBasicMappingFromJSON(){
        let JSON: [String: AnyObject] = [
            "data" : [
                "id": "3",
                "text": "BURN ALL THE BOOKS",
                "created_time" : "2312534",
                "from": [
                    "username" : "KevinS",
                    "full_name" : "Kevin",
                    "id" : "2",
                    "profile_picture" : "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg"
                ]
            ]
        ]

    }
}