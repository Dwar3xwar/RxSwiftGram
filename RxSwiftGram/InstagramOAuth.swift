//
//  InstagramOAuth.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/24/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation

///Ouath Provider 
struct InstagramOAuth {
    static let sharedProvider = InstagramOAuth()
    
    func signRequest(request: NSURLRequest, completion: (request: NSURLRequest) -> Void) {
        if let unsignedRequestString = request.URL?.absoluteString {
            
            let signedRequestString = unsignedRequestString + "?access_token=\(AppSetup.sharedState.accessToken)"
            let signedRequestURL = NSURL(string: signedRequestString)
            let signedRequest = NSURLRequest(URL: signedRequestURL!)
            
            completion(request: signedRequest)
        }
        
    }
}