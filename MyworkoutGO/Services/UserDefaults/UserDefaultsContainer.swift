//
//  UserDefaultsContainer.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 24/09/2020.
//

import Foundation

///  MARK: UserDefaultsContainer
/// Container to handle getting or settings value inside
/// user defaults to set in UserDefaultsServcie class.
///
class UserDefaultsContainer {

  /// Handle User Defaults access keys.
  ///
  private struct Key {
    static let isLoggedIn = "isLoggedIn"
  }

  init() {
    // Initialize with default value at application start if none has been saved.
    UserDefaults.standard.register(defaults: [Key.isLoggedIn: "false"])
  }
}

extension UserDefaultsContainer: UserDefaultsProtocol {

  var isLoggedIn: Bool {
    get {
      return UserDefaults.standard.bool(forKey: Key.isLoggedIn)
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: Key.isLoggedIn)
    }
  }
}
