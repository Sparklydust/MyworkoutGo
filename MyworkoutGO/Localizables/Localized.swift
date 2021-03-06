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

  // MARK: Tab bar
  static var profile: LSK { return "profile" }

  // MARK: Logo
  static var appName: LSK { return "appName" }
  static var welcomeBack: LSK { return "welcomeBack" }
  static var createAccount: LSK { return "createAccount" }
  static var enterEmail: LSK { return "enterEmail" }
  static var enterPassword: LSK { return "enterPassword" }
  static var fillSignUpForm: LSK { return "fillSignUpForm" }

  // MARK: Placeholders
  static var emailAddress: LSK { return "emailAddress" }
  static var password: LSK { return "password" }
  static var email: LSK { return "email" }
  static var gender: LSK { return "gender" }

  // MARK: Buttons
  static var next: LSK { return "next" }
  static var cancel: LSK { return "cancel" }
  static var logIn: LSK { return "logIn" }
  static var signUp: LSK { return "signUp" }
  static var female: LSK { return "female" }
  static var male: LSK { return "male" }
  static var logOut: LSK { return "logOut" }
  static var ok: LSK { return "ok"}

  // MARK: Error title
  static var error: LSK { return "error" }

  // MARK: Error message
  static var emailAlreadyUsed: LSK { return "emailAlreadyUsed" }
  static var wrongCredentials: LSK { return "wrongCredentials" }
  static var internalError: LSK { return "internalError" }
}
