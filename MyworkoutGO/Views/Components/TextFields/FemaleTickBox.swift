//
//  FemaleTickBox.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 25/09/2020.
//

import SwiftUI

//  MARK: FemaleTickBox
/// Credentials tick box for user to choose female as gender.
///
struct FemaleTickBox: View {

  @EnvironmentObject var viewModel: CredentialsViewModel

  var body: some View {
    HStack {
      Button(action: { viewModel.genderSelected(.female) }) {
        Image(systemName: viewModel.femaleSelected
                ? "checkmark.circle.fill"
                : "circle")
          .foregroundColor(.accentColor)
      }
      Text(Localized.female)
    }
    .padding(.horizontal, 16)
  }
}

// MARK: - Previews
struct FemaleTickBox_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      FemaleTickBox()

      FemaleTickBox()
        .preferredColorScheme(.dark)
    }
  }
}
