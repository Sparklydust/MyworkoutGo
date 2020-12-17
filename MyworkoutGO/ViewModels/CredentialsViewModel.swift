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
  var isLoggedIn = CurrentValueSubject<Bool, Never>(false)
  var showLogInSignUp = CurrentValueSubject<Bool, Never>(false)
  var showLogIn = CurrentValueSubject<Bool, Never>(false)
  var showSignUp = CurrentValueSubject<Bool, Never>(false)

  @Published var femaleSelected = false
  @Published var maleSelected = false
  @Published var disableButton = false
  @Published var isLoading = false
  @Published var showCredentialsAlert = false

  // UI labels
  @Published var logoTitle = Localized.appName
  @Published var logoLabel = Localized.enterEmail
  @Published var nextButtonName = Localized.next

  init() {
    readUserInput()
  }
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
    userLoggedOutSaved()
    cancelButtonAction()
  }

  /// Trigger actions to reset views to the starting credentials one.
  ///
  func goBackToStartingView() {
    showLogInSignUp.send(false)
    showSignUp.send(false)
    showLogIn.send(false)
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
    showLogInSignUp
      .filter { !$0 }
      .combineLatest(user.$email)
      .map { [weak self] _, email -> Bool in
        guard let self = self else { return true }
        return self.isValid(email) }
      .removeDuplicates()
      .assign(to: &$disableButton)
  }

  /// Trigger a network call to retrieve all user accounts.
  ///
  /// Verification weither the user email is registered in our data base.
  /// If it does, we trigger the log in flow otherwise, the sign up one.
  ///
  func checkIfUserEmailExist() {
    guard !showSignUp.value && !showLogIn.value else { return }
    isLoading = true

    AuthRequest.shared.fetchAccounts()
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self = self else { return }
          self.handle(completion) },
        receiveValue: { [weak self] data in
          guard let self = self else { return }
          self.continueCredentialsFlow(data: data) })
      .store(in: &subscriptions)
  }

  /// Verification weither the user email is registered in our data base.
  ///
  /// If it does, we trigger the log in flow otherwise, the sign up one.
  ///
  /// - Parameter value: users email accounts from data base.
  ///
  func continueCredentialsFlow(data: [UserPublic]) {
    DispatchQueue.main.async {
      for i in data {
        if i.email == self.user.email {
          self.setupLogInView()
          break
        }
        else {
          self.setupSignUpView()
        }
      }
    }
  }

  /// Trigger action to setup log in view and change labels accordingly.
  ///
  func setupLogInView() {
    showLogIn.send(true)
    showSignUp.send(false)
    showLogInSignUp.send(true)
    logoTitle = Localized.welcomeBack
    logoLabel = Localized.enterPassword
    nextButtonName = Localized.logIn
  }

  /// Trigger action to setup sign up view and change labels accordingly.
  ///
  func setupSignUpView() {
    showLogIn.send(false)
    showSignUp.send(true)
    showLogInSignUp.send(true)
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
    showLogIn
      .filter { $0 }
      .combineLatest(user.$email, user.$password)
      .map { _, email, password -> Bool in
        guard email.isValidEmailFormat(),
              password != String() else { return true }
        return false }
      .removeDuplicates()
      .assign(to: &$disableButton)
  }

  /// Log in user if account already exist.
  ///
  /// Trigger API call to data base and log in user if he/she has
  /// an account. Trigger an Alert otherwise.
  ///
  func LogInUserCredentials() {
    guard showLogIn.value else { return }
    isLoading = true

    let credentials = LogInCredentials(email: user.email,
                                       password: user.password)

    AuthRequest.shared.logIn(credentials)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self = self else { return }
          self.handle(completion) },
        receiveValue: { [weak self] data in
          guard let self = self else { return }
          self.performAPILogInActions(with: data) })
      .store(in: &subscriptions)
  }

  /// Performing actions on value coming from the API.
  ///
  /// - Parameters:
  ///     - data: user data coming from the api as public
  ///
  func performAPILogInActions(with data: UserData) {
    profilePicture = .nilsOlav
    isLoggedIn.send(true)
    DispatchQueue.main.async {
      self.saveUserCredentials(data)
    }
  }
}

// MARK: - Sign Up
extension CredentialsViewModel {
  /// Read user email, password text field and gender inputs.
  ///
  func readUserSignUpInput() {
    showSignUp
      .filter { $0 }
      .combineLatest(user.$email, user.$password, user.$gender)
      .map { _, email, password, gender -> Bool in
        guard email.isValidEmailFormat(),
              password != String(),
              gender != .unknow else { return true }
        return false }
      .removeDuplicates()
      .assign(to: &$disableButton)
  }

  /// Sign up user if account has never been created before.
  ///
  /// Trigger API call to data base and sign up user if he/she has never
  /// created an account before. Trigger an alert otherwise.
  ///
  func SignUpUserCredentials() {
    guard showSignUp.value else { return }
    isLoading = true

    let credentials = SignUpCredentials(email: user.email,
                                        password: user.password,
                                        gender: user.gender)

    AuthRequest.shared.signUp(credentials)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self = self else { return }
          self.handle(completion) },
        receiveValue: { [weak self] data in
          guard let self = self else { return }
          self.performAPISignUpActions(on: data)})
      .store(in: &subscriptions)
  }

  /// Performing actions on value coming from the API.
  ///
  /// If user create a new account with an unknown email, sign up actions are
  /// trigger and user can access the app. If wrong credentials are entered,
  /// an Alert is triggered letting the user know about it.
  ///
  /// - Parameters:
  ///     - data: data coming from the api call.
  ///
  func performAPISignUpActions(on data: UserData) {
    profilePicture = .profile
    isLoggedIn.send(true)
    DispatchQueue.main.async {
      self.saveUserCredentials(data)
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
  func fetchUserDefaultsValues() {
    user.email = UserDefaultsService.shared.userEmail
    user.gender = UserDefaultsService.shared.userGender
    isLoggedIn.value = UserDefaultsService.shared.isLoggedIn
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
  func saveUserCredentials(_ data: UserData) {
    saveInUserDefaults(data)
    setUserDefaultsValues(data)
  }

  /// Save values when user logged in to user defaults.
  ///
  /// Value retrieved in Profile view are saved here.
  ///
  ///  - Parameters:
  ///     - value: User data comming from the back end.
  ///
  func saveInUserDefaults(_ data: UserData) {
    UserDefaultsService.shared.isLoggedIn = true
    UserDefaultsService.shared.userToken = data.token
    UserDefaultsService.shared.userEmail = data.user.email
    UserDefaultsService.shared.userGender = data.user.gender == 0 ? .male : .female
  }

  /// Set the values saved in UserDefaults to Publishers variables.
  ///
  func setUserDefaultsValues(_ data: UserData) {
    user.email = data.user.email
    user.gender = data.user.gender == 0 ? .male : .female
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
    DispatchQueue.main.async {
      UserDefaultsService.shared.isLoggedIn = false
      UserDefaultsService.shared.userEmail = String()
      UserDefaultsService.shared.userGender = .unknow
    }
  }

  /// Resetting UserDefaults associated variables when user logged out.
  ///
  func resetUserDefaultsAssociatedVariables() {
    isLoggedIn.send(false)
    user.email = String()
    user.gender = .unknow
  }
}

// MARK: - Alerts
extension CredentialsViewModel {
  /// Handle the completion coming from a network request with a finished
  /// action and failure set as NetworkError.
  ///
  func handle(_ completion: Subscribers.Completion<NetworkError>) {
    switch completion {
    case .failure(let error):
      isLoading = false
      switch error {
      case .emailAlreadyUsed:
        return
      case .wrongCredentials:
        showCredentialsAlert = true
        return
      }
    case .finished:
      isLoading = false
      return
    }
  }
  /// Show alert with classic dismiss button if user credentials are invalid.
  ///
  /// Depending on weither the user log in or sign up, a proper alert is shown
  /// to the user
  ///
  /// - Returns: SwiftUI alert on CredentialsView
  ///
  func credentialsAlertView() -> Alert {
    switch true {
    case showLogIn.value:
      return logInAlert()
    case showSignUp.value:
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
