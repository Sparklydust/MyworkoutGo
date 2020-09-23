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
/// set here and authSession is set to be used for unit test
/// only and to mock URLSession.
///
final class AuthRequest<Resource> where Resource: Codable { }

// MARK: - Requests
extension AuthRequest: AuthRequestProtocol {
  func signUp(_ credentials: SignUpCredentials) -> AnyPublisher<User, Never> {

    let user = User(email: credentials.email,
                    password: credentials.password,
                    gender: credentials.gender)

    return Just(user)
      .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

  func logIn(_ credentials: LogInCredentials) -> AnyPublisher<User, Never> {

    let user = User(email: credentials.email,
                    password: credentials.password,
                    gender: .male)

    return Just(user)
      .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
