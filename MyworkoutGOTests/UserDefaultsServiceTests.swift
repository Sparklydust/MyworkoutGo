//
//  UserDefaultsServiceTests.swift
//  MyworkoutGOTests
//
//  Created by Roland Lariotte on 24/09/2020.
//

import XCTest
@testable import MyworkoutGO

class UserDefaultsServiceTests: XCTestCase {

  var sut: UserDefaultsService!
  var mockUserDefaultsContainer: MockUserDefaultsContainer!

  override func setUpWithError() throws {
    try super.setUpWithError()
    mockUserDefaultsContainer = MockUserDefaultsContainer()
    sut = UserDefaultsService(userDefaultsContainer: mockUserDefaultsContainer)
  }

  override func tearDownWithError() throws {
    sut = nil
    mockUserDefaultsContainer = nil
    try super.tearDownWithError()
  }

  func testUserDefaultsService_saveUserLoggedInValue_returnTrue() throws {
    sut.isLoggedIn = true

    let userLoggedIn = sut.isLoggedIn

    XCTAssertEqual(true, userLoggedIn)
  }

  func testUserDefaultsService_saveUserLoggedOutValue_returnFalse() throws {
    sut.isLoggedIn = false

    let userLoggedIn = sut.isLoggedIn

    XCTAssertEqual(false, userLoggedIn)
  }

  func testUserDefaultsService_saveUserEmailValue_returnUserSavedEmail() throws {
    sut.userEmail = "test@test.com"

    let userEmail = sut.userEmail
    let expected = "test@test.com"

    XCTAssertEqual(expected, userEmail)
  }

  func testUserDefaultsService_saveUserGenderValue_returnUserSavedGender() throws {
    sut.userGender = Gender.male

    let userGender = sut.userGender
    let expected = Gender.male

    XCTAssertEqual(expected, userGender)
  }
}
