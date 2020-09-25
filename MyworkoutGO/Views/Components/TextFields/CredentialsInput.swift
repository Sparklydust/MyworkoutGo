//
//  CredentialsInput.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: CredentialsInput
/// Text fields for user to enter his/her
/// credentials.
///
/// Depending on user credentials process, email,
/// password and/or gender appears with animations.
///
struct CredentialsInput: View {

  @EnvironmentObject var viewModel: CredentialsViewModel

  var body: some View {
    VStack(spacing: 32) {

      EmailTextField()

      if viewModel.showLogInSignUp {
        if viewModel.showLogIn || viewModel.showSignUp {
          PasswordTextField()
        }

        if viewModel.showSignUp {
          GenderTextField()
        }
      }
    }
    .environmentObject(viewModel)
    .padding(.bottom, 24)
  }
}

// MARK: - Previews
struct CredentialsInput_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CredentialsInput()

      CredentialsInput()
        .preferredColorScheme(.dark)
    }
  }
}
