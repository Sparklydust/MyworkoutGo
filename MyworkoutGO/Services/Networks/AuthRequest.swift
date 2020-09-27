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
/// set here. The authSession initializer is for testing purposes.
///
final class AuthRequest {
  static let shared = AuthRequest()

  private var authSession: URLSession
  init(authSession: URLSession = URLSession(configuration: .default)) {
    self.authSession = authSession
  }

  // MARK: - Dispatch Queues
  let logInQueue = DispatchQueue(
    label: "logInQueue", qos: .userInitiated,
    attributes: .concurrent, autoreleaseFrequency: .inherit, target: .main)
}

extension AuthRequest {
  func signUp(_ credentials: SignUpCredentials) -> AnyPublisher<User, NetworkError> {

    let user = User(email: credentials.email,
                    password: credentials.password,
                    gender: credentials.gender)

    return Just(user)
      .delay(for: .seconds(1), scheduler: DispatchQueue.main)
      .mapError { _ -> NetworkError in }
      .eraseToAnyPublisher()
  }

  func logIn(_ credentials: LogInCredentials) -> AnyPublisher<UserData, NetworkError> {

    let url = NetworkEndpoint.logIn.url
    let body = logInBody(with: credentials)
    let urlRequest = loginRequestSetup(url: url, body: body)

    return authSession
      .dataTaskPublisher(for: urlRequest)
      .receive(on: logInQueue)
      .map(\.data)
      .decode(
        type: UserData.self,
        decoder: JSONDecoder())
      .mapError { error -> NetworkError in
        self.switchNetworkError(error) }
      .eraseToAnyPublisher()
  }

  func fetchAccounts() -> AnyPublisher<[String], Never> {

    let users = ["registered@email.com"]

    return Just(users)
      .delay(for: .seconds(1), scheduler: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}

// MARK: - Request Bodies
extension AuthRequest {
  /// Log in encoded body for http request.
  ///
  func logInBody(with credentials: LogInCredentials) -> String {
    let body = String(format: "%@:%@", credentials.email, credentials.password)
    guard let bodyData = body.data(using: .utf8) else { return String() }
    let encodedBody = bodyData.base64EncodedString()
    return encodedBody
  }
}

// MARK: URL Requests Setup
extension AuthRequest {
  /// Request settings with url and body.
  ///
  /// Setup the necessary parameters to make the
  /// right network request during authentification.
  ///
  /// - Parameters:
  ///     - url: the corresponding log in url
  ///     - body: The needed json encoded body for the request
  /// - Returns: URL method request with settings
  ///
  func loginRequestSetup(url: URL, body: String) -> URLRequest {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = HTTPMethodString.POST.rawValue
    urlRequest.setValue("Basic \(body)", forHTTPHeaderField: "Authorization")
    return urlRequest
  }
}

// MARK: - Network Error Handler
extension AuthRequest {
  /// Switch statement to handle errors coming from any API call.
  ///
  /// - Parameters:
  ///     - error: map error coming from network call
  /// - Returns: Catched custom NetworkError
  ///
  func switchNetworkError(_ error: Error) -> NetworkError {
    switch error {
    case URLError.Code(rawValue: 401):
      return .emailAlreadyUsed
    default:
      return .wrongCredentials
    }
  }
}
