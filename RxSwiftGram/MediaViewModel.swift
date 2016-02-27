//
//  MediaViewModel.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/26/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation

class MediaViewModel {
    
    var id: String?
    var type: MediaType?
    var user: User?
    
    init(media: Media) {
        id = media.id
        type = media.type
        user = media.user
    }
}