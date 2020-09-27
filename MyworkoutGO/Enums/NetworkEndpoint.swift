//
//  NetworkEndpoint.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 27/09/2020.
//

import Foundation

//  MARK: NetworkEndpoint
/// MyworkoutGO network url endpoints enumaration.
///
/// All urls are handled by this enum with a base url
/// and endpoints for earch network call.
///
enum NetworkEndpoint {

  /// Base api url.
  ///
  static let baseURL = URL(string: "http://localhost:8080/api/users/")!

  case logIn
  case signUp
  case account
  case accounts

  /// Fetching MyworkoutGO endpoint.
  ///
  var url: URL {
    switch self {
    case .logIn:
      return NetworkEndpoint.baseURL.appendingPathComponent("login")
    case .signUp:
      return NetworkEndpoint.baseURL.appendingPathComponent("signup")
    case .account:
      return NetworkEndpoint.baseURL.appendingPathComponent("account")
    case .accounts:
      return NetworkEndpoint.baseURL.appendingPathComponent("accounts")
    }
  }
}
