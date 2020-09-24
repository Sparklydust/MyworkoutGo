//
//  ActivityIndicator.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 24/09/2020.
//

import SwiftUI

//  MARK: ActivityIndicator
/// Creating the UIKit Activity Controller for SwiftUI Views.
///
struct ActivityIndicator: UIViewRepresentable {

  let isAnimating: Bool

  func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    spinner.color = UIColor(named: "AccentColor")
    return spinner
  }

  func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
    isAnimating
      ? uiView.startAnimating()
      : uiView.stopAnimating()
  }
}
