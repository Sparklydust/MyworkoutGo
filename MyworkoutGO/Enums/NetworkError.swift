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
  case wrongPassword

  var errorDescription: LocalizedStringKey {
    switch self {
    case .emailAlreadyUsed:
      return Localized.emailAlreadyUsed
    case .wrongPassword:
      return Localized.wrongPassword
    }
  }
}
