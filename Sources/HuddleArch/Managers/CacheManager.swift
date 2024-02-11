//
//  CacheManager.swift
//  Pland
//
//  Created by William Vabrinskas on 10/28/21.
//

import Foundation

enum CacheAction {
  case delete, add, update(huddle: Huddle)
}

@MainActor
protocol CacheMainActor: AnyObject {
  associatedtype CacheObject: AnyObject
  associatedtype CacheKey: AnyObject
  
  var cache : NSCache<CacheKey, CacheObject> { get set }
  
  func getFromCache<T>(key: CacheKey) -> T?
  func addToCache(key: CacheKey, object: CacheObject?)
  func deleteFromCache(key: CacheKey)
}

extension CacheMainActor {
  public func getFromCache<T>(key: CacheKey) -> T? {
    if let objectFromCache = self.cache.object(forKey: key) as? T {
      return objectFromCache
    }
    
    return nil
  }
  
  public func addToCache(key: CacheKey, object: CacheObject?) {
    
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


protocol CacheActor: Actor {
  associatedtype CacheObject: AnyObject
  associatedtype CacheKey: AnyObject
  
  var cache : NSCache<CacheKey, CacheObject> { get set }
  
  func getFromCache<T>(key: CacheKey) -> T?
  func addToCache(key: CacheKey, object: CacheObject?)
  func deleteFromCache(key: CacheKey)
}

extension CacheActor {
  public func getFromCache<T>(key: CacheKey) -> T? {
    if let objectFromCache = cache.object(forKey: key) as? T {
      return objectFromCache
    }
    
    return nil
  }
  
  public func addToCache(key: CacheKey, object: CacheObject?) {
    
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


protocol CacheManager: AnyObject {
  associatedtype CacheObject: AnyObject
  associatedtype CacheKey: AnyObject
  
  var cache : NSCache<CacheKey, CacheObject> { get set }
  
  func getFromCache<T>(key: CacheKey) -> T?
  func addToCache(key: CacheKey, object: CacheObject?) 
  func deleteFromCache(key: CacheKey)
}

extension CacheManager {
  public func getFromCache<T>(key: CacheKey) -> T? {
    if let objectFromCache = self.cache.object(forKey: key) as? T {
      return objectFromCache
    }
    
    return nil
  }
  
  public func addToCache(key: CacheKey, object: CacheObject?) {
    
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

extension String {
  var ns: NSString {
    NSString(string: self)
  }
}
