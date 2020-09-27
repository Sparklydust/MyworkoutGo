//
//  AuthRequestProtocol.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import Foundation
import Combine

protocol AuthRequestProtocol {

  /// Sign up new user with provided credentials.
  ///
  /// A full user is being retrieve with a valid
  /// email and password.
  ///
  /// - Parameters:
  ///     - credentials: user email, password and gender.
  /// - Returns: <User, Never>
  ///
  func signUp(_ credentials: SignUpCredentials) -> AnyPublisher<UserData, NetworkError>

  /// Log in user to his/her account.
  ///
  /// User with an account can successfully enter
  /// the app with a valid email and password.
  ///
  /// - Parameters:
  ///     - credentials: user email and password.
  /// - Returns: <String, Never>
  ///
  func logIn(_ credentials: LogInCredentials) -> AnyPublisher<UserData, NetworkError>

  /// Fetch all user email accounts.
  ///
  /// Used to verify if email is already in use and trigger log in or
  /// sign up flow depending of the result.
  ///
  /// - Returns: <[String], Never>
  ///
  func fetchAccounts() -> AnyPublisher<[UserPublic], NetworkError>
}
