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

  // UI levers
  @Published var isLoggedIn = false
  @Published var showLogInSignUp = false
  @Published var showLogIn = false
  @Published var showSignUp = true
  @Published var femaleSelected = false
  @Published var maleSelected = false

  // UI labels
  @Published var logoLabel = Localized.enterEmail
  @Published var nextButtonName = Localized.next

  // User inputs
  @Published var email = String()
  @Published var password = String()
}
