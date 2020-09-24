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

  /// Trigger the UIActivityIndicator set in SwiftUI views.
  ///
  var isLoading: Bool { get set }

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

  /// Action when the user log out of the application.
  ///
  /// All user credetials are deleted from the app and user is sent
  /// back to the startup view.
  ///
  func logOutAction()

  /// Trigger actions to reset views to the starting credentials one.
  ///
  func goBackToStartingView()

  /// Trigger actions to reset labels to the starting credentials view.
  ///
  func resetLabels()

  /// Reading reactivily the user inputs in text fields shown on
  /// different credentials screen until user logged in or sign up.
  ///
  func readUserInput()

  /// Read user email text field input.
  ///
  func readUserEmailInput()

  /// Trigger a network call to retrieve all user accounts.
  ///
  /// Verification weither the user email is registered in our data base.
  /// If it does, we trigger the log in flow otherwise, the sign up one.
  ///
  func checkIfUserEmailExist()

  /// Verification weither the user email is registered in our data base.
  ///
  /// If it does, we trigger the log in flow otherwise, the sign up one.
  ///
  /// - Parameter value: users email accounts from data base.
  ///
  func continueCredentialsFlow(value: [String])

  /// Check if the email is in a valid format or not.
  ///
  /// - Parameter email: user email from text field.
  /// - Returns: true or false
  ///
  func isValid(_ email: String) -> Bool

  /// Read user email and password text field inputs.
  ///
  func readUserLogInInput()

  /// Log in user if account already exist.
  ///
  /// Trigger API call to data base and log in user if he/her has
  /// an account. Trigger an Alert otherwise.
  ///
  func LogInUserCredentials()

  /// Performing actions on value coming from the API.
  ///
  /// If user exist in data base, log in actions are trigger and user can
  /// access the app. If wrong credentials are entered, an Alert is triggered
  /// letting the user know about it.
  /// Normally, with real Network calls, error are handled in the
  /// receiveCompletion block. As it is a fake call, I handled them in
  /// the receivedValue instead.
  ///
  /// - Parameters:
  ///     - credentials: User log in credentials filled in the app.
  ///     - value: User data comming from the back end.
  ///
  func performAPIActions(on credentials: LogInCredentials, with value: User)

  /// Save values when user logged in to user defaults and set Publisher to this values.
  ///
  /// Used to open the app without the credentials view when user alreday
  /// logged in once by saving the logged in credentials.
  ///
  ///  - Parameters:
  ///     - value: User data comming from the back end.
  ///
  func userLoggedInSaved(_ value: User)

  /// Save values when user logged in to user defaults.
  ///
  /// Value retrieved in Profile view are saved here.
  ///
  ///  - Parameters:
  ///     - value: User data comming from the back end.
  ///
  func saveInUserDefaults(_ value: User)

  /// Retrieving the values saved in UserDefaults and set it to Publishers variables.
  ///
  func retrieveUserDefaultsValues()

  /// User logged out from the Profile tab view and sent back to startup view.
  ///
  func userLoggedOutSaved()

  /// Resetting UserDefaults by deleting values when user logged out.
  ///
  func resetUserDefaultsValues()

  /// Resetting UserDefaults associated variables when user logged out.
  func resetUserDefaultsAssociatedVariables()

  /// Show alert with classic dissmiss button if user login credentials are invalid.
  ///
  /// - Returns: SwiftUI alert on CredentialsView.
  func LogInAlertView() -> Alert
}
