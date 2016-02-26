//
//  UserTests.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/26/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper

@testable import RxSwiftGram

class UserTests: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testMappedFromJSON(){
        
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
        
        let mapper = Mapper<User>()
        let user: User! = mapper.map(JSON)
        
        XCTAssertNotNil(user)
        
        let JSONFromUser = mapper.toJSON(user)
        let userFromJSON: User! = mapper.map(JSONFromUser)
        
        print(user)
        
        XCTAssertNotNil(userFromJSON)
        
        XCTAssertEqual(user.id, userFromJSON.id)
        XCTAssertEqual(user.username, userFromJSON.username)
        XCTAssertEqual(user.fullName, userFromJSON.fullName)
        XCTAssertEqual(user.profilePicture, userFromJSON.profilePicture)
    }
}