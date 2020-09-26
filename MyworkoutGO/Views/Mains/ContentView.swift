//
//  ContentView.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: ContentView
/// Root view of all existing SwiftUI views
/// at app lauch.
///
/// Handling either to show the credentials at
/// first connection or the tab bar views when
/// user already logged in.
///
struct ContentView: View {

  @ObservedObject var viewModel = CredentialsViewModel()

  var body: some View {
    ZStack {
      if !viewModel.isLoggedIn {
        CredentialsView()
      }
      else {
        TabView {
          ProfileView()
            .tabItem {
              Image.profile
              Text(Localized.profile)
            }
        }
      }
    }
    .environmentObject(viewModel)
    .onAppear {
      viewModel.fetchUserDefaults()
    }
  }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()

      ContentView()
        .preferredColorScheme(.dark)
    }
  }
}
