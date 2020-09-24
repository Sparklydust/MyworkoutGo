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
}
