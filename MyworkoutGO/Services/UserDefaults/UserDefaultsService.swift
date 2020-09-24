//
//  UserDefaultsService.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 24/09/2020.
//

import Foundation

//  MARK: UserDefaultsService
/// Handles all UserDefaults saving and retrieving saved
/// values actions in source code.
///
final class UserDefaultsService {
  static let shared = UserDefaultsService()

  private var userDefaultsContainer: UserDefaultsProtocol
  init(userDefaultsContainer: UserDefaultsProtocol = UserDefaultsContainer()) {
    self.userDefaultsContainer = userDefaultsContainer
  }
}

extension UserDefaultsService {
  /// Tracking if the user already logged in
  /// to hide or not CredentialsView.
  ///
  var isLoggedIn: Bool {
    get {
      return userDefaultsContainer.isLoggedIn
    }
    set {
      userDefaultsContainer.isLoggedIn = newValue
    }
  }
}
