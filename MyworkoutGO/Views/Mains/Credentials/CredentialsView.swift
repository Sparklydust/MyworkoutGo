//
//  CredentialsView.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: CredentialsView
/// View offering the user to enter his/her email.
///
/// On tap next, user is sent to login in the email
/// is known by the server and to signup in the
/// opposite case.
///
struct CredentialsView: View {
  
  @EnvironmentObject var viewModel: CredentialsViewModel
  
  var body: some View {
    ZStack(alignment: .center) {
      VStack {
        StartingLogoItem()
        
        Spacer()
        
        CredentialsInput()
        
        CredentialsButtons()
          .padding(8)
      }
      .environmentObject(viewModel)
      .padding(.horizontal, 40)
      .animation(.spring(response: 0.5, dampingFraction: 0.55))
      
      ActivityIndicator(isAnimating: viewModel.isLoading)
    }
    .allowsHitTesting(viewModel.isLoading ? false : true)
    .onAppear { viewModel.readUserInput() }
    .alert(isPresented: $viewModel.showCredentialsAlert) {
      self.viewModel.credentialsAlertView()
    }
  }
}

// MARK: - Previews
struct CredentialsView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CredentialsView()
      
      CredentialsView()
        .preferredColorScheme(.dark)
    }
  }
}
