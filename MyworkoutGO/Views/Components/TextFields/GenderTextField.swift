//
//  GenderTextField.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 25/09/2020.
//

import SwiftUI

//  MARK: GenderTextField
/// Text field with tick boxes for user to choose
/// between female and male.
///
struct GenderTextField: View {
  var body: some View {
    VStack {
      HStack {
        FemaleTickBox()

        Spacer()

        MaleTickBox()

        Spacer()
      }
      DividerCredentialsItem()
    }
  }
}

// MARK: - Previews
struct GenderTextField_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      GenderTextField()

      GenderTextField()
        .preferredColorScheme(.dark)
    }
  }
}
