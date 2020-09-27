//
//  UserDefaultsProtocol.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 24/09/2020.
//

import Foundation

protocol UserDefaultsProtocol {

  /// Tracking if the user already logged in
  /// to hide or not CredentialsView.
  ///
  var isLoggedIn: Bool { get set }

  /// Tracking user email when logged in.
  ///
  var userEmail: String { get set }

  /// Tracking user gender when logged in.
  ///
  var userGender: Gender? { get set }

  /// User token coming from the api call.
  ///
  var userToken: String { get set }
}
