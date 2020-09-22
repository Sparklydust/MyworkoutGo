//
//  Published+Codable.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import Foundation

//  MARK: Published+Codable

/// Decodable
///
/// Decode json for @Publisher value in models
///
extension Published: Decodable where Value: Codable {
  public init(from decoder: Decoder) throws {
    let decoded = try Value(from: decoder)
    self = Published(initialValue: decoded)
  }
}

/// Encodable
///
/// Encode into json @Publisher value in models
///
extension Published: Encodable where Value: Codable {
  public func encode(to encoder: Encoder) throws {

    let mirror = Mirror(reflecting: self)

    if let childValue = mirror
      .children
      .first(where: { $0.label == "value" }) {

      if let value = childValue.value as? Encodable {
        do {
          try value.encode(to: encoder)
          return
        }
        catch let error {
          assertionFailure("\(self) \(error)")
        }
      }
    }
  }
}
