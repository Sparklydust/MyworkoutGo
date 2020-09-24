//
//  CredentialsButtons.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: CredentialsButtons
/// Display options to user to continue the
/// credentials processus or cancelling it.
///
struct CredentialsButtons: View {

  @EnvironmentObject var viewModel: CredentialsViewModel

  var body: some View {
    HStack {
      Button(action: { viewModel.cancelButtonAction() }) {
        HStack {
          Image.back
            .resizable()
            .frame(width: 24, height: 24)

          Text(Localized.cancel)
            .font(.callout)

        }
        .foregroundColor(.gray)
      }

      Spacer()

      Button(action: { viewModel.nextButtonAction() }) {
        HStack {
          Text(viewModel.nextButtonName)
            .font(.callout)

          Image.next
            .resizable()
            .frame(width: 24, height: 24)
        }
        .foregroundColor(.accentColor)
      }
      .disabled(viewModel.disableButton)
    }
  }
}

// MARK: - Previews
struct CredentialsButtons_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CredentialsButtons()

      CredentialsButtons()
        .preferredColorScheme(.dark)
    }
  }
}
