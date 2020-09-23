//
//  LogInCredentials.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 23/09/2020.
//

import Foundation

//  MARK: LogInCredentials
/// User log in needed credentials.
///
/// The values needed are the email and password.
///
struct LogInCredentials: Codable {

  let email: String
  let password: String
}
