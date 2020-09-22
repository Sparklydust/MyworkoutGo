//
//  ProfilePhotoItem.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: ProfilePhotoItem
/// Item showing user photo with gradient background.
///
struct ProfilePhotoItem: View {

  @State var profilePicture = Image.profile

  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.clear)
        .background(LinearGradient(gradient: Gradient(colors: [.accentColor, .purple$]),
                                   startPoint: .topLeading, endPoint: .bottomTrailing))

      VStack {
        Text(Localized.profile)
          .font(.title)

        profilePicture
          .resizable()
          .frame(width: 120, height: 120, alignment: .center)
          .aspectRatio(contentMode: .fill)
          .clipShape(Circle())
        Spacer()
      }
      .padding(.top, 56)
      .foregroundColor(.white)
    }
    .edgesIgnoringSafeArea(.top)
  }
}

// MARK: - Previews
struct ProfilePhotoItem_Previews: PreviewProvider {
  static var previews: some View {
    ProfilePhotoItem()
  }
}
