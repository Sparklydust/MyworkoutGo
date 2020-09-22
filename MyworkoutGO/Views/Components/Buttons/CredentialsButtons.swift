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

  @Binding var name: String

  var body: some View {
    HStack {
      Button(action: { }) {
        HStack {
          Image.back
            .resizable()
            .frame(width: 24, height: 24)

          Text("Cancel")
            .font(.callout)

        }
        .foregroundColor(.gray)
      }

      Spacer()

      Button(action: { }) {
        HStack {
          Text(name)
            .font(.callout)

          Image.next
            .resizable()
            .frame(width: 24, height: 24)
        }
        .foregroundColor(.accentColor)
      }
    }
  }
}

// MARK: - Previews
struct CredentialsButtons_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CredentialsButtons(name: .constant("Next"))

      CredentialsButtons(name: .constant("Log in"))
    }
  }
}