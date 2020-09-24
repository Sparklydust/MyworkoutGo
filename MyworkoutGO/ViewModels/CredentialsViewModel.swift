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

  @EnvironmentObject var user: User

  // UI levers
  @Published var isLoggedIn = UserDefaultsService.shared.isLoggedIn
  @Published var showLogInSignUp = false
  @Published var showLogIn = false
  @Published var showSignUp = false
  @Published var femaleSelected = false
  @Published var maleSelected = false
  @Published var disableButton = false
  @Published var isLoading = false

  // UI labels
  @Published var logoLabel = Localized.enterEmail
  @Published var nextButtonName = Localized.next

  // User inputs
  @Published var email = String()
  @Published var password = String()
  @Published var gender = Gender.unknow
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

// MARK: Email Input
extension CredentialsViewModel {
  func readUserInput() {
    readUserEmailInput()
    readUserLogInInput()
  }

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

    AuthRequest<User>().fetchAccounts()
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

// MARK: - Log In Input
extension CredentialsViewModel {
  func readUserLogInInput() {
    $showLogIn
      .filter { $0 }
      .combineLatest($email, $password)
      .map { _, email, password -> Bool in
        guard email.isValidEmailFormat(),
              password != String() else { return true }
        return false
      }
      .assign(to: \.disableButton, on: self)
      .store(in: &subscriptions)
  }

  func LogInUserCredentials() {
    guard showLogIn else { return }
    isLoading = true

    let credentials = LogInCredentials(email: email, password: password)

    AuthRequest<User>().logIn(credentials)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self = self else { return }
          self.isLoading = false },
        receiveValue: { [weak self] value in
          guard let self = self else { return }
          self.userLoggedInSaved()
        })
      .store(in: &subscriptions)
  }

  func userLoggedInSaved() {
    UserDefaultsService.shared.isLoggedIn = true
    isLoggedIn = UserDefaultsService.shared.isLoggedIn
  }
}

// MARK: Profile View
extension CredentialsViewModel {
  func userLoggedOutSaved() {
    UserDefaultsService.shared.isLoggedIn = false
    isLoggedIn = UserDefaultsService.shared.isLoggedIn
  }
}
