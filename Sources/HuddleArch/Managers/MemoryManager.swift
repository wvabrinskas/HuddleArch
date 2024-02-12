//
//  MemoryManager.swift
//  Huddle
//
//  Created by William Vabrinskas on 2/16/23.
//

import Foundation

public typealias MemoryManagerKeys = RawRepresentable<String>

public final class MemoryManager {
  public static let shared = MemoryManager()
  private var managing: [AnyHashable: Int] = [:]
  
  public func add(key: any MemoryManagerKeys) {
    guard ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == nil,
          ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil else { return }
    
    managing[key.rawValue, default: 0] += 1
    if managing[key.rawValue, default: 0] > 1 {
      #if DEBUG
      fatalError("There is more than one instance of \(key.rawValue) in memory. Please verify this is correct")
      #endif
    }
  }
  
  public func remove(key: any MemoryManagerKeys) {
    if let keyValue = managing[key.rawValue] {
      managing[key.rawValue] = max(0, keyValue - 1)
    }
  }
}


open class MemoryManagedClass<T: MemoryManagerKeys> {
  private let manager: MemoryManager = .shared
  private let memoryKey: T
  
  deinit {
    manager.remove(key: memoryKey)
  }
  
  public init(memoryKey: T) {
    self.memoryKey = memoryKey
    manager.add(key: memoryKey)
  }
}
