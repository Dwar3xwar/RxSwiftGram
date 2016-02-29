//
//  InstagramAPI.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/23/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation
import RxSwift
import Moya

let requestClosure = { (endpoint: Endpoint<InstagramAPI>, done: NSURLRequest -> Void) in
    let request = endpoint.urlRequest
    done(request)
    /*InstagramOAuth.sharedProvider.signRequest(request) { request in
        done(request)
    }*/
}

enum InstagramAPI {
    case UserSelf
    case UserFeed
    case UserGet(userId: String)
    case UserSearch(query: String)
    case UserLastLiked
    
    case MediaGet(id: String)
    case MediaExplore
}

extension InstagramAPI: TargetType {
    var baseURL: NSURL { return NSURL(string: "https://api.instagram.com/v1")! }
    
    var path: String {
        switch self {
        case .UserSelf:
            return "/users/self/"
        case.UserFeed:
            return "/users/self/feed"
        case .UserGet:
            return "/users/"
        case .UserLastLiked:
            return "/users/self/media/recent/"
        case .UserSearch:
            return "/users/search"
            
        case .MediaGet(let id):
            return "/media/\(id)"
        case .MediaExplore:
            return "/media/popular"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case let .UserSearch(query):
            return ["q": query,
                    "access_token": AppSetup.sharedState.accessToken]
        default:
            return ["access_token": AppSetup.sharedState.accessToken]
        }
    }
    
    var sampleData: NSData {
        switch self {
        default:
            return "a".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}