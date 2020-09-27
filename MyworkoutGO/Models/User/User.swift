//
//  User.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI


final class UserData: ObservableObject, Codable {

  @Published var token: String
  @Published var user: UserPublic

  init(token: String, user: UserPublic) {
    self.token = token
    self.user = user
  }
}

final class UserPublic: ObservableObject, Codable, Identifiable {

  var id: UUID?

  @Published var email: String
  @Published var gender: Int

  init(email: String = String(),
       gender: Int = 0) {
    self.email = email
    self.gender = gender
  }
}

//  MARK: User
/// MyworkoutGO user definition.
///
/// Defined as .environmentObject(). in MyworkoutGOApp.swift
/// for the user model to be retrieve in all needed files.
/// ```
/// @EnvironmentObject var user: User
/// ```
final class User: UserProtocol, ObservableObject, Codable, Identifiable {

  var id = UUID()

  @Published var email: String
  @Published var password: String
  @Published var gender: Gender

  init(email: String = String(),
       password: String = String(),
       gender: Gender = .unknow) {
    self.email = email
    self.password = password
    self.gender = gender
  }
}
