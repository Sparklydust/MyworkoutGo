//
//  MyworkoutGOApp.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

@main
struct MyworkoutGOApp: App {

  var user = User()
  var credentialsViewModel = CredentialsViewModel()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(user)
        .environmentObject(credentialsViewModel)
    }
  }
}
