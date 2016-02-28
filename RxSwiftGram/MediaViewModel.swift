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
    var caption: String?
    var type: MediaType?
    var user: User?
    
    var standardResolutionURL: NSURL?
    var lowResolutionURL: NSURL?
    var thumbnailURL: NSURL?
    
    init(media: Media) {
        id = media.id
        caption = media.caption
        type = media.type
        user = media.user
        
        
        standardResolutionURL = media.standardResolutionURL
        lowResolutionURL = media.lowResolutionURL
        thumbnailURL = media.thumbnailURL
    }
}