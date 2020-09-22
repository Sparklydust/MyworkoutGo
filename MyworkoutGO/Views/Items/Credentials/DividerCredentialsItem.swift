//
//  DividerCredentialsItem.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: DividerCredentialsItem
/// Credentials TextField divider with gradient
///
struct DividerCredentialsItem: View {

  var body: some View {
    Rectangle()
      .frame(height: 1)
      .foregroundColor(.clear)
      .background(LinearGradient(gradient: Gradient(colors: [.accentColor, .purple$]),
                                 startPoint: .leading, endPoint: .trailing))
  }
}

/// MARK: - Previews
struct DividerCredentialsItem_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      DividerCredentialsItem()

      DividerCredentialsItem()
        .preferredColorScheme(.dark)
    }
  }
}
