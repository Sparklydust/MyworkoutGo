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
  let signUpQueue = DispatchQueue(
    label: "signUpQueue", qos: .userInitiated,
    attributes: .concurrent, autoreleaseFrequency: .inherit, target: .main)
  let logInQueue = DispatchQueue(
    label: "logInQueue", qos: .userInitiated,
    attributes: .concurrent, autoreleaseFrequency: .inherit, target: .main)
  let fetchAccountsQueue = DispatchQueue(
    label: "fetchAccountsQueue", qos: .userInitiated,
    attributes: .concurrent, autoreleaseFrequency: .inherit, target: .main)
}

extension AuthRequest {
  func signUp(_ credentials: SignUpCredentials) -> AnyPublisher<UserData, NetworkError> {

    let url = NetworkEndpoint.signUp.url
    let body = signUpBody(with: credentials)
    let urlRequest = signUpRequestSetup(url: url, body: body)

    return authSession
      .dataTaskPublisher(for: urlRequest)
      .receive(on: signUpQueue)
      .map(\.data)
      .decode(
        type: UserData.self,
        decoder: JSONDecoder())
      .mapError { error -> NetworkError in
        self.switchNetworkError(error) }
      .eraseToAnyPublisher()
  }

  func logIn(_ credentials: LogInCredentials) -> AnyPublisher<UserData, NetworkError> {

    let url = NetworkEndpoint.logIn.url
    let body = logInBody(with: credentials)
    let urlRequest = logInRequestSetup(url: url, body: body)

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

  func fetchAccounts() -> AnyPublisher<[UserPublic], NetworkError> {

    let url = NetworkEndpoint.accounts.url

    return authSession
      .dataTaskPublisher(for: url)
      .receive(on: fetchAccountsQueue)
      .map(\.data)
      .decode(
        type: [UserPublic].self,
        decoder: JSONDecoder())
      .mapError { error -> NetworkError in
        self.switchNetworkError(error) }
      .eraseToAnyPublisher()
  }
}

// MARK: - Request Bodies
extension AuthRequest {
  /// Sign up body for http request.
  ///
  func signUpBody(with credentials: SignUpCredentials) -> [String: Any] {
    [
      "email": credentials.email,
      "password": credentials.password,
      "gender": credentials.gender == .male ? 0 : 1,
    ] as [String : Any]
  }

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
  /// Setup the necessary parameters to make a sign up
  /// network request during authentification.
  ///
  /// - Parameters:
  ///     - url: the corresponding log in url
  ///     - body: The needed json body for the request
  /// - Returns: URL method request with settings
  ///
  func signUpRequestSetup(url: URL,
                          body: [String: Any]) -> URLRequest {

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = HTTPMethodString.POST.rawValue
    urlRequest.setValue("application/json",
                        forHTTPHeaderField: "Content-Type")
    urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
    return urlRequest
  }

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
  func logInRequestSetup(url: URL, body: String) -> URLRequest {
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
