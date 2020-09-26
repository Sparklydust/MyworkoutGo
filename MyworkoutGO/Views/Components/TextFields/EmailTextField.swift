//
//  EmailTextField.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 25/09/2020.
//

import SwiftUI

//  MARK: EmailTextField
/// Email text field of the credentials flow.
///
struct EmailTextField: View {

  @EnvironmentObject var viewModel: CredentialsViewModel

  var body: some View {
    VStack {
      TextField(Localized.emailAddress,
                text: $viewModel.user.email)
        .textContentType(.emailAddress)
        .autocapitalization(.none)
        .padding(.horizontal, 16)

      DividerCredentialsItem()
    }
  }
}

// MARK: - Previews
struct EmailTextField_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      EmailTextField()

      EmailTextField()
        .preferredColorScheme(.dark)
    }
  }
}
