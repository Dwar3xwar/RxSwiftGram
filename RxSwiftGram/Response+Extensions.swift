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
    
    /// Maps Instagram data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapInstagramDataArray<T: Mappable>() throws -> [T] {
        guard let objects = Mapper<T>().mapArray(try mapInstagramData()) else {
            throw Error.JSONMapping(self)
        }
        return objects
    }
    
    /// Maps Instagram data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapInstagramDataObject<T: Mappable>() throws -> T {
        guard let object = Mapper<T>().map(try mapJSON()) else {
            throw Error.JSONMapping(self)
        }
        return object
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

extension ObservableType where E == Response  {
    
    /// Maps Instagram data received from the signal into an array of objects (on the default Background thread)
    /// which implement the Mappable protocol and returns the result back on the MainScheduler
    /// If the conversion fails, the signal errors.
    func mapInstagramDataArray<T:Mappable>(type: T.Type) -> Observable<[T]> {
        return observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .flatMap { response -> Observable<[T]> in
                return Observable.just(try response.mapInstagramDataArray())
            }
            .observeOn(MainScheduler.instance)
    }
    
    
    /// Maps Instagram data received from the signal into an object (on the default Background thread) which
    /// implements the Mappable protocol and returns the result back on the MainScheduler.
    /// If the conversion fails, the signal errors.
    func mapInstagramDataObject<T:Mappable>(type: T.Type) -> Observable<T> {
        return observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .flatMap { response -> Observable<T> in
                return Observable.just(try response.mapInstagramDataObject())
            }
            .observeOn(MainScheduler.instance)
    }
}