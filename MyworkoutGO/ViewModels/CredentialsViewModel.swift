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
final class CredentialsViewModel: CredentialsProtocol, ObservableObject {

  private var subscriptions = Set<AnyCancellable>()

  // UI levers
  @Published var isLoggedIn = UserDefaultsService.shared.isLoggedIn
  @Published var showLogInSignUp = false
  @Published var showLogIn = false
  @Published var showSignUp = false
  @Published var femaleSelected = false
  @Published var maleSelected = false
  @Published var disableButton = false
  @Published var isLoading = false
  @Published var showCredentialsAlert = false

  // UI labels
  @Published var logoLabel = Localized.enterEmail
  @Published var nextButtonName = Localized.next

  // User inputs
  @Published var email = UserDefaultsService.shared.userEmail
  @Published var gender = UserDefaultsService.shared.userGender
  @Published var password = String()
}

// MARK: - Publishers/Subscribers
extension CredentialsViewModel {
  func readUserInput() {
    readUserEmailInput()
    readUserLogInInput()
    readUserSignUpInput()
  }
}

// MARK: - Buttons actions
extension CredentialsViewModel {
  func cancelButtonAction() {
    goBackToStartingView()
    resetLabels()
  }

  func nextButtonAction() {
    checkIfUserEmailExist()
    LogInUserCredentials()
    SignUpUserCredentials()
  }

  func logOutAction() {
    cancelButtonAction()
    userLoggedOutSaved()
  }

  func goBackToStartingView() {
    showLogInSignUp = false
    showSignUp = false
    showLogIn = false
  }

  func resetLabels() {
    nextButtonName = Localized.next
    logoLabel = Localized.enterEmail
    email = String()
    password = String()
    femaleSelected = false
    maleSelected = false
  }
}

// MARK: - Email Input
extension CredentialsViewModel {
  func readUserEmailInput() {
    $showLogInSignUp
      .filter { !$0 }
      .combineLatest($email)
      .map { [weak self] _, email -> Bool in
        guard let self = self else { return true }
        return self.isValid(email) }
      .assign(to: \.disableButton, on: self)
      .store(in: &subscriptions)
  }

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

  func continueCredentialsFlow(value: [String]) {
    for v in value {
      if v == email {
        showLogIn = true
        showSignUp = false
        logoLabel = Localized.enterPassword
        nextButtonName = Localized.logIn
      }
      else {
        showSignUp = true
        showLogIn = false
        logoLabel = Localized.fillSignUpForm
        nextButtonName = Localized.signUp
      }
    }
  }

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
  func readUserLogInInput() {
    $showLogIn
      .filter { $0 }
      .combineLatest($email, $password)
      .map { _, email, password -> Bool in
        guard email.isValidEmailFormat(),
              password != String() else { return true }
        return false }
      .assign(to: \.disableButton, on: self)
      .store(in: &subscriptions)
  }

  func LogInUserCredentials() {
    guard showLogIn else { return }
    isLoading = true

    let credentials = LogInCredentials(email: email,
                                       password: password)

    AuthRequest.shared.logIn(credentials)
      .sink(
        receiveCompletion: { [weak self] _ in
          guard let self = self else { return }
          self.isLoading = false },
        receiveValue: { [weak self] value in
          guard let self = self else { return }
          self.performAPILogInActions(on: credentials, with: value) })
      .store(in: &subscriptions)
  }

  func performAPILogInActions(on credentials: LogInCredentials, with value: User) {
    if credentials.email == value.email
        && credentials.password == value.password {
      userCredentialsSaved(value)
    }
    else {
      showCredentialsAlert = true
    }
  }
}

// MARK: - Sign Up
extension CredentialsViewModel {
  func readUserSignUpInput() {
    $showSignUp
      .filter { $0 }
      .combineLatest($email, $password, $gender)
      .map { _, email, password, gender -> Bool in
        guard email.isValidEmailFormat(),
              password != String(),
              gender != .unknow else { return true }
        return false }
      .assign(to: \.disableButton, on: self)
      .store(in: &subscriptions)
  }

  func SignUpUserCredentials() {
    guard showSignUp else { return }
    isLoading = true

    let credentials = SignUpCredentials(email: email,
                                        password: password,
                                        gender: gender)

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

  func performAPISignUpActions(on credentials: SignUpCredentials, with value: User) {
    if credentials.email != "registered@email.com" &&
        gender != .unknow {
      userCredentialsSaved(value)
    }
    else {
      showCredentialsAlert = true
    }
  }

  func genderSelected(_ gender: Gender) {
    switch gender {
    case .female:
      femaleGenderSelected()
      return
    case .male:
      maleGenderSelected()
      return
    default:
      self.gender = .unknow
    }
  }

  func femaleGenderSelected() {
    femaleSelected.toggle()
    maleSelected = false
    if femaleSelected {
      gender = .female
    }
    else {
      gender = .unknow
    }
  }

  func maleGenderSelected() {
    maleSelected.toggle()
    femaleSelected = false
    if maleSelected {
      gender = .male
    }
    else {
      gender = .unknow
    }
  }
}

// MARK: - UserDefaults
extension CredentialsViewModel {
  func userCredentialsSaved(_ value: User) {
    saveInUserDefaults(value)
    retrieveUserDefaultsValues()
  }

  func saveInUserDefaults(_ value: User) {
    UserDefaultsService.shared.isLoggedIn = true
    UserDefaultsService.shared.userEmail = value.email
    UserDefaultsService.shared.userGender = value.gender
  }

  func retrieveUserDefaultsValues() {
    isLoggedIn = UserDefaultsService.shared.isLoggedIn
    email = UserDefaultsService.shared.userEmail
    gender = UserDefaultsService.shared.userGender
  }
}

// MARK: - Profile View
extension CredentialsViewModel {
  func userLoggedOutSaved() {
    resetUserDefaultsValues()
    resetUserDefaultsAssociatedVariables()
  }

  func resetUserDefaultsValues() {
    UserDefaultsService.shared.isLoggedIn = false
    UserDefaultsService.shared.userEmail = String()
    UserDefaultsService.shared.userGender = .unknow
  }

  func resetUserDefaultsAssociatedVariables() {
    isLoggedIn = UserDefaultsService.shared.isLoggedIn
    email = UserDefaultsService.shared.userEmail
    gender = UserDefaultsService.shared.userGender
  }
}

// MARK: - Alerts
extension CredentialsViewModel {
  func credentialsAlertView() -> Alert {
    switch true {
    case showLogIn:
      return Alert(title: Text(Localized.error),
                   message: Text(Localized.wrongCredentials),
                   dismissButton: .default(Text(Localized.ok)) {
                    self.password = String()
                   })
    case showSignUp:
      return Alert(title: Text(Localized.error),
                   message: Text(Localized.emailAlreadyUsed),
                   dismissButton: .default(Text(Localized.ok)) {
                    self.email = String()
                    self.password = String()
                   })
    default:
      return Alert(title: Text(Localized.error),
                   message: Text(Localized.internalError),
                   dismissButton: .default(Text(Localized.ok)))
    }
  }
}
