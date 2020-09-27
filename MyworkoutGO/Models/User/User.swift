//
//  User.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

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

  init(id: UUID = UUID(),
       email: String = String(),
       password: String = String(),
       gender: Gender = .unknow) {
    self.id = id
    self.email = email
    self.password = password
    self.gender = gender
  }
}
