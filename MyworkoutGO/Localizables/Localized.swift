//
//  Localized.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: Localized
/// Enumeration of localized Strings for translations.
///
/// This enum is the link between all the code String
/// declarations and the Localizable.strings keys to
/// perform the translations.
///
/// ```
/// Localized.enterEmail // example of use
/// ```
enum Localized {
  typealias LSK = LocalizedStringKey
}

// MARK: - Translation Keys
extension Localized {

  // MARK: Logo
  static var logoName: LSK { return "logoName" }
  static var enterEmail: LSK { return "enterEmail" }
  static var enterPassword: LSK { return "enterPassword" }
  static var fillSignUpForm: LSK { return "fillSignUpForm" }

  // MARK: Placeholders
  static var emailAddress: LSK { return "emailAddress" }
  static var password: LSK { return "password" }

  // MARK: Buttons
  static var next: LSK { return "next" }
  static var cancel: LSK { return "cancel" }
  static var logIn: LSK { return "logIn" }
  static var signUp: LSK { return "signUp" }
  static var female: LSK { return "female" }
  static var male: LSK { return "male" }
}
