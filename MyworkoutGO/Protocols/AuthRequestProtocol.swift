//
//  AuthRequestProtocol.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import Foundation

protocol AuthRequestProtocol {

  /// Type to be retrieve or send with the URL call.
  associatedtype Resource

  /// Parameter when calling AuthRequest that
  /// set the full url path of the API request.
  ///
  var resourceURL: NetworkEndpoint { get set }

  /// Main URLSession framework for API request.
  ///
  /// This parameter is not needed to be fullfilled in
  /// the AuthRequest class as it is automatically set
  /// in the init() and is only used for URLSession mock.
  ///
  var resourceSession: URLSession { get set }
}
