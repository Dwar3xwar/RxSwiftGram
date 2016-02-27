//
//  Response+Extensions.swift
//  RxSwiftGram
//
//  Created by Eric Huang on 1/26/16.
//  Copyright © 2016 Eric Huang. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift

extension Response {
    func mapInstagramData() throws -> [AnyObject] {
        do {
            let JSON = try mapJSON()
            return JSON["data"] as! [AnyObject]
        } catch {
            throw Error.Underlying(error)
        }
    }
}

extension Response {
    func mapInstagramData<T: Mappable>() throws -> [T] {
        guard let objects = Mapper<T>().mapArray(try mapInstagramData()) else {
            throw Error.JSONMapping(self)
        }
        return objects
    }
    
}

extension ObservableType where E == Response {
    /// Maps data received from the signal into a Array of the data object from the Instagram API. If the conversion fails, the signal errors.
    func mapInstagramData() -> Observable<[AnyObject]> {
        return flatMap { response -> Observable<[AnyObject]> in
            return Observable.just(try response.mapInstagramData())
        }
    }
}

public extension ObservableType where E == Response  {
    func mapInstagramDataArray<T:Mappable>(type: T.Type) -> Observable<[T]> {
        return observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .flatMap { response -> Observable<[T]> in
                return Observable.just(try response.mapInstagramData())
            }
    }
}