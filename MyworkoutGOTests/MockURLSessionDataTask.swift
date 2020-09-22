//
//  MockURLSessionDataTask.swift
//  MyworkoutGOTests
//
//  Created by Roland Lariotte on 22/09/2020.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
  private let closure: () -> Void

  init(closure: @escaping () -> Void) {
    self.closure = closure
  }

  override func resume() {
    closure()
  }
}
