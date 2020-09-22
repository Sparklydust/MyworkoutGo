//
//  UserProtocol.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

protocol UserProtocol {

  /// Server side primary key.
  var id: UUID { get }

  /// User email address.
  var email: String { get set }

  /// User password for credentials.
  var password: String { get set }

  /// User gender for credentials.
  var gender: Gender { get set }
}
