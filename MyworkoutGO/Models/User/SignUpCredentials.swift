//
//  SignUpCredentials.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import Foundation

//  MARK: SignUpCredentials
/// User sign up needed credentials.
///
/// The values needed are the email, password
/// and gender.
///
struct SignUpCredentials: Codable {

  let email: String
  let password: String
  let gender: Gender
}
