//
//  Gender+Codable.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 22/09/2020.
//

import Foundation

//  MARK: Gender+Codable
/// Setup Gender enumaration to be Codable.
///
extension Gender: Codable {

  enum Key: CodingKey {
    case rawValue
  }

  enum CodingError: Error {
    case unknownValue
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Key.self)
    let rawValue = try container.decode(Int.self, forKey: .rawValue)

    switch rawValue {
    case 0:
      self = .male
    case 1:
      self = .female
    case 2:
      self = .unknow
    default:
      throw CodingError.unknownValue
    }
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Key.self)

    switch self {
    case .male:
      try container.encode(0, forKey: .rawValue)
    case .female:
      try container.encode(1, forKey: .rawValue)
    case .unknow:
      try container.encode(2, forKey: .rawValue)
    }
  }
}
