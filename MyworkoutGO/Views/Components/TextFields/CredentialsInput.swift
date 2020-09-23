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
      VStack {
        TextField(Localized.emailAddress,
                  text: $viewModel.email)
          .textContentType(.emailAddress)
          .padding(.horizontal, 16)

        DividerCredentialsItem()
      }

      if viewModel.showLogInSignUp {
        if viewModel.showLogIn || viewModel.showSignUp {
          VStack {
            SecureField(Localized.password,
                        text: $viewModel.password)
              .textContentType(viewModel.showLogIn
                                ? .password
                                : .newPassword)
              .padding(.horizontal, 16)

            DividerCredentialsItem()
          }
        }
        if viewModel.showSignUp {
          VStack {
            HStack {
              HStack {
                Button(action: {
                  viewModel.femaleSelected.toggle()
                  viewModel.maleSelected = false
                }) {
                  Image(systemName: viewModel.femaleSelected
                          ? "checkmark.circle.fill"
                          : "circle")
                    .foregroundColor(.accentColor)
                }
                Text(Localized.female)
              }
              .padding(.horizontal, 16)

              Spacer()

              HStack {
                Button(action: {
                  viewModel.maleSelected.toggle()
                  viewModel.femaleSelected = false
                }) {
                  Image(systemName: viewModel.maleSelected
                          ? "checkmark.circle.fill"
                          : "circle")
                    .foregroundColor(.purple$)
                }
                Text(Localized.male)
              }
              .padding(.horizontal, 16)

              Spacer()
            }

            DividerCredentialsItem()
          }
        }
      }
    }
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
