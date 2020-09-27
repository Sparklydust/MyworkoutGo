//
//  CredentialsViewModel.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 23/09/2020.
//

import SwiftUI
import Combine

//  MARK: CredentialsViewModel
/// Handle the credentials logic when user authenticate.
///
final class CredentialsViewModel: ObservableObject {

  private var subscriptions = Set<AnyCancellable>()

  // User
  @ObservedObject var user = User()
  @Published var profilePicture = Image.profile

  // UI levers
  @Published var isLoggedIn = false
  @Published var showLogInSignUp = false
  @Published var showLogIn = false
  @Published var showSignUp = false
  @Published var femaleSelected = false
  @Published var maleSelected = false
  @Published var disableButton = false
  @Published var isLoading = false
  @Published var showCredentialsAlert = false

  // UI labels
  @Published var logoTitle = Localized.appName
  @Published var logoLabel = Localized.enterEmail
  @Published var nextButtonName = Localized.next
}

// MARK: - Publishers/Subscribers
extension CredentialsViewModel {
  /// Reading reactivily the user inputs in text fields shown on
  /// different credentials screen until user logged in or sign up.
  ///
  func readUserInput() {
    readUserEmailInput()
    readUserLogInInput()
    readUserSignUpInput()
  }
}

// MARK: - Buttons actions
extension CredentialsViewModel {
  /// Action triggered when the cancel button is tapped.
  ///
  /// Send user to credentials starting screen with an empty
  /// text field.
  ///
  func cancelButtonAction() {
    goBackToStartingView()
    resetLabels()
  }

  /// Action triggered when the next button is tapped.
  ///
  /// User is sent to the dedicated credentials screen weither is
  /// alredy registered in the application or not. This button is
  /// then used for user to log in or sign up.
  ///
  func nextButtonAction() {
    checkIfUserEmailExist()
    LogInUserCredentials()
    SignUpUserCredentials()
  }

  /// Action when the user log out of the application.
  ///
  /// All user credetials are deleted from the app and user is sent
  /// back to the startup view.
  ///
  func logOutAction() {
    cancelButtonAction()
    userLoggedOutSaved()
  }

  /// Trigger actions to reset views to the starting credentials one.
  ///
  func goBackToStartingView() {
    showLogInSignUp = false
    showSignUp = false
    showLogIn = false
  }

  /// Trigger actions to reset labels to the starting credentials view.
  ///
  func resetLabels() {
    nextButtonName = Localized.next
    logoTitle = Localized.appName
    logoLabel = Localized.enterEmail
    user.email = String()
    user.password = String()
    femaleSelected = false
    maleSelected = false
  }
}

// MARK: - Email Input
extension CredentialsViewModel {
  /// Read user email text field input.
  ///
  func readUserEmailInput() {
    $showLogInSignUp
      .filter { !$0 }
      .combineLatest(user.$email)
      .map { [weak self] _, email -> Bool in
        guard let self = self else { return true }
        return self.isValid(email) }
      .assign(to: \.disableButton, on: self)
      .store(in: &subscriptions)
  }

  /// Trigger a network call to retrieve all user accounts.
  ///
  /// Verification weither the user email is registered in our data base.
  /// If it does, we trigger the log in flow otherwise, the sign up one.
  ///
  func checkIfUserEmailExist() {
    guard !showSignUp && !showLogIn else { return }
    showLogInSignUp = true
    isLoading = true

    AuthRequest.shared.fetchAccounts()
      .sink(
        receiveCompletion: { [weak self] _ in
          guard let self = self else { return }
          self.isLoading = false },
        receiveValue: { [weak self] value in
          guard let self = self else { return }
          self.continueCredentialsFlow(value: value) })
      .store(in: &subscriptions)
  }

  /// Verification weither the user email is registered in our data base.
  ///
  /// If it does, we trigger the log in flow otherwise, the sign up one.
  ///
  /// - Parameter value: users email accounts from data base.
  ///
  func continueCredentialsFlow(value: [String]) {
    for v in value {
      if v == user.email {
        setupLogInView()
      }
      else {
        setupSignUpView()
      }
    }
  }

  /// Trigger action to setup log in view and change labels accordingly.
  ///
  func setupLogInView() {
    showLogIn = true
    showSignUp = false
    logoTitle = Localized.welcomeBack
    logoLabel = Localized.enterPassword
    nextButtonName = Localized.logIn
  }

  /// Trigger action to setup sign up view and change labels accordingly.
  ///
  func setupSignUpView() {
    showSignUp = true
    showLogIn = false
    logoTitle = Localized.createAccount
    logoLabel = Localized.fillSignUpForm
    nextButtonName = Localized.signUp
  }

  /// Check if the email is in a valid format or not.
  ///
  /// - Parameter email: user email from text field.
  /// - Returns: true or false
  ///
  func isValid(_ email: String) -> Bool {
    switch email {
    case _ where email.isValidEmailFormat():
      return false
    default:
      self.cancelButtonAction()
      return true }
  }
}

// MARK: - Log In
extension CredentialsViewModel {
  /// Read user email and password text field inputs.
  ///
  func readUserLogInInput() {
    $showLogIn
      .filter { $0 }
      .combineLatest(user.$email, user.$password)
      .map { _, email, password -> Bool in
        guard email.isValidEmailFormat(),
              password != String() else { return true }
        return false }
      .assign(to: \.disableButton, on: self)
      .store(in: &subscriptions)
  }

  /// Log in user if account already exist.
  ///
  /// Trigger API call to data base and log in user if he/she has
  /// an account. Trigger an Alert otherwise.
  ///
  func LogInUserCredentials() {
    guard showLogIn else { return }
    isLoading = true

    let credentials = LogInCredentials(email: user.email,
                                       password: user.password)

    AuthRequest.shared.logIn(credentials)
      .sink(
        receiveCompletion: { print($0) },
        receiveValue: { print($0.token) })
      .store(in: &subscriptions)
  }

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
  func performAPILogInActions(on credentials: LogInCredentials, with value: User) {
    if credentials.email == value.email
        && credentials.password == value.password {
      userCredentialsSaved(value)
      profilePicture = .nilsOlav
    }
    else {
      showCredentialsAlert = true
    }
  }
}

// MARK: - Sign Up
extension CredentialsViewModel {
  /// Read user email, password text field and gender inputs.
  ///
  func readUserSignUpInput() {
    $showSignUp
      .filter { $0 }
      .combineLatest(user.$email, user.$password, user.$gender)
      .map { _, email, password, gender -> Bool in
        guard email.isValidEmailFormat(),
              password != String(),
              gender != .unknow else { return true }
        return false }
      .assign(to: \.disableButton, on: self)
      .store(in: &subscriptions)
  }

  /// Sign up user if account has never been created before.
  ///
  /// Trigger API call to data base and sign up user if he/she has never
  /// created an account before. Trigger an alert otherwise.
  ///
  func SignUpUserCredentials() {
    guard showSignUp else { return }
    isLoading = true

    let credentials = SignUpCredentials(email: user.email,
                                        password: user.password,
                                        gender: user.gender)

    AuthRequest.shared.signUp(credentials)
      .sink(
        receiveCompletion: { [weak self] _ in
          guard let self = self else { return }
          self.isLoading = false },
        receiveValue: { [weak self] value in
          guard let self = self else { return }
          self.performAPISignUpActions(on: credentials, with: value) })
      .store(in: &subscriptions)
  }

  /// Performing actions on value coming from the API.
  ///
  /// If user create a new account with an unknown email, sign up actions are
  /// trigger and user can access the app. If wrong credentials are entered,
  /// an Alert is triggered letting the user know about it.
  /// Normally, with real Network calls, error are handled in the
  /// receiveCompletion block. As it is a fake call, I handled them in
  /// the receivedValue instead.
  ///
  /// - Parameters:
  ///     - credentials: User log in credentials filled in the app.
  ///     - value: User data comming from the back end.
  ///
  func performAPISignUpActions(on credentials: SignUpCredentials, with value: User) {
    if credentials.email != "registered@email.com"
        && user.gender != .unknow {
      userCredentialsSaved(value)
      profilePicture = .profile
    }
    else {
      showCredentialsAlert = true
    }
  }

  /// Selection of the gender by user on the sign up screen.
  ///
  func genderSelected(_ gender: Gender) {
    switch gender {
    case .female:
      femaleGenderSelected()
      return
    case .male:
      maleGenderSelected()
      return
    default:
      self.user.gender = .unknow
    }
  }

  /// Actions triggered when user has selected the female gender in the sign up flow.
  ///
  func femaleGenderSelected() {
    femaleSelected.toggle()
    maleSelected = false
    if femaleSelected {
      user.gender = .female
    }
    else {
      user.gender = .unknow
    }
  }

  /// Actions triggered when user has selected the male gender in the sign up flow.
  ///
  func maleGenderSelected() {
    maleSelected.toggle()
    femaleSelected = false
    if maleSelected {
      user.gender = .male
    }
    else {
      user.gender = .unknow
    }
  }
}

// MARK: - UserDefaults
extension CredentialsViewModel {
  /// Fetch saved application state for the user to reconnect
  /// with the same settings.
  ///
  func fetchUserDefaults() {
      user.email = UserDefaultsService.shared.userEmail
      user.gender = UserDefaultsService.shared.userGender
      isLoggedIn = UserDefaultsService.shared.isLoggedIn
  }

  /// Save values when user enter the app to user defaults and
  /// set Publisher to this values.
  ///
  /// Used to open the app without the credentials view when user alreday
  /// logged in once by saving the logged in or sign up credentials.
  ///
  ///  - Parameters:
  ///     - value: User data comming from the back end.
  ///
  func userCredentialsSaved(_ value: User) {
    saveInUserDefaults(value)
    retrieveUserDefaultsValues()
  }

  /// Save values when user logged in to user defaults.
  ///
  /// Value retrieved in Profile view are saved here.
  ///
  ///  - Parameters:
  ///     - value: User data comming from the back end.
  ///
  func saveInUserDefaults(_ value: User) {
    UserDefaultsService.shared.isLoggedIn = true
    UserDefaultsService.shared.userEmail = value.email
    UserDefaultsService.shared.userGender = value.gender
  }

  /// Retrieving the values saved in UserDefaults and set it to Publishers variables.
  ///
  func retrieveUserDefaultsValues() {
    isLoggedIn = UserDefaultsService.shared.isLoggedIn
    user.email = UserDefaultsService.shared.userEmail
    user.gender = UserDefaultsService.shared.userGender
  }

  /// User logged out from the Profile tab view and sent back to startup view.
  ///
  func userLoggedOutSaved() {
    resetUserDefaultsValues()
    resetUserDefaultsAssociatedVariables()
  }

  /// Resetting UserDefaults by deleting values when user logged out.
  ///
  func resetUserDefaultsValues() {
    UserDefaultsService.shared.isLoggedIn = false
    UserDefaultsService.shared.userEmail = String()
    UserDefaultsService.shared.userGender = .unknow
  }

  /// Resetting UserDefaults associated variables when user logged out.
  ///
  func resetUserDefaultsAssociatedVariables() {
    isLoggedIn = UserDefaultsService.shared.isLoggedIn
    user.email = UserDefaultsService.shared.userEmail
    user.gender = UserDefaultsService.shared.userGender
  }
}

// MARK: - Alerts
extension CredentialsViewModel {
  /// Show alert with classic dismiss button if user credentials are invalid.
  ///
  /// Depending on weither the user log in or sign up, a proper alert is shown
  /// to the user
  ///
  /// - Returns: SwiftUI alert on CredentialsView
  ///
  func credentialsAlertView() -> Alert {
    switch true {
    case showLogIn:
      return logInAlert()
    case showSignUp:
      return signUpAlert()
    default:
      return internalAlert()
    }
  }

  /// Alert shown if user enter wrong password at log in.
  ///
  func logInAlert() -> Alert {
    Alert(title: Text(Localized.error),
                 message: Text(Localized.wrongCredentials),
                 dismissButton: .default(Text(Localized.ok)) {
                  self.user.password = String()
                 })
  }

  /// Alert shown if user enter same email as existing user
  /// in sign up.
  ///
  func signUpAlert() -> Alert {
    Alert(title: Text(Localized.error),
                 message: Text(Localized.emailAlreadyUsed),
                 dismissButton: .default(Text(Localized.ok)) {
                  self.user.email = String()
                  self.user.password = String()
                 })
  }

  /// Alert in case none of any alert triggers, potentially a bug
  /// if triggered.
  ///
  func internalAlert() -> Alert {
    Alert(title: Text(Localized.error),
                 message: Text(Localized.internalError),
                 dismissButton: .default(Text(Localized.ok)))
  }
}
