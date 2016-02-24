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

public func url(route: TargetType) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}

let endPointClosure = { (target: InstagramAPI) -> Endpoint<InstagramAPI> in
    let endpoint: Endpoint<InstagramAPI> = Endpoint<InstagramAPI>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    
    switch target {
    default:
        return endpoint.endpointByAddingHTTPHeaderFields(["access_token": AppSetup.sharedState.accessToken])
    }
}

let requestClosure = { (endpoint: Endpoint<InstagramAPI>, done: NSURLRequest -> Void) in
    let request = endpoint.urlRequest
    InstagramOAuth.sharedProvider.signRequest(request) { request in
        done(request)
    }
}

enum InstagramAPI {
    case UserSelf
    case UserGet(userId: String)
    case UserSearch(name: String)
    case UserLastLiked
    
    case MediaGet(mediaId: String)
}

extension InstagramAPI: TargetType {
    var baseURL: NSURL { return NSURL(string: "https://api.instagram.com/v1")! }
    
    var path: String {
        switch self {
        case .UserSelf:
            return "/users/self/"
        case.UserLastLiked:
            return "/users/self/media/recent/"
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
        default:
            return nil
        }
    }
    
    var sampleData: NSData {
        switch self {
        default:
            return "a".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}