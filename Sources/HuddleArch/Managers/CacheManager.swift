//
//  CacheManager.swift
//  Pland
//
//  Created by William Vabrinskas on 10/28/21.
//

import Foundation

enum CacheAction {
  case delete, add
}

@MainActor
public protocol CacheMainActor: AnyObject {
  associatedtype CacheObject: AnyObject
  associatedtype CacheKey: AnyObject
  
  var cache : NSCache<CacheKey, CacheObject> { get set }
  
  func getFromCache<T>(key: CacheKey) -> T?
  func addToCache(key: CacheKey, object: CacheObject?)
  func deleteFromCache(key: CacheKey)
}

public extension CacheMainActor {
  func getFromCache<T>(key: CacheKey) -> T? {
    if let objectFromCache = self.cache.object(forKey: key) as? T {
      return objectFromCache
    }
    
    return nil
  }
  
  func addToCache(key: CacheKey, object: CacheObject?) {
    
    guard getFromCache(key: key) == nil else {
      return
    }
    
    if let object = object {
      self.cache.setObject(object, forKey: key)
    }
    
  }
  
  public func deleteFromCache(key: CacheKey) {
    self.cache.removeObject(forKey: key)
  }
}


public protocol CacheActor: Actor {
  associatedtype CacheObject: AnyObject
  associatedtype CacheKey: AnyObject
  
  var cache : NSCache<CacheKey, CacheObject> { get set }
  
  func getFromCache<T>(key: CacheKey) -> T?
  func addToCache(key: CacheKey, object: CacheObject?)
  func deleteFromCache(key: CacheKey)
}

public extension CacheActor {
  func getFromCache<T>(key: CacheKey) -> T? {
    if let objectFromCache = cache.object(forKey: key) as? T {
      return objectFromCache
    }
    
    return nil
  }
  
  func addToCache(key: CacheKey, object: CacheObject?) {
    
    guard getFromCache(key: key) == nil else {
      return
    }
    
    if let object = object {
      cache.setObject(object, forKey: key)
    }
    
  }
  
  public func deleteFromCache(key: CacheKey) {
    cache.removeObject(forKey: key)
  }
}


public protocol CacheManager: AnyObject {
  associatedtype CacheObject: AnyObject
  associatedtype CacheKey: AnyObject
  
  var cache : NSCache<CacheKey, CacheObject> { get set }
  
  func getFromCache<T>(key: CacheKey) -> T?
  func addToCache(key: CacheKey, object: CacheObject?) 
  func deleteFromCache(key: CacheKey)
}

public extension CacheManager {
  func getFromCache<T>(key: CacheKey) -> T? {
    if let objectFromCache = self.cache.object(forKey: key) as? T {
      return objectFromCache
    }
    
    return nil
  }
  
  func addToCache(key: CacheKey, object: CacheObject?) {
    
    guard getFromCache(key: key) == nil else {
      return
    }
    
    if let object = object {
      self.cache.setObject(object, forKey: key)
    }
    
  }
  
  public func deleteFromCache(key: CacheKey) {
    self.cache.removeObject(forKey: key)
  }
}

public extension String {
  var ns: NSString {
    NSString(string: self)
  }
}
