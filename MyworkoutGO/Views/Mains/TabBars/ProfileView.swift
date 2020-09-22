//
//  ProfileView.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: ProfileView
/// Classic Profile view for tab bar.
///
struct ProfileView: View {

  @State var email = "registered@email.com"
  @State var gender = "Male"

  var body: some View {
    VStack {
      ProfilePhotoItem()
        .frame(height: 260)

      List {
        ProfileCell(title: Localized.email, text: email)

        ProfileCell(title: Localized.gender, text: gender)
      }

      Spacer()

      LogOutButton()
    }
  }
}

// MARK: - Previews
struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ProfileView()

      ProfileView()
        .preferredColorScheme(.dark)
    }
  }
}
