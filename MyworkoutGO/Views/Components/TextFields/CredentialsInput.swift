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

  @Binding var showLogInSignUp: Bool

  @State var showLogIn = false
  @State var showSignUp = true
  @State var femaleSelected = false
  @State var maleSelected = false
  @State var email = String()
  @State var password = String()

  var body: some View {
    VStack(spacing: 32) {
      VStack {
        TextField(Localized.emailAddress,
                  text: $email)
          .textContentType(.emailAddress)
          .padding(.horizontal, 16)

        DividerCredentialsItem()
      }

      if showLogInSignUp {
        if showLogIn || showSignUp {
          VStack {
            SecureField(Localized.password,
                        text: $password)
              .textContentType(showLogIn
                                ? .password
                                : .newPassword)
              .padding(.horizontal, 16)

            DividerCredentialsItem()
          }
        }
        if showSignUp {
          VStack {
            HStack {
              HStack {
                Button(action: {
                  femaleSelected.toggle()
                  maleSelected = false
                }) {
                  Image(systemName: femaleSelected
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
                  maleSelected.toggle()
                  femaleSelected = false
                }) {
                  Image(systemName: maleSelected
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
      CredentialsInput(showLogInSignUp: .constant(false))

      CredentialsInput(showLogInSignUp: .constant(true))
        .preferredColorScheme(.dark)
    }
  }
}
