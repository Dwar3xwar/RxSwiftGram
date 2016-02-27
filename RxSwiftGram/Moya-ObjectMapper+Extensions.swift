import Foundation
import Moya
import ObjectMapper
import RxSwift

extension Response {
    /// Maps Instagram data recieved as Array
    func mapInstagramDataArray() throws -> [AnyObject] {
        do {
            let JSON = try mapJSON()
            return JSON["data"] as! [AnyObject]
        } catch {
            throw Error.Underlying(error)
        }
    }
    
    /// Maps Instagram data recieved as JSON.
    func mapInstagramData() throws -> AnyObject {
        do {
            let JSON = try mapJSON()
            return JSON.valueForKey("data")!
        } catch {
            throw Error.Underlying(error)
        }
    }
}

extension Response {
    
    /// Maps Instagram data received from the signal into an array of objects which implement the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapInstagramDataArray<T: Mappable>() throws -> [T] {
        guard let objects = Mapper<T>().mapArray(try mapInstagramDataArray()) else {
            throw Error.JSONMapping(self)
        }
        return objects
    }
    
    /// Maps Instagram data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapInstagramDataObject<T: Mappable>() throws -> T {
        guard let object = Mapper<T>().map(try mapInstagramData()) else {
            throw Error.JSONMapping(self)
        }
        return object
    }
}

extension ObservableType where E == Response {
    
    /// Maps data received from the signal into a Array of the data object from the Instagram API. If the conversion fails, the signal errors.
    func mapInstagramData() -> Observable<[AnyObject]> {
        return flatMap { response -> Observable<[AnyObject]> in
            return Observable.just(try response.mapInstagramDataArray())
        }
    }
}

extension ObservableType where E == Response  {
    
    /// Maps Instagram data received from the signal into an array of objects (on the default Background thread)
    /// which implement the Mappable protocol and returns the result back on the MainScheduler
    /// If the conversion fails, the signal errors.
    /// Used when expecting an array of JSON such as list of user feed or popular media
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
    /// Used when expecting an single of JSON such as list of user profile or a single media 
    func mapInstagramDataObject<T:Mappable>(type: T.Type) -> Observable<T> {
        return observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .flatMap { response -> Observable<T> in
                return Observable.just(try response.mapInstagramDataObject())
            }
            .observeOn(MainScheduler.instance)
    }
}