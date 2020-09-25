//
//  MaleTickBox.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 25/09/2020.
//

import SwiftUI

//  MARK: MaleTickBox
/// Credentials tick box for user to choose male as gender.
///
struct MaleTickBox: View {

  @EnvironmentObject var viewModel: CredentialsViewModel

  var body: some View {
    HStack {
      Button(action: { viewModel.genderSelected(.male) }) {
        Image(systemName: viewModel.maleSelected
                ? "checkmark.circle.fill"
                : "circle")
          .foregroundColor(.purple$)
      }
      Text(Localized.male)
    }
    .padding(.horizontal, 16)
  }
}

// MARK: - Previews
struct MaleTickBox_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      MaleTickBox()

      MaleTickBox()
        .preferredColorScheme(.dark)
    }
  }
}
