//
//  UserPublic.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 27/09/2020.
//

import Foundation

//  MARK: UserPublic
/// Definition of the user as Public to retrieve only
/// needed data from the api.
///
final class UserPublic: UserPublicProtocol, ObservableObject, Codable, Identifiable {

  var id: UUID?

  @Published var email: String
  @Published var gender: Int

  init(email: String = String(),
       gender: Int = 0) {
    self.email = email
    self.gender = gender
  }
}
