//
//  StartingLogoItem.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: StartingLogo
/// Logo and text for the CredentialsView
///
struct StartingLogoItem: View {

  @Binding var text: String

  var body: some View {
    VStack(spacing: 8) {
      Image.logo
        .resizable()
        .frame(width: 120, height: 100, alignment: .center)
        .scaledToFit()
        .padding()

      Text("Myworkout GO")
        .font(.title)

      Text(text)
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
    .lineLimit(1)
    .minimumScaleFactor(0.5)
    .padding(.top, 80)
  }
}

// MARK: - Previews
struct StartingLogoItem_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      StartingLogoItem(text: .constant("Start by entering your email address"))

      StartingLogoItem(text: .constant("Enter your password to log in"))
        .preferredColorScheme(.dark)
    }
  }
}
