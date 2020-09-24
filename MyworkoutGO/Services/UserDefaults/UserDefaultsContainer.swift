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
    static let userEmail = "userEmail"
    static let userGender = "userGender"
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

  var userEmail: String {
    get {
      return UserDefaults.standard.string(forKey: Key.userEmail) ?? String()
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: Key.userEmail)
    }
  }

  var userGender: Gender? {
    get {
      guard let savedValue = UserDefaults.standard.object(forKey: Key.userGender)
              as? Data else {  return nil }

      let decodedValue = try? JSONDecoder().decode(Gender.self, from: savedValue)
      return decodedValue
    }
    set {
      let encodedValue = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.setValue(encodedValue, forKey: Key.userGender)
    }
  }
}
