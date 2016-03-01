# RxSwiftGram
Educational App using RxSwift and MVVM to clone the popular app, Instagram.


## MVVM Architecture
The architecture I used for this app is heavily inspired by [Ediolon](https://github.com/artsy/eidolon). 

Great resources for learning MVVM: 
  - [MVVM in Swift](http://artsy.github.io/blog/2015/09/24/mvvm-in-swift/)
  - [Introduction to MVVM](https://www.objc.io/issues/13-architecture/mvvm/)
  
## RxSwift
Why? Cause Functional Reactive Programming is great. To elaborate, it changes the way you think about programming. Instead of 
worrying about how data affects the state of your application, you focus on how the application handles the flow of data. Confused?
Don't worry its hard to wrap your head around the first time.

Great resources for learning RxSwift:
  - [RxSwift Repository](https://github.com/ReactiveX/RxSwift)
  - [RxSwift Basics](http://www.thedroidsonroids.com/blog/ios/rxswift-by-examples-1-the-basics/)
  
## Instagram API
RxSwiftGram uses [Moya](https://github.com/Moya/Moya) for API Interaction and [MoyaObjectMapper](https://github.com/ivanbruel/Moya-ObjectMapper) for JSON Mapping.

[Instagram API Documentation](https://www.instagram.com/developer/deprecated/)

**NOTE**: This app uses a deprecated version of the Instagram API. Instagram will no longer support the API starting June 2016. The new API will not support the features 
of this application. Currently, it is not possible to register a new client for the old API so please do not spam the Instagram API :grin:.

## Current Features
  - Gets latest posts from user feed
  - Gets photos of current most popular posts
  - Search for Instagram users

## Getting Started
The app will prompt the user to login to their own Instagram account. If you do not have one, make one from the official app.




