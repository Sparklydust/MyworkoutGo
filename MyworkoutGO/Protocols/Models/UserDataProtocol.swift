//
//  UserDataProtocol.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 27/09/2020.
//

import Foundation

protocol UserDataProtocol {

  /// Server side token key
  var token: String { get }

  /// User define as Public coming from the api.
  var user: UserPublic { get set }
}
