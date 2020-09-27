//
//  UserData.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 27/09/2020.
//

import Foundation

//  MARK: UserData
/// JSON root of the user data coming from the api and
/// set as Public to hide password.
///
final class UserData: UserDataProtocol, ObservableObject, Codable {

  @Published var token: String
  @Published var user: UserPublic

  init(token: String, user: UserPublic) {
    self.token = token
    self.user = user
  }
}
