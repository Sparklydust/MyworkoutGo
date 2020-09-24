//
//  CredentialsProtocol.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 24/09/2020.
//

import SwiftUI

protocol CredentialsProtocol {

  /// Check either or not the user is logged in.
  ///
  var isLoggedIn: Bool { get set }

  /// Showing or not the view when user wants to log in
  /// or sign up.
  ///
  var showLogInSignUp: Bool { get set }

  /// Show or not the log in flow views.
  ///
  var showLogIn: Bool { get set }

  /// Show or not the sign up views.
  ///
  var showSignUp: Bool { get set }

  /// Trigger or not if female gender is selected
  ///
  var femaleSelected: Bool { get set }

  /// Trigger or not if male gender is selected
  ///
  var maleSelected: Bool { get set }

  /// Disable button if user did not entered the right
  /// information in populated text field.
  ///
  var disableButton: Bool { get set }

  /// Label showing text to user under the logo with explanation
  /// regarding his/her expecting behavior when onboarding.
  ///
  var logoLabel: LocalizedStringKey { get set }

  /// Button name to perform the next action weither the user
  /// log in or sign up during the onboarding flow.
  ///
  var nextButtonName: LocalizedStringKey { get set }

  /// User entered email address from the text field.
  ///
  var email: String { get set }

  /// User entered password from the text field.
  ///
  var password: String { get set }

  /// Action triggered when the cancel button is tapped.
  ///
  /// Send user to credentials starting screen with an empty
  /// text field.
  ///
  func cancelButtonAction()

  /// Action triggered when the next button is tapped.
  ///
  /// User is sent to the dedicated credentials screen weither is
  /// alredy registered in the application or not. This button is
  /// then used for user to log in or sign up.
  ///
  func nextButtonAction()

  /// Reading reactivily the user inputs in text fields shown on
  /// different credentials screen until user logged in or sign up.
  ///
  func readUserInput()

  /// Read user email text field input.
  ///
  func readUserEmailInput()
}
