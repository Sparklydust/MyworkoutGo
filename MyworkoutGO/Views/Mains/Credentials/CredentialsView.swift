//
//  CredentialsView.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: CredentialsView
/// View offering the user to enter his/her email.
///
/// On tap next, user is sent to login in the email
/// is known by the server and to signup in the
/// opposite case.
///
struct CredentialsView: View {

  @State var showLogInSignUp = false

  var body: some View {
    VStack {
      StartingLogoItem()

      Spacer()

      CredentialsInput(showLogInSignUp: $showLogInSignUp)

      CredentialsButtons(showLogInSignUp: $showLogInSignUp)
        .padding(8)
    }
    .padding(.horizontal, 40)
    .animation(.spring(response: 0.5, dampingFraction: 0.55))
  }
}

// MARK: - Previews
struct CredentialsView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CredentialsView()

      CredentialsView()
        .preferredColorScheme(.dark)
    }
  }
}
