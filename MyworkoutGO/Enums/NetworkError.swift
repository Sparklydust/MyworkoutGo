//
//  NetworkError.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 23/09/2020.
//

import SwiftUI

//  MARK: NetworkError
/// Handle API call response with errors.
///
enum NetworkError: Error {

  case emailAlreadyUsed
  case wrongCredentials

  var errorDescription: LocalizedStringKey {
    switch self {
    case .emailAlreadyUsed:
      return Localized.emailAlreadyUsed
    case .wrongCredentials:
      return Localized.wrongCredentials
    }
  }
}
