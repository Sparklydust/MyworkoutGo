//
//  String+RegEx.swift
//  MyworkoutGO
//
//  Created by Roland Lariotte on 24/09/2020.
//

import Foundation

// MARK: - IsValidEmailFormat
extension String {
    /// Check a string is a valid email format
    ///
    /// Using the email regular expression, this method
    /// define if an email address is a real one or not.
    ///
    /// - Returns: true if email format is valid
  ///
  func isValidEmailFormat() -> Bool {
    let emailRegEx = try? NSRegularExpression(
      pattern: "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
        + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
        + "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
        + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        + "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])",
      options: .caseInsensitive)

    let emailValidity = emailRegEx?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    return emailValidity
  }
}
