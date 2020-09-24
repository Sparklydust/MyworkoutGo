//
//  LogOutButton.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: LogOutButton
/// Profile button for user to log out.
///
struct LogOutButton: View {

  @EnvironmentObject var viewModel: CredentialsViewModel

  var body: some View {
    Button(action: { self.viewModel.logOutAction() }) {
      Text(Localized.logOut)
        .font(.title2)
        .foregroundColor(.white)
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
    }
    .background(Color.accentColor)
    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    .padding(.horizontal, 40)
    .padding(.vertical)
  }
}

// MARK: - Previews
struct LogOutButton_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LogOutButton()

      LogOutButton()
        .preferredColorScheme(.dark)
    }
  }
}
