//
//  AuthRequest.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import Foundation
import Combine

//  MARK: AuthRequest
/// MyworkoutGo network requests for authentification.
///
/// Auth requests being made within this application are being
/// set here.
///
final class AuthRequest<Resource> where Resource: Codable { }

// MARK: - Requests
extension AuthRequest: AuthRequestProtocol {
  func signUp(_ credentials: SignUpCredentials) -> AnyPublisher<User, NetworkError> {

    let user = User(email: credentials.email,
                    password: credentials.password,
                    gender: credentials.gender)

    return Just(user)
      .delay(for: .seconds(1), scheduler: DispatchQueue.main)
      .mapError { _ -> NetworkError in }
      .eraseToAnyPublisher()
  }

  func logIn(_ credentials: LogInCredentials) -> AnyPublisher<User, NetworkError> {

    let user = User(email: credentials.email,
                    password: credentials.password,
                    gender: .male)

    return Just(user)
      .delay(for: .seconds(1), scheduler: DispatchQueue.main)
      .mapError { _ -> NetworkError in }
      .eraseToAnyPublisher()
  }

  func fetchAccounts() -> AnyPublisher<[String], Never> {

    let users = ["registered@email.com"]

    return Just(users)
      .delay(for: .seconds(1), scheduler: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
