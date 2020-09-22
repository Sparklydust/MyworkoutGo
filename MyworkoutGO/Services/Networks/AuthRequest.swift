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
/// set here with a resourceURL as full url. ResourceSession
/// is set to be used for unit test only and to mock URLSession.
///
final class AuthRequest<Resource> where Resource: Codable {

  var resourceURL: NetworkEndpoint
  var resourceSession: URLSession

  init(_ resourceURL: NetworkEndpoint,
       resourceSession: URLSession = URLSession(configuration: .default)) {
    self.resourceURL = resourceURL
    self.resourceSession = resourceSession
  }
}

extension AuthRequest: AuthRequestProtocol {
}
