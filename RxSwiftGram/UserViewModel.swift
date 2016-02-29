//
//  UserViewModel.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/29/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation

class UserViewModel: NSObject {
    var username: String?
    var id: String?
    var profilePictureURL: NSURL?
    
    init(user: User) {
        username = user.username
        id = user.id
        profilePictureURL = user.profilePicture
    }
}