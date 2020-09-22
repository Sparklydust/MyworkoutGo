//
//  NetworkEndpoint.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
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
  static let baseURL = URL(string: "https://www.myworkout.com")!

  case logIn
  case signUp
  case accounts
  
  /// Fetching MyworkoutGO endpoint.
  ///
  var url: URL {
    switch self {
    case .logIn:
      return NetworkEndpoint.baseURL.appendingPathComponent("login")
    case .signUp:
      return NetworkEndpoint.baseURL.appendingPathComponent("signup")
    case .accounts:
      return NetworkEndpoint.baseURL.appendingPathComponent("accounts")
    }
  }
}
