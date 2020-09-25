//
//  PasswordTextField.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 25/09/2020.
//

import SwiftUI

//  MARK: PasswordTextField
/// Secure text field to enter password or new
/// password depending on the credentials flow.
///
struct PasswordTextField: View {

  @EnvironmentObject var viewModel: CredentialsViewModel

  var body: some View {
    VStack {
      SecureField(Localized.password,
                  text: $viewModel.password)
        .textContentType(viewModel.showLogIn
                          ? .password
                          : .newPassword)
        .autocapitalization(.none)
        .padding(.horizontal, 16)

      DividerCredentialsItem()
    }
  }
}

// MARK: - Previews
struct PasswordTextField_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      PasswordTextField()

      PasswordTextField()
        .preferredColorScheme(.dark)
    }
  }
}
