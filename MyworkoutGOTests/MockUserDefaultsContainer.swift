//
//  MockUserDefaultsContainer.swift
//  MyworkoutGOTests
//
//  Created by Roland Lariotte on 24/09/2020.
//

import Foundation
@testable import MyworkoutGO

class MockUserDefaultsContainer: UserDefaultsProtocol {

  var isLoggedIn = false

  var userEmail = String()

  var userGender: Gender?
}
