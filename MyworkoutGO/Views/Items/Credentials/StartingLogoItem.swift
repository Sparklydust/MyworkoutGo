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

  @EnvironmentObject var viewModel: CredentialsViewModel

  var body: some View {
    VStack(spacing: 8) {
      Image.logo
        .resizable()
        .frame(width: 120, height: 100, alignment: .center)
        .scaledToFit()
        .padding()

      Text(viewModel.logoTitle)
        .font(.title)

      Text(viewModel.logoLabel)
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
      StartingLogoItem()

      StartingLogoItem()
        .preferredColorScheme(.dark)
    }
  }
}
