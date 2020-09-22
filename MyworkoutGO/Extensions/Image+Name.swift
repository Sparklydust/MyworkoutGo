//
//  Image+Name.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import SwiftUI

//  MARK: Image
/// Extension to retrieve all images by name.
///
/// Images are either inside the Assets.xcassets
/// or are systemName image from the SFSymbol mac app.
///
extension Image {

  static let logo = Image("logo")

  static let back = Image(systemName: "chevron.left.circle.fill")

  static let next = Image(systemName: "chevron.right.circle.fill")

  static let profile = Image(systemName: "person.crop.circle")
}
