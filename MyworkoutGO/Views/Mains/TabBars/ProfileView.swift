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
  
  @EnvironmentObject var viewModel: CredentialsViewModel
  
  var body: some View {
    VStack {
      ProfilePhotoItem()
        .frame(height: 260)
      
      List {
        ProfileCell(title: Localized.email,
                    text: Text(viewModel.user.email))
        
        ProfileCell(title: Localized.gender,
                    text: viewModel.user.gender == .male
                      ? Text(Localized.male)
                      : Text(Localized.female))
      }
      Spacer()
      
      LogOutButton()
    }
    .environmentObject(viewModel)
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
