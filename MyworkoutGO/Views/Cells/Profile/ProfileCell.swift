//
//  ProfileCell.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: ProfileCell
/// Cell populated in the ProfileView List.
///
struct ProfileCell: View {

  var title: LocalizedStringKey
  var text: String

  var body: some View {
    HStack {
      Text(title)

      Spacer()
      Text(text)
        .foregroundColor(.secondary)
    }
    .padding(.vertical, 8)
  }
}

// MARK: - Previews
struct ProfileCell_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ProfileCell(title: Localized.email, text: "test@test.com")

      ProfileCell(title: Localized.gender, text: "Female")
        .preferredColorScheme(.dark)
    }
  }
}
