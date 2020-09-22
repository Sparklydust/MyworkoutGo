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

  @State var email = String()

  var body: some View {
    VStack {
      VStack {
        TextField(Localized.emailAddress,
                  text: $email)
          .textContentType(.emailAddress)
          .padding(.horizontal, 16)

        DividerCredentialsItem()
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
