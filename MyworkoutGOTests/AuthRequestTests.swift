//
//  AuthRequestTests.swift
//  MyworkoutGOTests
//
//  Created by Roland Lariotte on 22/09/2020.
//

import MyworkoutGO
import XCTest
import Combine

class AuthRequestTests: XCTestCase {

  var expectation: XCTestExpectation!
  var subscriptions: Set<AnyCancellable>!

  override func setUpWithError() throws {
    try super.setUpWithError()
    expectation = XCTestExpectation()
    subscriptions = Set<AnyCancellable>()
  }

  override func tearDownWithError() throws {
    subscriptions = []
    expectation = nil
    try super.tearDownWithError()
  }
}
