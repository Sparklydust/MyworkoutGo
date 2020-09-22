//
//  FakeResponseData.swift
//  MyworkoutGOTests
//
//  Created by Roland Lariotte on 22/09/2020.
//

import Foundation

class FakeResponseData {

  static let response200OK = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil)!

  static let responseKO = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                          statusCode: 500,
                                          httpVersion: nil,
                                          headerFields: nil)!

  class RessourceError: Error {}
  static let error = RessourceError()

  static var liveRatesCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let accountsURL = bundle.url(forResource: "accounts", withExtension: "json")
    let accountsData = try! Data(contentsOf: accountsURL!)
    return accountsData
  }

  static let accountsIncorrectData = "error".data(using: .utf8)!
}
